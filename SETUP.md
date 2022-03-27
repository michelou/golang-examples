# <span id="top">Golang Setup</span> <span style="size:25%;"><a href="README.md">↩</a></span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://golang.org/" rel="external"><img style="border:0;" src="./docs/images/go-logo-blue.svg" width="120" alt="Go project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document presents the <a href="https://golang.org/" rel="external">Go</a> packages our projects depend on.
  </td>
  </tr>
</table>

We also install the following Go packages :

- [`golint`][github_golint]
- [`gopkgs 2.1`][github_gopkgs] ([*release notes*][github_gopkgs_latest])
- [`mage 1.13`][github_mage] ([*release notes*][github_mage_latest])
- [`mysql 1.5`][github_mysql] ([*release notes*][github_mysql_latest])

The installed Go packages are located in <code>%GOPATH%</code>.

## <span id="golint"><a href="https://github.com/golang/lint"><b><code>golint</code></b></a></span>

<pre style="font-size:80%;">
<b>&gt; <a href="https://golang.org/cmd/go/#hdr-Add_dependencies_to_current_module_and_install_them">go get</a> -u golang.org/x/lint/golint</b>
&nbsp;
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> /r "%GOPATH%" *lint*</b>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\go\bin\golint.exe
%USERPROFILE%\go\src\golang.org\x\lint\lint.go
%USERPROFILE%\go\src\golang.org\x\lint\lint_test.go
%USERPROFILE%\go\src\golang.org\x\lint\golint\golint.go
%USERPROFILE%\go\src\golang.org\x\lint\misc\emacs\golint.el
%USERPROFILE%\go\src\golang.org\x\lint\misc\vim\ftplugin\go\lint.vim
</pre>

## <span id="gopkgs"><a href="https://github.com/uudashr/gopkgs"><b><code>gopkgs</code></b></a></span>

<pre style="font-size:80%;">
<b>&gt; <a href="https://golang.org/cmd/go/#hdr-Add_dependencies_to_current_module_and_install_them">go get</a> -u -v github.com/uudashr/gopkgs/cmd/gopkgs</b>
github.com/uudashr/gopkgs (download)
github.com/MichaelTJones/walk (download)
github.com/pkg/errors (download)
&nbsp;
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> /r "%GOPATH%" gopkgs*</b>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\go\bin\gopkgs.exe
%USERPROFILE%\go\src\github.com\uudashr\gopkgs\gopkgs.go
%USERPROFILE%\go\src\github.com\uudashr\gopkgs\gopkgs_test.go
%USERPROFILE%\go\src\github.com\uudashr\gopkgs\internal\gopkgs.go
%USERPROFILE%\go\src\github.com\uudashr\gopkgs\internal\gopkgs_test.go
...</pre>

## <span id="mage"><a href="https://github.com/magefile/mage"><b><code>mage</code></b></a></span>

*WIP*

## <span id="mysql"><a href="https://github.com/go-sql-driver/mysql"><b><code>mysql</code></b></a></span>

<pre style="font-size:80%;">
<b>&gt; <a href="https://golang.org/cmd/go/#hdr-Add_dependencies_to_current_module_and_install_them">go get</a> -u github.com/go-sql-driver/mysql</b>
&nbsp;
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> /r "%GOPATH%" *sql*</b>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\go\pkg\windows_amd64\github.com\go-sql-driver\mysql.a
%USERPROFILE%\go\src\github.com\go-sql-driver\mysql\.travis\wait_mysql.sh
</pre>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/March 2022* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[github_golint]: https://github.com/golang/lint
[github_gopkgs]: https://github.com/uudashr/gopkgs
[github_gopkgs_latest]: https://github.com/uudashr/gopkgs/releases/latest
[github_mage]: https://github.com/magefile/mage
[github_mage_latest]: https://github.com/magefile/mage/releases
[github_mysql]: https://github.com/go-sql-driver/mysql
[github_mysql_latest]: https://github.com/go-sql-driver/mysql/releases/latest
