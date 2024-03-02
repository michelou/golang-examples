package main

import (
	"fmt"
	"math"
)

func sqrt(x float64) string {
	if x < 0 {
		return sqrt(-x) + "i"
	}
	return fmt.Sprint(math.Sqrt(x))
}

func main() {
	// http://127.0.0.1:3999/flowcontrol/1
	// Unlike other languages like C, Java, or JavaScript there are no parentheses
	// surrounding the three components of the for statement and the braces { } are
	// always required.
	sum := 0
	for i := 0; i < 10; i++ {
		sum += i
	}
	fmt.Println(sum)

	// http://127.0.0.1:3999/flowcontrol/2
	sum = 1
	for sum < 1000 {
		sum += sum
	}
	fmt.Println(sum)

	// http://127.0.0.1:3999/flowcontrol/3
	sum = 1
	for sum < 1000 {
		sum += sum
	}
	fmt.Println(sum)

	// http://127.0.0.1:3999/flowcontrol/5
	fmt.Println(sqrt(2), sqrt(-4))
}
