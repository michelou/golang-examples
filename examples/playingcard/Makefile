##
## Copyright (c) 2018-2025 Stéphane Micheloud
##
## Licensed under the MIT License.
##
##############################################################################

include ../Makefile.inc

SOURCE_DIR  = src
TARGET_DIR  = target

##############################################################################
## main rules

SOURCES  = $(shell $(FIND) "$(SOURCE_DIR)/main" -type f -name "*.go")
TARGET   = $(TARGET_DIR)/hello.exe

GO_OPTS  = -o "$(TARGET)"

all: build

build: $(TARGET)

$(TARGET): $(SOURCES)
	[ -d "$(TARGET_DIR)" ] || "$(MKDIR)" -p "$(TARGET_DIR)"
	@$(ECHO) "$(GO) build $(GO_OPTS) $^"
	"$(GO)" build $(GO_OPTS) $<
	@$(TOUCH) "$(TARGET)"

clean:
	"$(RM)" -rf "$(TARGET_DIR)"

run: build
	"$(TARGET)"

help:
	@$(ECHO) "Usage: make all|build|clean|help|lint|run"
	@$(ECHO) ""
	@$(ECHO) "   Subcommands:"
	@$(ECHO) "     all    alias for build"
	@$(ECHO) "     build  compile Go source files"
	@$(ECHO) "     clean  delete generated files"
	@$(ECHO) "     help   print this help message"
	@$(ECHO) "     lint   analyze Go source files with CheckStyle"
	@$(ECHO) "     run    execute main program \"$(MAIN_CLASS)\""

##############################################################################
## doc rules

DOC_TARGET_DIR = $(TARGET_DIR)/docs
DOC_TARGET     = $(DOC_TARGET_DIR)/.latest-build

$(DOC_TARGET): $(SOURCES)
	[ -d "$(DOC_TARGET_DIR)" ] || "$(MKDIR)" -p "$(DOC_TARGET_DIR)"
	@$(TOUCH) "$(DOC_TARGET)"

doc: $(DOC_TARGET)

##############################################################################
## lint rules

GOLINT_OPTS=-set_exit_status

LINT_TARGET = $(TARGET_DIR)/.latest-lint

$(LINT_TARGET):
	@$(TOUCH) "$(LINT_TARGET)"

lint: $(LINT_TARGET)
	pushd "$(SOURCE_DIR)/main/go" && "$(GO)" fmt && popd
	"$(GOLINT)" $(GOLINT_OPTS) "$(SOURCE_DIR)/main/go"

##############################################################################
## test rules

##############################################################################
## phony

.PHONY: all build clean doc help lint run test

.SUFFIXES:
.SUFFIXES: .exe .go
