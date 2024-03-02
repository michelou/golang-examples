#!/usr/bin/env bash
#
# Copyright (c) 2018-2024 Stéphane Micheloud
#
# Licensed under the MIT License.
#

##############################################################################
## Subroutines

getHome() {
    local source="${BASH_SOURCE[0]}"
    while [[ -h "$source" ]]; do
        local linked="$(readlink "$source")"
        local dir="$( cd -P $(dirname "$source") && cd -P $(dirname "$linked") && pwd )"
        source="$dir/$(basename "$linked")"
    done
    ( cd -P "$(dirname "$source")" && pwd )
}

debug() {
    local DEBUG_LABEL="[46m[DEBUG][0m"
    $DEBUG && echo "$DEBUG_LABEL $1" 1>&2
}

warning() {
    local WARNING_LABEL="[46m[WARNING][0m"
    echo "$WARNING_LABEL $1" 1>&2
}

error() {
    local ERROR_LABEL="[91mError:[0m"
    echo "$ERROR_LABEL $1" 1>&2
}

# use variables EXITCODE, TIMER_START
cleanup() {
    [[ $1 =~ ^[0-1]$ ]] && EXITCODE=$1

    if $TIMER; then
        local TIMER_END=$(date +'%s')
        local duration=$((TIMER_END - TIMER_START))
        echo "Total execution time: $(date -d @$duration +'%H:%M:%S')" 1>&2
    fi
    debug "EXITCODE=$EXITCODE"
    exit $EXITCODE
}

args() {
    [[ $# -eq 0 ]] && HELP=true && return 1

    for arg in "$@"; do
        case "$arg" in
        ## options
        -debug)       DEBUG=true ;;
        -help)        HELP=true ;;
        -timer)       TIMER=true ;;
        -verbose)     VERBOSE=true ;;
        -*)
            error "Unknown option $arg"
            EXITCODE=1 && return 0
            ;;
        ## subcommands
        clean)   CLEAN=true ;;
        compile) COMPILE=true ;;
        doc)     DOC=true ;;
        help)    HELP=true ;;
        run)     COMPILE=true && RUN=true ;;
        *)
            error "Unknown subcommand $arg"
            EXITCODE=1 && return 0
            ;;
        esac
    done
    debug "Options    : PROJECT_CONFIG=$PROJECT_CONFIG TIMER=$TIMER TOOLSET=$TOOLSET VERBOSE=$VERBOSE"
    debug "Subcommands: CLEAN=$CLEAN COMPILE=$COMPILE DOC=$DOC HELP=$HELP RUN=$RUN"
    debug "Variables  : GIT_HOME=$GIT_HOME"
    debug "Variables  : GOBIN=$GOBIN"
    debug "Variables  : GOPATH=$GOPATH"
    debug "Variables  : GOROOT=$GOROOT"
    # See http://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/
    $TIMER && TIMER_START=$(date +"%s")
}

help() {
    cat << EOS
Usage: $BASENAME { <option> | <subcommand> }

  Options:
    -debug       print commands executed by this script
    -timer       print total execution time
    -verbose     print progress messages

  Subcommands:
    clean        delete generated files
    compile      compile C++ source files
    doc          generate HTML documentation with Doxygen
    help         print this help message
    run          execute the generated executable
EOS
}

clean() {
    if [[ -d "$TARGET_DIR" ]]; then
        if $DEBUG; then
            debug "rm -rf \"$TARGET_DIR\""
        elif $VERBOSE; then
            echo "Delete directory \"${TARGET_DIR/$ROOT_DIR\//}\"" 1>&2
        fi
        rm -rf "$TARGET_DIR"
        [[ $? -eq 0 ]] || ( EXITCODE=1 && return 0 )
    fi
    if [[ -f "$ROOT_DIR/CMakeCache.txt" ]]; then
        rm -f "$ROOT_DIR/CMakeCache.txt"
        [[ $? -eq 0 ]] || ( EXITCODE=1 && return 0 )
    fi
}

lint() {
    local golint_opts=""
    if $DEBUG; then
        debug "$GOLINT_CMD $golint_opts $SOURCE_DIR" 1>&2
    elif $VERBOSE; then
        echo "Analyze Go source files in directory \"${SOURCE_DIR/$ROOT_DIR\//}\"" 1>&2
    fi
    eval "\"$GOLINT_CMD\" $golint_opts $SOURCE_DIR"
    if [[ $? -ne 0 ]]; then
        error "Failed to check Go source files in directory \"${SOURCE_DIR/$ROOT_DIR\//}\""
        cleanup 1
    fi
}

compile() {
    local go_opts="-o \"$(mixed_path $EXE_FILE)\""
    local source_files=
    local n=0
    for f in $(find "$SOURCE_DIR/" -type f -name "*.go" 2>/dev/null); do
        source_files="$source_files \"$f\""
        n=$((n + 1))
    done
    if [[ $n -eq 0 ]]; then
        warning "No Go source file found"
        return 1
    fi
    local s=; [[ $n -gt 1 ]] && s="s"
    local n_files="$n Go source file$s"

    if $DEBUG; then
        debug "\"$GO_CMD\" build $go_opts $source_files"
    elif $VERBOSE; then
        echo "Generate executable \"${EXE_FILE/$ROOT_DIR\//}\"" 1>&2
    fi
    eval "\"$GO_CMD\" build $go_opts $source_files"
    if [[ $? -ne 0 ]]; then
        error "Failed to geenerate executable \"${EXE_FILE/$ROOT_DIR\//}\""
        cleanup 1
    fi
}

mixed_path() {
    if [[ -x "$CYGPATH_CMD" ]]; then
        $CYGPATH_CMD -am "$*"
    elif $mingw || $msys; then
        echo "$*" | sed 's|/|\\\\|g'
    else
        echo "$*"
    fi
}

doc() {
    local godoc_opts="-all -u"
    local source_files=
    local n=0
    for f in $(find "$SOURCE_DIR/" -type f -name "*.go" 2>/dev/null); do
        source_files="$source_files\"$f\" "
        n=$((n + 1))
    done
    if [[ $n -eq 0 ]]; then
        warning "No Go source file found"
        return 1
    fi
    local s=; [[ $n -gt 1 ]] && s="s"
    local n_files="$n Go source file$s"

    if $DEBUG; then
        debug "\"$GO_CMD\" doc $godoc_opts $source_files"
    elif $VERBOSE; then
       echo "Generate HTML documentation" 1>&2
    fi
    eval "\"$GO_CMD\" doc $godoc_opts $source_files"
    if [[ $? -ne 0 ]]; then
        error "Failed to generate HTML documentation" 1>&2
        cleanup 1
    fi
}

run() {
    if [[ ! -f "$EXE_FILE" ]]; then
        error "Executable \"${EXE_FILE/$ROOT_DIR\//}\" not found"
        cleanup 1
    fi
    if $DEBUG; then
        debug "$EXE_FILE"
    elif $VERBOSE; then
        echo "Execute \"${EXE_FILE/$ROOT_DIR\//}\"" 1>&2
    fi
    eval "$EXE_FILE"
    if [[ $? -ne 0 ]]; then
        error "Failed to execute \"${EXE_FILE/$ROOT_DIR\//}\"" 1>&2
        cleanup 1
    fi
}

##############################################################################
## Environment setup

BASENAME=$(basename "${BASH_SOURCE[0]}")

EXITCODE=0

ROOT_DIR="$(getHome)"

SOURCE_DIR="$ROOT_DIR/src"
SOURCE_MAIN_DIR="$SOURCE_DIR/main/go"
TARGET_DIR="$ROOT_DIR/target"
TARGET_DOCS_DIR="$TARGET_DIR/docs"

PROJECT_NAME=2-flowcontrol
EXE_FILE="$TARGET_DIR/$PROJECT_NAME.exe"

CLEAN=false
COMPILE=false
DEBUG=false
DOC=false
HELP=false
RUN=false
TIMER=false
VERBOSE=false

COLOR_START="[32m"
COLOR_END="[0m"

cygwin=false
mingw=false
msys=false
darwin=false
case "$(uname -s)" in
    CYGWIN*) cygwin=true ;;
    MINGW*)  mingw=true ;;
    MSYS*)   msys=true ;;
    Darwin*) darwin=true
esac
unset CYGPATH_CMD
PSEP=":"
TARGET_EXT=
if $cygwin || $mingw || $msys; then
    CYGPATH_CMD="$(which cygpath 2>/dev/null)"
	PSEP=";"
    TARGET_EXT=".exe"
    GO_CMD="$(mixed_path $GOROOT)/bin/go.exe"
    GOLINT_CMD="${mixed_path $GOBIN}/bin/golint.exe"
else
    GO_CMD=go
    GOLINT_CMD=golint
fi

PROJECT_NAME="$(basename $ROOT_DIR)"

args "$@"
[[ $EXITCODE -eq 0 ]] || cleanup 1

##############################################################################
## Main

$HELP && help && cleanup

if $CLEAN; then
    clean || cleanup 1
fi
if $COMPILE; then
    compile || cleanup 1
fi
if $DOC; then
    doc || cleanup 1
fi
if $RUN; then
    run || cleanup 1
fi
cleanup
