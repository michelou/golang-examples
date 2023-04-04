// +build mage

package main

import (
	"fmt"
    "io/ioutil"
	"os"
	"os/exec"
    "path/filepath"
    "runtime"
    "strings"

	"github.com/magefile/mage/mg" // mg contains helpful utility functions, like Deps
)

var sources []string
var outputFile string
var installFile string

func init() {
    targetDir := filepath.Join(".", "target")
    sources, _ = filepath.Glob("./src/main/*.go")

    targetName := "basics"
    if (runtime.GOOS == "windows") { targetName += ".exe" }

    outputFile = filepath.Join(targetDir, targetName)
    installFile = filepath.Join(os.Getenv("GOBIN"), targetName)
}

// Default target to run when none is specified
// If not set, running mage will list available targets
// var Default = Build

func Build() error {
	fmt.Println("Building...")
    goPath, err := exec.LookPath("go")
    if err != nil { return err } //log.Fatal(err) }
	cmd := exec.Command(goPath, "build", "-o", outputFile, strings.Join(sources, " "))
	return cmd.Run()
}

func copyFile(src string, dst string) error {
    nBytes, err := ioutil.ReadFile(src)
    if err != nil { return err }
    return ioutil.WriteFile(dst, nBytes, 755)
}

// A custom install step if you need your bin someplace other than go/bin
func Install() error {
	mg.Deps(Build)
	fmt.Println("Installing...")
	return copyFile(outputFile, installFile)
}

// Clean up after yourself
func Clean() {
	fmt.Println("Cleaning...")
	os.RemoveAll(outputFile)
}