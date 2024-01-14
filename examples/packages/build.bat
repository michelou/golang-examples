@echo off
setlocal enabledelayedexpansion

@rem only for interactive debugging !
set _DEBUG=0

@rem #########################################################################
@rem ## Environment setup

set _EXITCODE=0

call :env
if not %_EXITCODE%==0 goto end

call :args %*
if not %_EXITCODE%==0 goto end

@rem #########################################################################
@rem ## Main

if %_HELP%==1 (
    call :help
    exit /b !_EXITCODE!
)
if %_CLEAN%==1 (
    call :clean
    if not !_EXITCODE!==0 goto end
)
if %_COMPILE%==1 (
    call :compile
    if not !_EXITCODE!==0 goto end
)
if %_DOC%==1 (
    call :doc
    if not !_EXITCODE!==0 goto end
)
if %_RUN%==1 (
    call :run
    if not !_EXITCODE!==0 goto end
)

goto end

@rem #########################################################################
@rem ## Subroutines

@rem output parameters: _DEBUG_LABEL, _ERROR_LABEL, _WARNING_LABEL
:env
set _BASENAME=%~n0
set "_ROOT_DIR=%~dp0"

call :env_colors
set _DEBUG_LABEL=%_NORMAL_BG_CYAN%[%_BASENAME%]%_RESET%
set _ERROR_LABEL=%_STRONG_FG_RED%Error%_RESET%:
set _WARNING_LABEL=%_STRONG_FG_YELLOW%Warning%_RESET%:

set "_SOURCE_DIR=%_ROOT_DIR%src"
set "_TARGET_DIR=%_ROOT_DIR%target"
set "_TARGET_FILE=%_TARGET_DIR%\hello.exe"

if not exist "%GOROOT%\bin\go.exe" (
    echo %_ERROR_LABEL% Go installation not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_GO_CMD=%GOROOT%\bin\go.exe"

if not exist "%GOBIN%\golint.exe" (
    echo %_ERROR_LABEL% GoLint command not found ^(check GOBIN variable ^) 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_GOLINT_CMD=%GOBIN%\golint.exe"
goto :eof

:env_colors
@rem ANSI colors in standard Windows 10 shell
@rem see https://gist.github.com/mlocati/#file-win10colors-cmd
set _RESET=[0m
set _BOLD=[1m
set _UNDERSCORE=[4m
set _INVERSE=[7m

@rem normal foreground colors
set _NORMAL_FG_BLACK=[30m
set _NORMAL_FG_RED=[31m
set _NORMAL_FG_GREEN=[32m
set _NORMAL_FG_YELLOW=[33m
set _NORMAL_FG_BLUE=[34m
set _NORMAL_FG_MAGENTA=[35m
set _NORMAL_FG_CYAN=[36m
set _NORMAL_FG_WHITE=[37m

@rem normal background colors
set _NORMAL_BG_BLACK=[40m
set _NORMAL_BG_RED=[41m
set _NORMAL_BG_GREEN=[42m
set _NORMAL_BG_YELLOW=[43m
set _NORMAL_BG_BLUE=[44m
set _NORMAL_BG_MAGENTA=[45m
set _NORMAL_BG_CYAN=[46m
set _NORMAL_BG_WHITE=[47m

@rem strong foreground colors
set _STRONG_FG_BLACK=[90m
set _STRONG_FG_RED=[91m
set _STRONG_FG_GREEN=[92m
set _STRONG_FG_YELLOW=[93m
set _STRONG_FG_BLUE=[94m
set _STRONG_FG_MAGENTA=[95m
set _STRONG_FG_CYAN=[96m
set _STRONG_FG_WHITE=[97m

@rem strong background colors
set _STRONG_BG_BLACK=[100m
set _STRONG_BG_RED=[101m
set _STRONG_BG_GREEN=[102m
set _STRONG_BG_YELLOW=[103m
set _STRONG_BG_BLUE=[104m
goto :eof

:args
set _CLEAN=0
set _COMPILE=0
set _DOC=0
set _HELP=0
set _LINT=0
set _RUN=0
set _TIMER=0
set _VERBOSE=0
set __N=0
:args_loop
set "__ARG=%~1"
if not defined __ARG (
    if !__N!==0 set _HELP=1
    goto args_done
)
if "%__ARG:~0,1%"=="-" (
    @rem option
    if "%__ARG%"=="-debug" ( set _DEBUG=1
    ) else if "%__ARG%"=="-help" ( set _HELP=1
    ) else if "%__ARG%"=="-timer" ( set _TIMER=1
    ) else if "%__ARG%"=="-verbose" ( set _VERBOSE=1
    ) else (
        echo %_ERROR_LABEL% Unknown option "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
) else (
    @rem subcommand
    if "%__ARG%"=="clean" ( set _CLEAN=1
    ) else if "%__ARG%"=="compile" ( set _COMPILE=1
    ) else if "%__ARG%"=="doc" ( set _DOC=1
    ) else if "%__ARG%"=="help" ( set _HELP=1
    ) else if "%__ARG%"=="lint" ( set _LINT=1
    ) else if "%__ARG%"=="run" ( set _COMPILE=1& set _RUN=1
    ) else (
        echo %_ERROR_LABEL% Unknown subcommand "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
    set /a __N+=1
)
shift
goto :args_loop
:args_done
if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% Options    : _TIMER=%_TIMER% _VERBOSE=%_VERBOSE% 1>&2
    echo %_DEBUG_LABEL% Subcommands: _CLEAN=%_CLEAN% _COMPILE=%_COMPILE% _DOC=%_DOC% _LINT=%_LINT% _RUN=%_RUN% 1>&2
)
if %_TIMER%==1 for /f "delims=" %%i in ('powershell -c "(Get-Date)"') do set _TIMER_START=%%i
goto :eof

:help
if %_VERBOSE%==1 (
    set __BEG_P=%_STRONG_FG_CYAN%
    set __BEG_O=%_STRONG_FG_GREEN%
    set __BEG_N=%_NORMAL_FG_YELLOW%
    set __END=%_RESET%
) else (
    set __BEG_P=
    set __BEG_O=
    set __BEG_N=
    set __END=
)
echo Usage: %__BEG_O%%_BASENAME% { ^<option^> ^| ^<subcommand^> }%__END%
echo.
echo   %__BEG_P%Options:%__END%
echo     %__BEG_O%-debug%__END%        print commands executed by this script
echo     %__BEG_O%-timer%__END%        print total execution time
echo     %__BEG_O%-verbose%__END%      print progress messages
echo.
echo   %__BEG_P%Subcommands:%__END%
echo     %__BEG_O%clean%__END%         delete generated class files
echo     %__BEG_O%compile%__END%       compile Go source files
echo     %__BEG_O%doc%__END%           generate documentation
echo     %__BEG_O%help%__END%          print this help message
echo     %__BEG_O%run%__END%           execute the generated program "%__BEG_O%!_TARGET_FILE:%_ROOT_DIR%=!%__END%"
if %_VERBOSE%==0 goto :eof
echo.
echo   %__BEG_P%Build settings:%__END%
echo     %__BEG_O%SOURCE_DIR%__END%="!_SOURCE_DIR:%_ROOT_DIR%=!"
echo     %__BEG_O%TARGET_DIR%__END%="!_TARGET_DIR:%_ROOT_DIR%=!"
goto :eof

:clean
call :rmdir "%_TARGET_DIR%"
goto :eof

rem input parameter: %1=directory path
:rmdir
set "__DIR=%~1"
if not exist "%__DIR%\" goto :eof
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% rmdir /s /q "%__DIR%" 1>&2
) else if %_VERBOSE%==1 ( echo Delete directory "!__DIR:%_ROOT_DIR%=!" 1>&2
)
rmdir /s /q "%__DIR%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to delete directory "!__DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:lint
pushd "%_SOURCE_DIR%"

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_GO_CMD%" fmt 1>&2
) else if %_VERBOSE%==1 ( echo Check format of Go source files in directory "!_SOURCE_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_GO_CMD%" fmt
if not %ERRORLEVEL%==0 (
    popd
    echo %_ERROR_LABEL% Found errors while checking format of Go source files 1>&2
    set _EXITCODE=1
    goto :eof
)
popd
set __GOLINT_OPTS=-set_exit_status

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_GOLINT_CMD%" %__GOLINT_OPTS% "%_SOURCE_DIR%" 1>&2
) else if %_VERBOSE%==1 ( echo Analyze Go source files in directory "!_SOURCE_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_GOLINT_CMD%" %__GOLINT_OPTS% "%_SOURCE_DIR%"
if not %ERRORLEVEL%==0 (
    echo %_WARNING_LABEL% Found errors while analyzing Go source files 1>&2
    @rem set _EXITCODE=1
    goto :eof
)
goto :eof

:compile
setlocal
set "__GOPATH=%GOPATH%"
set "GOPATH=%_ROOT_DIR%src"
if defined __GOPATH set "GOPATH=%__GOPATH%;%GOPATH%"

if %_DEBUG%==1 echo %_DEBUG_LABEL% "GOPATH=%GOPATH%"

if not exist "%_TARGET_DIR%" mkdir "%_TARGET_DIR%"

set __GO_OPTS=-o "%_TARGET_FILE%"

set "__MAIN_FILE=%_SOURCE_DIR%\Main.go"

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_GO_CMD%" build %__GO_OPTS% "%__MAIN_FILE%" 1>&2
) else if %_VERBOSE%==1 ( echo Compile Go source files to directory "!_TARGET_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_GO_CMD%" build %__GO_OPTS% "%__MAIN_FILE%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to compile Go source files to directory "!_TARGET_DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto compile_end
)
:compile_end
endlocal & set "GOPATH=%__GOPATH%"
goto :eof

:doc
if not exist "%_TARGET_DOCS_DIR%" mkdir "%_TARGET_DOCS_DIR%" 1>NUL

set __SOURCE_FILES=
for %%f in (%_SOURCE_DIR%\*.go) do (
    set __SOURCE_FILES=!__SOURCE_FILES! "%%f"
)
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% %_GO_CMD% doc %__SOURCE_FILES% 1>&2
) else if %_VERBOSE%==1 ( echo Generate HTML documentation into directory "!_TARGET_DOCS_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_GO_CMD%" doc %__SOURCE_FILES%
if not %ERRORLEVEL%==0 (
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Failed to generate HTML documentation into directory "!_TARGET_DOCS_DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:run
if not exist "%_TARGET_FILE%" (
    echo %_ERROR_LABEL% Target file "!_TARGET_FILE:%_ROOT_DIR%=!" not found 1>&2
    set _EXITCODE=1
    goto :eof
)
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "!_TARGET_FILE:%_ROOT_DIR%=!" 1>&2
) else if %_VERBOSE%==1 ( echo Execute target "!_TARGET_FILE:%_ROOT_DIR%=!" 1>&2
)
call "%_TARGET_FILE%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to execute target "!_TARGET_FILE:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

rem output parameter: _DURATION
:duration
set __START=%~1
set __END=%~2

for /f "delims=" %%i in ('powershell -c "$interval = New-TimeSpan -Start '%__START%' -End '%__END%'; Write-Host $interval"') do set _DURATION=%%i
goto :eof

rem ##########################################################################
rem ## Cleanups

:end
if %_TIMER%==1 (
    for /f "delims=" %%i in ('powershell -c "(Get-Date)"') do set __TIMER_END=%%i
    call :duration "%_TIMER_START%" "!__TIMER_END!"
    echo Total execution time: !_DURATION! 1>&2
)
exit /b %_EXITCODE%
endlocal
