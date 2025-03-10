ifndef GIT_HOME
$(error Variable GIT_HOME is not set)
endif
ifndef GOBIN
$(error Variable GOBIN is not set)
endif
ifndef GOROOT
$(error Variable GOROOT is not set)
endif
ifndef MSYS_HOME
$(error Variable MSYS_HOME is not set)
endif

ifeq ($(OS),Windows_NT)
GO         = $(subst \,/,$(GOROOT))/bin/go.exe
GOLINT     = $(subst \,/,$(GOBIN))/golint.exe
PSEP       = ;
## $(MSYS_HOME)\usr\bin\{cp.exe, make.exe, wget.exe}
CP         = /usr/bin/cp.exe
CURL       = /usr/bin/curl.exe
ECHO       = /usr/bin/echo.exe
FIND       = /usr/bin/find.exe
MAKE       = /usr/bin/make.exe
MKDIR      = /usr/bin/mkdir.exe
RM         = /usr/bin/rm.exe
TOUCH      = /usr/bin/touch.exe
else
GO         = $(GOROOT)/bin/go
GOLINT     = $(GOBIN)/golint
PSEP       = :
CP         = cp
CURL       = curl
ECHO       = echo
FIND       = find
MAKE       = make
MKDIR      = mkdir
RM         = rm
TOUCH      = touch
endif
