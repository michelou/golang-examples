# <span id="top">Playing with Go on Windows</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:25%;"><a href="https://golang.org/" rel="external"><img src="./docs/images/go-logo-blue.svg" width="120" alt="Go project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://golang.org/" rel="external">Go</a> code examples coming from various websites and books.<br/>
  It also includes several build scripts (<a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting" rel="external">batch files</a>, <a href="https://magefile.org/magefiles/" rel="external">Mage files</a>) for experimenting with <a href="https://golang.org/" rel="external">Go</a> on a Windows machine.</td>
  </tr>
</table>

[Ada][ada_examples], [Akka][akka_examples], [C++][cpp_examples], [COBOL][cobol_examples],  [Dart][dart_examples], [Deno][deno_examples], [Docker][docker_examples], [Erlang][erlang_examples], [Flix][flix_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kafka][kafka_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Modula-2][m2_examples], [Node.js][nodejs_examples], [Rust][rust_examples], [Scala 3][scala3_examples], [Spark][spark_examples], [Spring][spring_examples], [TruffleSqueak][trufflesqueak_examples], [WiX Toolset][wix_examples] and [Zig][zig_examples] are other topics we are continuously monitoring.

> **&#9755;** Read the report <a href="https://kuree.gitbooks.io/the-go-programming-language-report/content/" rel="external">"The Go Programming Language Report"</a> for a quick overview of the Go programming language.

## <span id="proj_deps">Project dependencies</span>

This project depends on the following external software for the **Microsoft Windows** platform:

- [Git 2.45][git_downloads] ([*release notes*][git_relnotes])
- [go 1.22][golang_downloads] ([*release notes*][golang_relnotes])
- [Mage 1.15][mage_downloads] ([*release notes*][mage_relnotes])
- [MSYS2 2024][msys2_downloads] ([*changelog*][msys2_changelog])

> **&#9755;** ***Go packages***<br/>
> We present the installed [Go][golang] packages in document [`PACKAGES.md`](./PACKAGES.md).

Optionally one may also install the following software:

- [ConEmu 2023][conemu_downloads] ([*release notes*][conemu_relnotes])
- [Visual Studio Code 1.91][vscode_downloads] ([*release notes*][vscode_relnotes])

For instance our development environment looks as follows (*July 2024*) <sup id="anchor_01">[1](#footnote_01)</sup>:

<pre style="font-size:80%;">
C:\opt\ConEmu\       <i>( 26 MB)</i>
C:\opt\Git\          <i>(367 MB)</i>
C:\opt\go\           <i>(215 MB)</i>
C:\opt\VSCode\       <i>(341 MB)</i>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values" rel="external">%USERPROFILE%</a>\go\    <i>( 60 MB)</i>
</pre>
<!--
go1.14   -> 334 MB, go1.15   -> 369 MB, go1.16   -> 387 MB, go1.17 -> 407 MB
go1.18.1 -> 427 MB, go1.18.2 -> 345 MB, go1.18.4 -> 423 MB, go1.19 -> 451 MB
go1.19.2 -> 451 MB, go1.20.2 -> 245 MB, go1.20.3 -> 246 MB, go1.20.4 -> 246 MB
go1.20.5 -> 246 MB, go1.20.6 -> 246 MB, go1.21.0 -> 206 MB, go1.21.1 -> 206 MB
go1.21.2 -> 206 MB, go1.21.5 -> 206 MB, go1.21.6 -> 206 MB, go1.22.0 -> 215 MB
go1.22.2 -> 215 MB, go1.22.5 -> 215 MB
-->

## <span id="structure">Directory structure</span> [**&#x25B4;**](#top)

This project is organized as follows:

<pre style="font-size:80%;">
docs\
examples\{<a href="./examples/README.md">README.md</a>, <a href="./examples/hello/">hello</a>, ...}
meeus-examples\{<a href="./meeus-examples/README.md">README.md</a>, <a href="./meeus-examples/FirstClassFuncs/">FirstClassFuncs</a>, ...}
<a href="PACKAGES.md">PACKAGES.md</a>
<a href="README.md">README.md</a>
<a href="RESOURCES.md">RESOURCES.md</a>
<a href="setenv.bat">setenv.bat</a>
</pre>

where

- directory [**`docs\`**](docs/) contains [Go][golang] related papers/articles.
- directory [**`examples\`**](examples/) contains [Go][golang] code examples.
- directory [**`meeus-examples\`**](meeus-examples/) contains [Go][golang] code examples from [Meeus's book][book_meeus].
- file [**`PACKAGES.md`**](PACKAGES.md) presents the [Go][golang] packages our projects depend on.
- file [**`README.md`**](README.md) is the [Markdown][github_markdown] document for this page.
- file [**`RESOURCES.md`**](RESOURCES.md) gathers [Go][golang] related documents.
- file [**`setenv.bat`**](setenv.bat) is the batch script for setting up our environment.


## <span id="commands">Batch commands</span> [**&#x25B4;**](#top)

### **`setenv.bat`** <sup id="anchor_03">[3](#footnote_03)</sup>

We execute command [**`setenv.bat`**](setenv.bat) once to setup our development environment; it makes external tools such as [**`code.cmd`**][code_cli], [**`git.exe`**][git_cli] and [**`mage.exe`**][mage_cli] directly available from the command prompt.

<pre style="font-size:80%;">
<b>&gt; <a href="setenv.bat">setenv</a></b>
Tool versions:
   code 1.91.0, go 1.22.5, mage 1.15.0
   git 2.45.2, diff 3.10, bash 5.2.26(1)

<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1" rel="external">where</a> code git mage</b>
C:\opt\VSCode\bin\code
C:\opt\VSCode\bin\code.cmd
C:\opt\Git\bin\git.exe
C:\opt\Git\mingw64\bin\git.exe
C:\opt\go\bin\mage.exe
</pre>

## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)

<span id="footnote_01">[1]</span> ***Downloads*** [↩](#anchor_01)

<dl><dd>
In our case we downloaded the following installation files (see <a href="#proj_deps">section 1</a>):
</dd>
<dd>
<pre style="font-size:80%;">
<a href="https://github.com/Maximus5/ConEmu/releases/tag/v23.07.24" rel="external">ConEmuPack.230724.7z</a>              <i>(  5 MB)</i>
<a href="https://golang.org/dl/#stable" rel="external">go1.22.5.windows-amd64.zip</a>        <i>( 70 MB)</i>
<a href="https://github.com/magefile/mage/releases" rel="external">mage_1.15.0_Windows-64bit.zip</a>     <i>(  1 MB)</i>
<a href="http://repo.msys2.org/distrib/x86_64/">msys2-x86_64-20240113.exe</a>         <i>( 94 MB)</i>
<a href="https://git-scm.com/download/win" rel="external">PortableGit-2.45.2-64-bit.7z.exe</a>  <i>( 41 MB)</i>
<a href="https://code.visualstudio.com/Download#" rel="external">VSCode-win32-x64-1.91.0.zip</a>       <i>(131 MB)</i>
</pre>
</dd></dl>

<span id="footnote_02">[2]</span> ***External tools*** [↩](#anchor_02)

<dl><dd>
<ol>
<li>Command <b><code>go.exe get</code></b> requires a <a href="https://git-scm.com/docs/git"><b><code>git.exe</code></b></a> executable in <code>%PATH%</code>, and since we've installed Git for Windows we just just need to add <code>bin\</code> path to our execution path,
      e.g. <code>c:\opt\Git\bin\</code>
</li>
<li>Command <b><code>go.exe fmt</code></b> (or utility <b><code>gofmt</code></b>) requires a <a href="https://www.gnu.org/software/diffutils/manual/html_node/Invoking-diff.html"><b><code>diff.exe</code></b></a> executable in <code>%PATH%</code>, and since we've installed Git for Windows we just just need to add <code>usr\bin\</code> path to your execution path,
      e.g. <code>c:\opt\Git\usr\bin\</code>
</li>
<li><a href="http://liteide.org/en/">LiteIDE</a> - a simple, open source, cross-platform Go IDE.
</li>
</ol>
</dd></dl>

<span id="footnote_03">[3]</span> **`setenv.bat` *usage*** [↩](#anchor_03)

<dl><dd>
Batch file <a href=./setenv.bat><code><b>setenv.bat</b></code></a> has specific environment variables set that enable us to use command-line developer tools more easily.
</dd>
<dd>It is similar to the setup scripts described on the page <a href="https://learn.microsoft.com/en-us/visualstudio/ide/reference/command-prompt-powershell" rel="external">"Visual Studio Developer Command Prompt and Developer PowerShell"</a> of the <a href="https://learn.microsoft.com/en-us/visualstudio/windows" rel="external">Visual Studio</a> online documentation.
</dd>
<dd>
For instance we can quickly check that the two scripts <code>Launch-VsDevShell.ps1</code> and <code>VsDevCmd.bat</code> are indeed available in our Visual Studio 2019 installation :
<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/where" rel="external">where</a> /r "C:\Program Files (x86)\Microsoft Visual Studio" *vsdev*</b>
C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\Launch-VsDevShell.ps1
C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat
C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\vsdevcmd\core\vsdevcmd_end.bat
C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\vsdevcmd\core\vsdevcmd_start.bat
</pre>
</dd>
<dd>
Concretely, in our GitHub projects which depend on Visual Studio (e.g. <a href="https://github.com/michelou/cpp-examples"><code>michelou/cpp-examples</code></a>), <a href="./setenv.bat"><code>setenv.bat</code></a> does invoke <code>VsDevCmd.bat</code> (resp. <code>vcvarall.bat</code> for older Visual Studio versions) to setup the Visual Studio tools on the command prompt. 
</dd></dl>

<span id="footnote_04">[4]</span> ***Go environment variables*** [↩](#anchor_04)

<dl><dd>
<pre style="font-size:80%;">
<b>&gt; <a href="https://golang.org/cmd/go/">go</a> help environment</b>
&nbsp;
<b>GOARCH</b>
   The architecture, or processor, for which to compile code.
   Examples are amd64, 386, arm, ppc64.
&nbsp;
<b>GOBIN</b>
   The directory where 'go install' will install a command.
   Empty by default.
&nbsp;
<b>GODEBUG</b>
   Example: &gt; <a href="https://man7.org/linux/man-pages/man1/env.1.html" rel="external">env</a> GODEBUG=gctrace=1,schedtrace=1000 <a href="https://pkg.go.dev/golang.org/x/tools/cmd/godoc" rel="external">godoc</a> -http=:8080
  (see <a href="https://dave.cheney.net/tag/gomaxprocs" rel="external">https://dave.cheney.net/tag/gomaxprocs</a>)
&nbsp;
<b>GOMAXPROCS</b>
   Starting from Go 1.5, the default value should be the number of cores.
&nbsp;
<b>GOOS</b>
   The operating system for which to compile code.
   Examples are linux, darwin, windows, netbsd.
&nbsp;
<a href="https://www.jetbrains.com/help/go/configuring-goroot-and-gopath.html#gopath"><b>GOPATH</b></a>
   The location of your workspace.
   NB. To access it from your Go source code simply write
   import (
       "fmt"
       "go/build"
   )
   fmt.Println(build.Default.GOPATH)
&nbsp;
<a href="https://www.jetbrains.com/help/go/configuring-goroot-and-gopath.html#goroot"><b>GOROOT</b></a>
   The root of the go tree.
</pre>
</dd>
<dd>
For instance:
</dd>
<dd>
<pre style="font-size:80%;">
<b>&gt; <a href="https://golang.org/cmd/go/#hdr-Print_Go_environment_information">go env</a> GOARCH GOOS GOROOT GOPATH GOBIN</b>
amd64
windows
c:\opt\go
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values" rel="external">%USERPROFILE%</a>\go
%USERPROFILE%\go\bin
</pre>
</dd>
<dd>
Run the following command to list the architectures supported on the Windows OS :
</dd>
<dd>
<pre style="font-size:80%;">
<b>&gt; go version</b>
go version go1.22.5 windows/amd64
&nbsp;
<b>&gt; <a href="https://pkg.go.dev/cmd/go#hdr-Run_specified_go_tool" rel="external">go tool</a> dist list |<a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/findstr" rel="external">findstr</a> windows</b>
windows/386
windows/amd64
windows/arm
windows/arm64
</pre>
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/July 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples#top
[akka_examples]: https://github.com/michelou/akka-examples#top
[book_meeus]: https://www.packtpub.com/product/functional-programming-in-go/9781801811163
[code_cli]: https://code.visualstudio.com/docs/editor/command-line
[cobol_examples]: https://github.com/michelou/cobol-examples#top
[conemu_downloads]: https://github.com/Maximus5/ConEmu/releases
[conemu_relnotes]: https://conemu.github.io/blog/2023/07/24/Build-230724.html
[cpp_examples]: https://github.com/michelou/cpp-examples#top
[dart_examples]: https://github.com/michelou/dart-examples#top
[deno_examples]: https://github.com/michelou/deno-examples#top
[docker_examples]: https://github.com/michelou/docker-examples#top
[diff_cli]: https://www.gnu.org/software/diffutils/manual/html_node/Invoking-diff.html
[erlang_examples]: https://github.com/michelou/erlang-examples#top
[flix_examples]: https://github.com/michelou/flix-examples#top
[git_cli]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[git_exe]: https://git-scm.com/docs/git
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.45.2.txt
[github_markdown]: https://github.github.com/gfm/
[golang]: https://golang.org/
[golang_downloads]: https://golang.org/dl/#stable
[golang_relnotes]: https://golang.org/doc/devel/release.html#go1.22
[graalvm_examples]: https://github.com/michelou/graalvm-examples#top
[haskell_examples]: https://github.com/michelou/haskell-examples#top
[kafka_examples]: https://github.com/michelou/kafka-examples#top
[kotlin_examples]: https://github.com/michelou/kotlin-examples#top
[llvm_examples]: https://github.com/michelou/llvm-examples#top
[mage_cli]: https://
[m2_examples]: https://github.com/michelou/m2-examples#top
[mage_downloads]: https://github.com/magefile/mage/releases
[mage_relnotes]: https://github.com/magefile/mage/releases/tag/v1.15.0
[msys2_changelog]: https://github.com/msys2/setup-msys2/blob/main/CHANGELOG.md
[msys2_downloads]: http://repo.msys2.org/distrib/x86_64/
[nodejs_examples]: https://github.com/michelou/nodejs-examples#top
[rust_examples]: https://github.com/michelou/rust-examples#top
[scala3_examples]: https://github.com/michelou/dotty-examples#top
[spark_examples]: https://github.com/michelou/spark-examples#top
[spring_examples]: https://github.com/michelou/spring-examples#top
[trufflesqueak_examples]: https://github.com/michelou/trufflesqueak-examples#top
[vscode_downloads]: https://code.visualstudio.com/#alt-downloads
[vscode_relnotes]: https://code.visualstudio.com/updates/
[wix_examples]: https://github.com/michelou/wix-examples#top
[zig_examples]: https://github.com/michelou/zig-examples#top
