// +build mage

package main

import (
	"errors"
    "fmt"
    "io/ioutil"
	"os"
	"os/exec"
    "path/filepath"
    "runtime"
    "strings"

    // mg contains helpful utility functions, like Deps
	"github.com/magefile/mage/mg"
)

var sources []string
var outputFile string
var installFile string

func init() {
    targetDir := filepath.Join(".", "target")
    sources, _ = filepath.Glob("./src/main/*.go")

    targetName := "first-class-funcs"
    if (runtime.GOOS == "windows") { targetName += ".exe" }

    outputFile = filepath.Join(targetDir, targetName)
    installFile = filepath.Join(os.Getenv("GOBIN"), targetName)
}

// Default target to run when none is specified
// If not set, running mage will list available targets
// var Default = Build

// Build Generate application executable
func Build() error {
	if mg.Verbose() { fmt.Println("Building...") }
    goPath, err := exec.LookPath("go")
    if err != nil { return err } //log.Fatal(err) }
	cmd := exec.Command(goPath, "build", "-o", outputFile, strings.Join(sources, " "))
	return cmd.Run()
}

// Run Run the generated executable
func Run(what string) error {
     mg.Deps(Build)
     _, err := os.Stat(outputFile); errors.Is(err, os.ErrNotExist)
     if err != nil { return err } //log.Fatal(err) }
     binFile, err := filepath.Abs(outputFile)
     if err != nil { return err } //log.Fatal(err) }
     if mg.Verbose() { fmt.Println("Running "+ outputFile) }
     cmd := exec.Command(binFile)
     cmd.Stdout = os.Stdout
     cmd.Stderr = os.Stderr
     return cmd.Run()
}

func copyFile(src string, dst string) error {
    nBytes, err := ioutil.ReadFile(src)
    if err != nil { return err }
    return ioutil.WriteFile(dst, nBytes, 755)
}

// Install Install the generated executable into the GOBIN directory
func Install() error {
	mg.Deps(Build)
	if mg.Verbose() { fmt.Println("Installing...") }
	return copyFile(outputFile, installFile)
}

// Clean Delete the generated executable
func Clean() {
	if mg.Verbose() { fmt.Println("Cleaning...") }
	os.RemoveAll(outputFile)
}
