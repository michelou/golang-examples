// +build mage

package main

import (
    "errors"
	"os"
	"os/exec"
    "path/filepath"
    "runtime"
    "strings"

    // mg contains helpful utility functions, like Deps
	"github.com/magefile/mage/mg"
)

var sources []string
var targetFile string
var installFile string

func init() {
    targetDir := filepath.Join(".", "target")
    sources, _ = filepath.Glob("./src/main/*.go")

    targetName := "hello"
    if (runtime.GOOS == "windows") { targetName += ".exe" }

    targetFile = filepath.Join(targetDir, targetName)
    installFile = filepath.Join(os.Getenv("GOBIN"), targetName)
}

// Default target to run when none is specified
// If not set, running mage will list available targets
// var Default = Build

// Build Generate application executable
func Build() error {
    goPath, err := exec.LookPath("go")
    if err != nil { return err } //log.Fatal(err) }
	cmd := exec.Command(goPath, "build", "-o", targetFile, strings.Join(sources, " "))
	return cmd.Run()
}

// Run the generated executable
func Run(what string) error {
     mg.Deps(Build)
     _, err := os.Stat(targetFile); errors.Is(err, os.ErrNotExist)
     if err != nil { return err } //log.Fatal(err) }
     binFile, err := filepath.Abs(targetFile)
     if err != nil { return err } //log.Fatal(err) }
     cmd := exec.Command(binFile)
     cmd.Stdout = os.Stdout
     cmd.Stderr = os.Stderr
     return cmd.Run()
}

// Install Install the generated executable into the GOBIN directory
func Install() error {
	mg.Deps(Build)
	return os.Rename(targetFile, installFile)
}

// Clean Delete the generated executable
func Clean() {
	os.RemoveAll(targetFile)
}
