package main

import (
   "logger"
   "os"
   "runtime"
)

const (
    VERSION = "0.13"
)

func main() {
    // time to use our logger, print version, processID and number of running process
    logger.Log.Printf("Server v%s pid=%d started with processes: %d", VERSION, os.Getpid(), runtime.GOMAXPROCS(runtime.NumCPU()))
}