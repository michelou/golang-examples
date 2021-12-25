package main

import (
	"fmt"
	"math"
	"math/cmplx"
	"math/rand"
)

// func add(x int, y int) int {
// http://127.0.0.1:3999/basics/5
func add(x, y int) int {
	return x + y
}

func swap(x, y string) (string, string) {
	return y, x
}

// Function `split` returns a pair of (computed) values.
func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}

// If an initializer is present, the type can be omitted;
// the variable will take the type of the initializer.
var c, python, java = true, false, "no!"

// Some basic types
var (
	ToBe   bool       = false
	MaxInt uint64     = 1<<64 - 1
	z      complex128 = cmplx.Sqrt(-5 + 12i)
	dArrow rune       = '⇒'
)

// Pi number with 2-digit precision
const Pi = 3.14

// Main function presenting Go basics.
func main() {
	fmt.Println("My favorite number is", rand.Intn(10))

	// http://127.0.0.1:3999/basics/3
	fmt.Println(math.Pi) // pi --> Pi

	// http://127.0.0.1:3999/basics/4
	fmt.Println(add(42, 13))

	// http://127.0.0.1:3999/basics/6
	a, b := swap("hello", "world")
	fmt.Println(a, b)

	// http://127.0.0.1:3999/basics/7
	fmt.Println(split(17))

	// http://127.0.0.1:3999/basics/8
	var i int = 2
	fmt.Println(i, c, python, java)

	// http://127.0.0.1:3999/basics/11
	fmt.Printf("Type: %T Value: %v\n", ToBe, ToBe)
	fmt.Printf("Type: %T Value: %v\n", MaxInt, MaxInt)
	fmt.Printf("Type: %T Value: %v\n", z, z)
	fmt.Printf("Type: %T Value: %v\n", dArrow, dArrow)

	// http://127.0.0.1:3999/basics/15
	const World = "世界"
	fmt.Println("Hello", World)
	fmt.Println("Happy", Pi, "Day")

	const Truth = true
	fmt.Println("Go rules?", Truth)
}
