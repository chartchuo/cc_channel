package main

import "testing"


func BenchmarkUpdate(b *testing.B) {
	for i := 0; i < b.N; i++ {
		update()
	}
}

func BenchmarkGoMutex(b *testing.B) {
	for i := 0; i < b.N; i++ {
		updateUsingGoMutex()
	}
}

func BenchmarkGoChannel(b *testing.B) {
	for i := 0; i < b.N; i++ {
		updateUsingGoChannel()
	}
}

