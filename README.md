# <span id="top">Playing with Go on Windows</span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:25%;"><a href="https://golang.org/" rel="external"><img src="./docs/images/go-logo-blue.svg" width="120" alt="Go project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://golang.org/" rel="external">Go</a> code examples coming from various websites and books.<br/>
  It also includes several <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting" rel="external">batch files</a> for experimenting with <a href="https://golang.org/" rel="external">Go</a> on a Windows machine.
  </td>
  </tr>
</table>

[Ada][ada_examples], [Akka][akka_examples], [C++][cpp_examples], [Deno][deno_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Node.js][nodejs_examples], [Rust][rust_examples], [Scala 3][scala3_examples], [Spark][spark_examples], [Spring][spring_examples], [TruffleSqueak][trufflesqueak_examples] and [WiX][wix_examples] are other topics we are continuously monitoring.

## <span id="proj_deps">Project dependencies</span>

This project depends on the following external software for the **Microsoft Windows** platform:

- [Git 2.37][git_downloads] ([*release notes*][git_relnotes])
- [go 1.18][golang_downloads] ([*release notes*][golang_relnotes])
- [Mage 1.13][mage_downloads] ([*release notes*][mage_relnotes])

> **&#9755;** ***Go packages***<br/>
> We present the installed Go packages in document [`SETUP.md`](./SETUP.md).

For instance our development environment looks as follows (*July 2022*) <sup id="anchor_01">[1](#footnote_01)</sup>:

<pre style="font-size:80%;">
C:\opt\go-1.18.4\    <i>(407 MB)</i>
C:\opt\Git-2.37.0\   <i>(286 MB)</i>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values" rel="external">%USERPROFILE%</a>\go\    <i>( 60 MB)</i>
</pre>
<!--
go1.14   -> 334 MB, go1.15 -> 369 MB, go1.16 -> 387 MB, go1.17 -> 407 MB
go1.18.1 -> 427 MB, go1.18.2 -> 345 MB, go1.18.4 -> MB
-->

## <span id="structure">Directory structure</span>

This project is organized as follows:

<pre style="font-size:80%;">
docs\
examples\{<a href="./examples/README.md">README.md</a>, ..}
<a href="README.md">README.md</a>
<a href="RESOURCES.md">RESOURCES.md</a>
<a href="SETUP.md">SETUP.md</a>
<a href="setenv.bat">setenv.bat</a>
</pre>

where

- directory [**`docs\`**](docs/) contains [Go][golang] related papers/articles.
- directory [**`examples\`**](examples/) contains [Go][golang] code examples.
- file [**`README.md`**](README.md) is the [Markdown][github_markdown] document for this page.
- file [**`RESOURCES.md`**](RESOURCES.md) gathers [Go][golang] related documents.
- file [**`SETUP.md`**](SETUP.md) presents the [Go][golang] packages our projects depend on.
- file [**`setenv.bat`**](setenv.bat) is the batch script for setting up our environment.


## <span id="footnotes">Footnotes</span>[**&#x25B4;**](#top)

<span id="footnote_01">[1]</span> ***Downloads*** [↩](#anchor_01)

<dl><dd>
In our case we downloaded the following installation files (see <a href="#proj_deps">section 1</a>):
</dd>
<dd>
<pre style="font-size:80%;">
<a href="https://golang.org/dl/#stable" rel="external">go1.18.4.windows-amd64.zip</a>        <i>(150 MB)</i>
<a href="https://github.com/magefile/mage/releases" rel="external">mage_1.13.0_Windows-64bit.zip</a>     <i>(  1 MB)</i>
<a href="https://git-scm.com/download/win" rel="external">PortableGit-2.37.0-64-bit.7z.exe</a>  <i>( 41 MB)</i>
</pre>
</dd></dl>

<span id="footnote_02">[2]</span> ***External tools*** [↩](#anchor_02)

<dl><dd>
<ol>
<li>Command <b><code>go get</code></b> requires a <a href="https://git-scm.com/docs/git"><b><code>git</code></b></a> executable in <code>%PATH%</code>, and since we've installed Git for Windows we just just need to add <code>bin\</code> path to our execution path,
      e.g. <code>c:\opt\Git-2.37.0\bin\</code>
</li>
<li>Command <b><code>go fmt</code></b> (or utility <b><code>gofmt</code></b>) requires a <a href="https://www.gnu.org/software/diffutils/manual/html_node/Invoking-diff.html"><b><code>diff</code></b></a> executable in <code>%PATH%</code>, and since we've installed Git for Windows we just just need to add <code>usr\bin\</code> path to your execution path,
      e.g. <code>c:\opt\Git-2.37.0\usr\bin\</code>
</li>
<li><a href="http://liteide.org/en/">LiteIDE</a> - a simple, open source, cross-platform Go IDE.
</li>
</ol>
</dd></dl>

<span id="footnote_03">[3]</span> ***Go environment variables*** [↩](#anchor_03)

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
<b>GOPATH</b>
   The location of your workspace.
   NB. To access it from your Go source code simply write
   import (
       "fmt"
       "go/build"
   )
   fmt.Println(build.Default.GOPATH)
&nbsp;
<b>GOROOT</b>
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
c:\opt\go-1.18.4
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
go version go1.18.4 windows/amd64
&nbsp;
<b>&gt; <a href="https://pkg.go.dev/cmd/go#hdr-Run_specified_go_tool" rel="external">go tool</a> dist list |<a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/findstr" rel="external">findstr</a> windows</b>
windows/386
windows/amd64
windows/arm
windows/arm64
</pre>
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/July 2022* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples
[akka_examples]: https://github.com/michelou/akka-examples
[cpp_examples]: https://github.com/michelou/cpp-examples
[deno_examples]: https://github.com/michelou/deno-examples
[diff_cli]: https://www.gnu.org/software/diffutils/manual/html_node/Invoking-diff.html
[git_cli]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[git_exe]: https://git-scm.com/docs/git
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.37.0.txt
[github_markdown]: https://github.github.com/gfm/
[golang]: https://golang.org/
[golang_downloads]: https://golang.org/dl/#stable
[golang_relnotes]: https://golang.org/doc/devel/release.html#go1.18
[graalvm_examples]: https://github.com/michelou/graalvm-examples
[haskell_examples]: https://github.com/michelou/haskell-examples
[kotlin_examples]: https://github.com/michelou/kotlin-examples
[llvm_examples]: https://github.com/michelou/llvm-examples
[mage_downloads]: https://github.com/magefile/mage/releases
[mage_relnotes]: https://github.com/magefile/mage/releases/tag/v1.13.0
[nodejs_examples]: https://github.com/michelou/nodejs-examples
[rust_examples]: https://github.com/michelou/rust-examples
[scala3_examples]: https://github.com/michelou/dotty-examples
[spark_examples]: https://github.com/michelou/spark-examples
[spring_examples]: https://github.com/michelou/spring-examples
[trufflesqueak_examples]: https://github.com/michelou/trufflesqueak-examples
[wix_examples]: https://github.com/michelou/wix-examples
