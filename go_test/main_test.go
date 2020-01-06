package main

import "testing"

func TestFib(t *testing.T) {
	f := fib(10)
	if f != 55 {
		t.Errorf("exptect fib(10)==55 got %d", f)
	}
	f = fib(11)
	if f != 89 {
		t.Errorf("exptect fib(10)==59 got %d", f)
	}
}

func TestNebFib(t *testing.T) {
	f := newFib(0)
	if f != 0 {
		t.Errorf("expected fib(0)==0 got %d", f)
	}
	f = newFib(1)
	if f != 1 {
		t.Errorf("expected fib(1)==1 got %d", f)
	}
	f = newFib(10)
	if f != 55 {
		t.Errorf("expected fib(10)==55 got %d", f)
	}
	f = newFib(11)
	if f != 89 {
		t.Errorf("expected fib(10)==59 got %d", f)
	}
}

func BenchmarkFib(b *testing.B) {
	for i := 0; i < b.N; i++ {
		fib(30)
	}
}

func BenchmarkNewFib(b *testing.B) {
	for i := 0; i < b.N; i++ {
		newFib(30)
	}
}
