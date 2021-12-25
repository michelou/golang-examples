package main

import (
    "fmt"
    "test"
    "token"
    "util"
    "util/math"
)

func main() {
    x := util.PI
    fmt.Println("packages")
    fmt.Println(token.IDENT)
    fmt.Println(x)
    fmt.Printf("Sin(%f)=%f\n", x, math.Sin(x))
    test.Hello()
}
