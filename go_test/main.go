package main

import "fmt"

func fib(n int) int {
	if n == 0 {
		return 0
	}
	if n == 1 {
		return 1
	}

	return fib(n-1) + fib(n-2)
}

func newFib(n int)int {
	data := make([]int, n+1)
	if n == 0 {
		return 0
	}
	if n == 1 {
		return 1
	}
	data [0] = 0
	data [1] = 1
	for i:=2; i<=n; i++ {
		data[i] = data[i-1] + data[i-2]
	}
	return data[n]
}

func main() {
	fmt.Printf("fib(11)=%d", fib(11))
}
