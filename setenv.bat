@echo off
setlocal enabledelayedexpansion

@rem only for interactive debugging
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

set _GIT_PATH=
set _GOLANG_PATH=
set _VSCODE_PATH=

call :vscode
if not %_EXITCODE%==0 goto end

call :golang
if not %_EXITCODE%==0 goto end

call :git
if not %_EXITCODE%==0 goto end

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

set "_GOPATH=%USERPROFILE%\go"
set "_GOBIN=%_GOPATH%\bin"
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

@rem input parameter: %*
@rem output parameter: _HELP, _VERBOSE
:args
set _BASH=0
set _HELP=0
set _VERBOSE=0
:args_loop
set "__ARG=%~1"
if not defined __ARG goto args_done

if "%__ARG:~0,1%"=="-" (
    @rem option
    if "%__ARG%"=="-bash" ( set _BASH=1
    ) else if "%__ARG%"=="-debug" ( set _DEBUG=1
    ) else if "%__ARG%"=="-verbose" ( set _VERBOSE=1
    ) else (
        echo %_ERROR_LABEL% Unknown option %__ARG% 1>&2
        set _EXITCODE=1
        goto args_done
    )
) else (
    @rem subcommand
    if "%__ARG%"=="help" ( set _HELP=1
    ) else (
        echo %_ERROR_LABEL% Unknown subcommand %__ARG% 1>&2
        set _EXITCODE=1
        goto args_done
    )
)
shift
goto args_loop
:args_done
if %_DEBUG%==1 echo %_DEBUG_LABEL% _BASH=%_BASH% 1>&2
goto :eof

:help
if %_VERBOSE%==1 (
    set __BEG_P=%_STRONG_FG_CYAN%%_UNDERSCORE%
    set __BEG_O=%_STRONG_FG_GREEN%
    set __END=%_RESET%
) else (
    set __BEG_P=
    set __BEG_O=
    set __END=
)
echo Usage: %__BEG_O%%_BASENAME% { ^<option^> ^| ^<subcommand^> }%__END%
echo.
echo   %__BEG_P%Options:%__END%
echo     %__BEG_O%-bash%__END%       start Git bash shell instead of Windows command prompt
echo     %__BEG_O%-debug%__END%      show commands executed by this script
echo     %__BEG_O%-verbose%__END%    display environment settings
echo.
echo   %__BEG_P%Subcommands:%__END%
echo     %__BEG_O%help%__END%        display this help message
goto :eof

@rem output parameters: _VSCODE_HOME, _VSCODE_PATH
:vscode
set _VSCODE_HOME=
set _VSCODE_PATH=

set __CODE_CMD=
for /f %%f in ('where code.cmd 2^>NUL') do set "__CODE_CMD=%%f"
if defined __CODE_CMD (
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using path of VS Code executable found in PATH 1>&2
    for %%i in ("%__CODE_CMD%") do set "__CODE_BIN_DIR=%%~dpi"
    for %%f in ("!__CODE_BIN_DIR!.") do set "_VSCODE_HOME=%%~dpf"
    @rem keep _CODE_PATH undefined since executable already in path
    goto :eof
) else if defined VSCODE_HOME (
    set "_VSCODE_HOME=%VSCODE_HOME%"
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using environment variable VSCODE_HOME
) else (
    set __PATH=C:\opt
    for /f %%f in ('dir /ad /b "!__PATH!\VSCode*" 2^>NUL') do set "_VSCODE_HOME=!__PATH!\%%f"
    if not defined _VSCODE_HOME (
        set "__PATH=%ProgramFiles%"
        for /f %%f in ('dir /ad /b "!__PATH!\VSCode*" 2^>NUL') do set "_VSCODE_HOME=!__PATH!\%%f"
    )
    if defined _VSCODE_HOME (
        if %_DEBUG%==1 echo %_DEBUG_LABEL% Using default VS Code installation directory !_VSCODE_HOME!
    )
)
if not exist "%_VSCODE_HOME%\bin\code.cmd" (
    echo %_ERROR_LABEL% VS Code executable not found ^(%_VSCODE_HOME%^) 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_VSCODE_PATH=;%_VSCODE_HOME%\bin"
goto :eof

@rem output parameters: _GOLANG_HOME, _GOLANG_PATH
:golang
set _GOLANG_HOME=
set _GOLANG_PATH=

set __GO_CMD=
for /f %%f in ('where go.exe 2^>NUL') do set "__GO_CMD=%%f"
if defined __GIT_CMD (
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using path of Go executable found in PATH 1>&2
    for %%i in ("%__GO_CMD%") do set "__GO_BIN_DIR=%%~dpi"
    for %%f in ("!__GO_BIN_DIR!.") do set "_GOLANG_HOME=%%~dpf"
    @rem keep _GOLANG_PATH undefined since executable already in path
    goto :eof
) else if defined GO_HOME (
    set "_GOLANG_HOME=%GO_HOME%"
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using environment variable GO_HOME
) else (
    set __PATH=C:\opt
    if exist "!__PATH!\Go\" ( set "_GOLANG_HOME=!__PATH!\Go"
    ) else (
        for /f %%f in ('dir /ad /b "!__PATH!\Go-*" 2^>NUL') do set "_GOLANG_HOME=!__PATH!\%%f"
        if not defined _GOLANG_HOME (
            set "__PATH=%ProgramFiles%"
            for /f %%f in ('dir /ad /b "!__PATH!\Go-*" 2^>NUL') do set "_GOLANG_HOME=!__PATH!\%%f"
        )
    )
    if defined _GOLANG_HOME (
        if %_DEBUG%==1 echo %_DEBUG_LABEL% Using default Go installation directory "!_GOLANG_HOME!" 1>&2
    )
)
if not exist "%_GOLANG_HOME%\bin\go.exe" (
    echo %_ERROR_LABEL% Go executable not found ^(%_GOLANG_HOME%^) 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_GOLANG_PATH=;%_GOLANG_HOME%\bin"
goto :eof

@rem output parameters: _GIT_HOME, _GIT_PATH
:git
set _GIT_HOME=
set _GIT_PATH=

set __GIT_CMD=
for /f %%f in ('where git.exe 2^>NUL') do set "__GIT_CMD=%%f"
if defined __GIT_CMD (
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using path of Git executable found in PATH 1>&2
    for %%i in ("%__GIT_CMD%") do set "__GIT_BIN_DIR=%%~dpi"
    for %%f in ("!__GIT_BIN_DIR!.") do set "_GIT_HOME=%%~dpf"
    @rem Executable git.exe is present both in bin\ and \mingw64\bin\
    if not "!_GIT_HOME:mingw=!"=="!_GIT_HOME!" (
        for %%f in ("!_GIT_HOME!.") do set "_GIT_HOME=%%~dpf"
    )
    @rem keep _GIT_PATH undefined since executable already in path
    goto :eof
) else if defined GIT_HOME (
    set "_GIT_HOME=%GIT_HOME%"
    if %_DEBUG%==1 echo %_DEBUG_LABEL% Using environment variable GIT_HOME
) else (
    set __PATH=C:\opt
    if exist "!__PATH!\Git\" ( set "_GIT_HOME=!__PATH!\Git"
    ) else (
        for /f %%f in ('dir /ad /b "!__PATH!\Git*" 2^>NUL') do set "_GIT_HOME=!__PATH!\%%f"
        if not defined _GIT_HOME (
            set "__PATH=%ProgramFiles%"
            for /f %%f in ('dir /ad /b "!__PATH!\Git*" 2^>NUL') do set "_GIT_HOME=!__PATH!\%%f"
        )
    )
    if defined _GIT_HOME (
        if %_DEBUG%==1 echo %_DEBUG_LABEL% Using default Git installation directory "!_GIT_HOME!" 1>&2
    )
)
if not exist "%_GIT_HOME%\bin\git.exe" (
    echo %_ERROR_LABEL% Git executable not found ^(%_GIT_HOME%^) 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_GIT_PATH=;%_GIT_HOME%\bin;%_GIT_HOME%\mingw64\bin;%_GIT_HOME%\usr\bin"
goto :eof

:print_env
set __VERBOSE=%1
set "__VERSIONS_LINE1=  "
set "__VERSIONS_LINE2=  "
set __WHERE_ARGS=
where /q "%VSCODE_HOME%\bin:code.cmd"
if %ERRORLEVEL%==0 (
    for /f %%i in ('"%VSCODE_HOME%\bin\code.cmd" --version 2^>^&1'^|findstr \.') do (
        set "__VERSIONS_LINE1=%__VERSIONS_LINE1% code %%i,"
    )
    set __WHERE_ARGS=%__WHERE_ARGS% "%VSCODE_HOME%\bin:code.cmd"
)
where /q "%GOROOT%\bin:go.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1,2,*" %%i in ('"%GOROOT%\bin\go.exe" version') do set "__VERSIONS_LINE1=%__VERSIONS_LINE1% go %%k,"
    set __WHERE_ARGS=%__WHERE_ARGS% "%GOROOT%\bin:go.exe"
)
where /q "%GOBIN%:mage.exe"
if %ERRORLEVEL%==0 (
    @rem for some reason option --version may return "<not set>"
    set __VERSION=unknown
    for /f "tokens=1-3,*" %%i in ('"%GOBIN%\mage.exe" --version ^| findstr Mage ^| findstr /v "not set"') do (
        set __VERSION=%%l
    )
    set "__VERSIONS_LINE1=%__VERSIONS_LINE1% mage !__VERSION!"
    set __WHERE_ARGS=%__WHERE_ARGS% "%GOBIN%:mage.exe"
)
where /q "%GIT_HOME%\bin:git.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1,2,*" %%i in ('"%GIT_HOME%\bin\git.exe" --version') do set "__VERSIONS_LINE2=%__VERSIONS_LINE2% git %%k,"
    set __WHERE_ARGS=%__WHERE_ARGS% "%GIT_HOME%\bin:git.exe"
)
where /q "%GIT_HOME%\usr\bin:diff.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1-3,*" %%i in ('"%GIT_HOME%\usr\bin\diff.exe" --version ^| findstr diff') do set "__VERSIONS_LINE2=%__VERSIONS_LINE2% diff %%l,"
    set __WHERE_ARGS=%__WHERE_ARGS% "%GIT_HOME%\usr\bin:diff.exe"
)
where /q "%GIT_HOME%\bin:bash.exe"
if %ERRORLEVEL%==0 (
    for /f "tokens=1-3,4,*" %%i in ('"%GIT_HOME%\bin\bash.exe" --version ^| findstr bash') do set "__VERSIONS_LINE2=%__VERSIONS_LINE2% bash %%l"
    set __WHERE_ARGS=%__WHERE_ARGS% "%GIT_HOME%\bin:bash.exe"
)
echo Tool versions:
echo %__VERSIONS_LINE1%
echo %__VERSIONS_LINE2%
if %__VERBOSE%==1 (
    echo Tool paths: 1>&2
    for /f "tokens=*" %%p in ('where %__WHERE_ARGS%') do echo    %%p 1>&2
    echo Environment variables: 1>&2
    if defined GIT_HOME echo    "GIT_HOME=%GIT_HOME%" 1>&2
    if defined GOBIN echo    "GOBIN=%GOBIN%" 1>&2
    if defined GOPATH echo    "GOPATH=%GOPATH%" 1>&2
    if defined GOROOT echo    "GOROOT=%GOROOT%" 1>&2
    if defined VSCODE_HOME echo    "VSCODE_HOME=%VSCODE_HOME%" 1>&2
    echo Path associations: 1>&2
    for /f "delims=" %%i in ('subst') do echo    %%i 1>&2
)
goto :eof

@rem #########################################################################
@rem ## Cleanups

:end
endlocal & (
    if %_EXITCODE%==0 (
        if not defined GIT_HOME set "GIT_HOME=%_GIT_HOME%"
        if not defined GOBIN set "GOBIN=%_GOBIN%"
        if not defined GOPATH set "GOPATH=%_GOPATH%"
        if not defined GOROOT set "GOROOT=%_GOLANG_HOME%"
        if not defined VSCODE_HOME set "VSCODE_HOME=%_VSCODE_HOME%"
        set "PATH=%PATH%%_VSCODE_PATH%%_GOLANG_PATH%%_GIT_PATH%;%_GOBIN%;%~dp0bin"
        call :print_env %_VERBOSE%
        if %_BASH%==1 (
            @rem see https://conemu.github.io/en/GitForWindows.html
            if %_DEBUG%==1 echo %_DEBUG_LABEL% %_GIT_HOME%\bin\bash.exe --login 1>&2
            cmd.exe /c "%_GIT_HOME%\bin\bash.exe --login"
        )
    )
    if %_DEBUG%==1 echo %_DEBUG_LABEL% _EXITCODE=%_EXITCODE% 1>&2
    for /f "delims==" %%i in ('set ^| findstr /b "_"') do set %%i=
)
