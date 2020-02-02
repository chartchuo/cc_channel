package main

import (
	"flag"
	"os"
	"os/signal"
	"strings"
	"sync"
	"time"

	"github.com/nats-io/nats.go"
	"github.com/patrickmn/go-cache"
	log "github.com/sirupsen/logrus"
)

func waitForKill() {
	var endWaiter sync.WaitGroup
	endWaiter.Add(1)
	var signalChannel chan os.Signal
	signalChannel = make(chan os.Signal, 1)
	signal.Notify(signalChannel, os.Interrupt)
	go func() {
		<-signalChannel
		endWaiter.Done()
	}()
	endWaiter.Wait()
}

var verbose = flag.Bool("V", false, "Verbose mode.")
var testRequest = flag.Bool("t", false, "Send request message after store cache.")

func main() {
	flag.Parse()
	if *verbose {
		log.SetLevel(log.DebugLevel)
	} else {
		log.SetLevel(log.InfoLevel)
	}
	boardCache := cache.New(time.Hour, time.Minute)
	nc, err := nats.Connect("localhost")
	if err != nil {
		log.Fatal(err)
	}
	defer nc.Close()

	if _, err := nc.Subscribe("myBoard.*", func(m *nats.Msg) {
		id := strings.Split(m.Subject, ".")[1]
		boardCache.Set(id, m.Data, cache.DefaultExpiration)
		if *testRequest {
			log.Debugf("Request subject=%s", m.Subject)
			res, err := nc.Request("myBoardCache."+id, nil, time.Second*5)
			if err != nil {
				log.Fatal(err)
			}
			log.Debugf("Got response data=%s", res.Data)
		}

	}); err != nil {
		log.Fatal(err)
	}

	if _, err := nc.Subscribe("myBoardCache.*", func(m *nats.Msg) {
		id := strings.Split(m.Subject, ".")[1]
		if data, err := boardCache.Get(id); err == true {
			m.Respond(data.([]byte))
		}
		log.Debugf("Response Subject=%s", m.Subject)
	}); err != nil {
		log.Fatal(err)
	}

	log.Println("Server is ready")
	waitForKill()
}
