// +build mage

package main

import (
	"os"
	"os/exec"
    "path/filepath"
    "runtime"
    "strings"

	"github.com/magefile/mage/mg" // mg contains helpful utility functions, like Deps
)

var sources []string
var targetDir string
var targetFile string
var installFile string

func init() {
    targetDir = filepath.Join(".", "target")
    sources, _ = filepath.Glob("./src/main/*.go")

    targetName := "flowcontrol"
    if (runtime.GOOS == "windows") { targetName += ".exe" }

    targetFile = filepath.Join(targetDir, targetName)
    installFile = filepath.Join(os.Getenv("GOBIN"), targetName)
}

// Default target to run when none is specified
// If not set, running mage will list available targets
// var Default = Build

func Build() error {
    goPath, err := exec.LookPath("go")
    if err != nil { return err }
	cmd := exec.Command(goPath, "build", "-o", targetFile, strings.Join(sources, " "))
	return cmd.Run()
}

// A custom install step if you need your bin someplace other than go/bin
func Install() error {
	mg.Deps(Build)
	return os.Rename(targetFile, installFile)
}

// Clean up after yourself
func Clean() {
	os.RemoveAll(targetFile)
}
