# <span id="top">Go examples</span> <span style="size:30%;"><a href="../README.md">⬆</a></span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://golang.org/" rel="external"><img style="border:0;" src="../docs/images/go-logo-blue.svg" width="120" alt="Go project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">Directory <strong><code>examples\</code></strong> contains <a href="https://golang.org/" rel="external" alt="Go">Go</a> code examples coming from various websites - mostly from the <a href="https://golang.org/" rel="external">Go project</a>.
  </td>
  </tr>
</table>

## <span id="hello">`hello` Example</span>

Command [`build.bat`](./hello/build.bat) executes the Go command `%GOROOT%\bin\go build` with the appropriate parameters and runs the generated executable `hello.exe` :

<pre style="font-size:80%;">
<b>&gt; <a href="./hello/build.bat">build</a> -verbose run</b>
Compile Go source files to directory "target"
Execute target "target\hello.exe"
hello, world
</pre>

Build tool [`mage.exe`](https://magefile.org/) takes its Makefile-like runnable targets from the Go file [`mage.go`](./hello/mage.go); for instance :

<pre style="font-size:80%;">
<b>&gt; <a href="">mage</a> clean build &amp; target\hello.exe</b>
Cleaning...
Building...
hello, world
</pre>

*WIP*

***

*[mics](https://lampwww.epfl.ch/~michelou/)/October 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[windows_batch_file]: https://en.wikibooks.org/wiki/Windows_Batch_Scripting
