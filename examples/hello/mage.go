// +build mage

package main

import (
	"fmt"
	"os"
	"os/exec"
    "path/filepath"
    "runtime"
    "strings"

	"github.com/magefile/mage/mg" // mg contains helpful utility functions, like Deps
)

var sources []string
var executable string
var installDir string
var targetDir string

func init() {
    parentDir := filepath.Dir(os.Args[0])
    fmt.Println("1111111111111 parentDir="+parentDir)
    targetDir = filepath.Join(parentDir, "target")
    fmt.Println("2222222222222 targetDir="+targetDir)
    if (runtime.GOOS == "windows") {
        sources, _ = filepath.Glob(".\\src\\*.go")
        executable = filepath.Join(targetDir, "hello.exe")
        installDir = "c:\\temp\\"
    } else {
        sources, _ = filepath.Glob("./src/*.go")
        executable = filepath.Join(targetDir, "hello")
        installDir = "/usr/bin/"
    }
}

// Default target to run when none is specified
// If not set, running mage will list available targets
// var Default = Build

func Build() error {
	fmt.Println("Building...")
	cmd := exec.Command("go", "build", "-o", executable, strings.Join(sources, " "))
	return cmd.Run()
}

// A custom install step if you need your bin someplace other than go/bin
func Install() error {
	mg.Deps(Build)
	fmt.Println("Installing...")
	return os.Rename("./" + executable, installDir + executable)
}

// Clean up after yourself
func Clean() {
	fmt.Println("Cleaning...")
	os.RemoveAll(executable)
}
