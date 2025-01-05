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
TARGET   = $(TARGET_DIR)/basics.exe

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
	@$(ECHO) "Usage: make all|build|clean|help|lint|run|test"
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

PROJECT_NAME    ?= $(shell basename $(CURDIR))
PROJECT_URL     ?= https://github.com/$(USERNAME)/graalvm-examples
PROJECT_VERSION ?= 1.0.0

DOC_OPTS_FILE    = $(TARGET_DIR)/javadoc_opts.txt
DOC_SOURCES_FILE = $(TARGET_DIR)/javadoc_sources.txt

$(DOC_TARGET): $(SOURCES)
	[ -d "$(DOC_TARGET_DIR)" ] || "$(MKDIR)" -p "$(DOC_TARGET_DIR)"
	@$(ECHO) -d "$(DOC_TARGET_DIR)" -doctitle "$(PROJECT_NAME)" -footer "$(PROJECT_URL)" -top "$(PROJECT_VERSION)" > "$(DOC_OPTS_FILE)"
	@$(ECHO) $(SOURCES) > "$(DOC_SOURCES_FILE)"
	"$(JAVADOC)" "@$(DOC_OPTS_FILE)" "@$(DOC_SOURCES_FILE)"
	@$(TOUCH) "$(DOC_TARGET)"

doc: $(DOC_TARGET)

##############################################################################
## lint rules

## https://github.com/checkstyle/checkstyle/releases
CHECKSTYLE_VERSION = 10.21.1
CHECKSTYLE_DIR     = $(HOME)/.checkstyle

CHECKSTYLE_SOURCES = $(shell $(FIND) "$(SOURCE_DIR)" -type f -name "*.java")
CHECKSTYLE_TARGET  = $(TARGET_DIR)/.latest-lint

## "checkstyle-all" version not available from Maven Central
JAR_NAME = checkstyle-$(CHECKSTYLE_VERSION)-all.jar
JAR_URL  = https://github.com/checkstyle/checkstyle/releases/download/checkstyle-$(CHECKSTYLE_VERSION)/$(JAR_NAME)
JAR_FILE = $(CHECKSTYLE_DIR)/$(JAR_NAME)
XML_FILE = $(CHECKSTYLE_DIR)/graal_checks.xml

lint: $(JAR_FILE) $(CHECKSTYLE_TARGET)

$(JAR_FILE):
	[ -d "$(CHECKSTYLE_DIR)" ] || "$(MKDIR)" -p "$(CHECKSTYLE_DIR)"
	"$(CURL)" --insecure --silent --location --output "$(JAR_FILE)" $(JAR_URL)

$(CHECKSTYLE_TARGET): $(CHECKSTYLE_SOURCES)
	"$(JAVA)" -jar "$(JAR_FILE)" -c=$(XML_FILE) $^

##############################################################################
## phony

.PHONY: all build clean doc help lint run

.SUFFIXES:
.SUFFIXES: .exe .go
