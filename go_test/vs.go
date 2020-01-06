package main

import "sync"

var data [100]int

func update() {
	for i := 0; i < 100000; i++ {
		data[i%100] = i
	}
}

var mux sync.Mutex

func updateUsingGoMutexRange(start, end int) {
	for i := start; i < end; i++ {
		mux.Lock()
		data[i%100] = i
		mux.Unlock()
	}
}

func updateUsingGoMutex() {
	for i := 0; i < 10; i++ {
		go updateUsingGoMutexRange(i*10000, (i+1)*10000)
	}
}

var ch = make(chan int)

func channelUpdater() {
	i := <-ch
	data[i%100] = i
}

func updateUsingGoChannelRange(start, end int) {
	for i := start; i < end; i++ {
		ch <- i
	}
}

func updateUsingGoChannel() {
	for i := 0; i < 10; i++ {
		go updateUsingGoChannelRange(i*10000, (i+1)*10000)
	}
}
