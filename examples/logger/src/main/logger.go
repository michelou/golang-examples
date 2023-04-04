package logger

import (
	"flag"
	"fmt"
	"log"
	"os"
	// "go/build"
)

var (
	Log *log.Logger
)

func init() {
	// set location of log file
	var logpath = "c:/temp/x_log.txt" // build.Default.GOPATH + "/logger_log.txt"
	fmt.Println("logpath=%s", logpath)
	flag.Parse()
	var file, err1 = os.Create(logpath)

	if err1 != nil {
		panic(err1)
	}
	Log = log.New(file, "", log.LstdFlags|log.Lshortfile)
	Log.Println("LogFile : " + logpath)
}
