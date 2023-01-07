# <span id="top">Golang Setup</span> <span style="size:25%;"><a href="README.md">↩</a></span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://golang.org/" rel="external"><img style="border:0;" src="./docs/images/go-logo-blue.svg" width="120" alt="Go project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document presents the <a href="https://golang.org/" rel="external">Go</a> packages our projects depend on.
  </td>
  </tr>
</table>

We also install the following Go packages :

- [`golint`][github_golint] (*deprecated*)
- [`gopkgs 2.1`][github_gopkgs] ([*release notes*][github_gopkgs_latest])
- [`mage 1.14`][github_mage] ([*release notes*][github_mage_latest])
- [`mysql 1.6`][github_mysql] ([*release notes*][github_mysql_latest])

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

## <span id="mage"><a href="https://github.com/magefile/mage"><b><code>mage</code></b></a></span> [**&#x25B4;**](#top)

We just need to execute the Go command `install` <sup id="anchor_01">[1](#footnote_01)</sup>.

<pre style="font-size:80%;">
<b>&gt; <a href="https://go.dev/ref/mod#go-list">go list</a> -m -versions github.com/magefile/mage</b>
github.com/magefile/mage v1.0.1 v1.0.2 v1.2.4 v1.3.0 v1.4.0 v1.5.0 v1.6.0 v1.6.1 v1.6.2 v1.7.0 v1.7.1 v1.8.0 v1.9.0 v1.10.0 v1.11.0 v1.12.0 v1.12.1 v1.13.0 v1.14.0
&nbsp;
<b>&gt; <a href="https://go.dev/ref/mod#go-install">go install</a> github.com/magefile/mage@v1.14.0</b>
</pre>

## <span id="mysql"><a href="https://github.com/go-sql-driver/mysql"><b><code>mysql</code></b></a></span>

<pre style="font-size:80%;">
<b>&gt; <a href="https://go.dev/ref/mod#go-install">go install</a> github.com/go-sql-driver/mysql@latest</b>
go: downloading github.com/go-sql-driver/mysql v1.7.0
package github.com/go-sql-driver/mysql is not a main package
&nbsp;
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> /r "%GOPATH%" *sql*</b>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\go\pkg\mod\cache\[...]\go-sql-driver\mysql@v1.7.0
</pre>

## <span id="footnotes">Footnotes</span>

<span id="footnote_01">[1]</span> ***Mage Module*** [↩](#anchor_01)

<dl><dd>
Alternatively we can download the binary release <a href="https://github.com/magefile/mage/releases/tag/v1.14.0"><code>mage_1.14.0_Windows-64bit.zip</code></a> and copy its contents &ndash; the single executable <code>mage.exe</code> &ndash; to directory <code><b>%GOBIN%</b></code>.
</dd><dd>
<pre style="font-size:80%;">
<b>&gt; %GOBIN%\mage -version</b>
Mage Build Tool 1.14.0
Build Date: 2022-03-16T17:05:54Z
Commit: 3504e09d7fcfdeab6e70281edce5d5dfb205f31a
built with: go1.18
</pre>
</dd>
<dd>
By default <code><b>%GOBIN%</b></code> variable should default to <code><b>%GOPATH%</b>\bin</code>.
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/January 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[github_golint]: https://github.com/golang/lint
[github_gopkgs]: https://github.com/uudashr/gopkgs
[github_gopkgs_latest]: https://github.com/uudashr/gopkgs/releases/latest
[github_mage]: https://github.com/magefile/mage
[github_mage_latest]: https://github.com/magefile/mage/releases
[github_mysql]: https://github.com/go-sql-driver/mysql
[github_mysql_latest]: https://github.com/go-sql-driver/mysql/releases/latest
