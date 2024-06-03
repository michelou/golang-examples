# <span id="top">Go examples</span> <span style="size:30%;"><a href="../README.md">⬆</a></span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://golang.org/" rel="external"><img style="border:0;" src="../docs/images/go-logo-blue.svg" width="120" alt="Go project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">Directory <strong><code>examples\</code></strong> contains <a href="https://golang.org/" rel="external" alt="Go">Go</a> code examples coming from various websites - mostly from the <a href="https://golang.org/" rel="external">Go project</a>.
  </td>
  </tr>
</table>

## <span id="basics">`basics` Example</span>

Example `basics` has the following directory structure :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /v /b [A-Z]</b>
|   <a href="./basics/build.bat">build.bat</a>
|   <a href="./basics/go.mod">go.mod</a>
|   <a href="./basics/magefile.go">magefile.go</a>
|
\---src
    \---main
            <a href="./basics/src/main/basics.go">basics.go</a>
</pre>

Command [**`build.bat`**](./basics/build.bat) executes the Go command `%GOROOT%\bin\go build` with the appropriate parameters and runs the generated executable `basics.exe` :

<pre style="font-size:80%;">
<b>&gt; <a href="./basics/build.bat">build</a> -verbose run</b>
Compile 1 Go source file to directory "target"
Execute target "target\basics.exe"
My favorite number is 2
3.141592653589793
55
world hello
7 10
2 true false no!
Type: bool Value: false
Type: uint64 Value: 18446744073709551615
Type: complex128 Value: (2+3i)
Type: int32 Value: 8658
Hello 世界
Happy 3.14 Day
Go rules? true
</pre>

## <span id="hello">`hello` Example</span> [**&#x25B4;**](#top)

The project directory is organized as follows :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /v /b [A-Z]</b>
|   <a href="./hello/build.bat">build.bat</a>
|   <a href="./hello/go.mod">go.mod</a>
|   <a href="./hello/magefile.go">magefile.go</a>
|   <a href="./hello/Makefile">Makefile</a>
|
\---src
    +---main
    |       <a href="./hello/src/main/hello.go">hello.go</a>
    |
    \---test
            <a href="./hello/src/test/hello_test.go">hello_test.go</a>
</pre>

Command [**`build.bat`**](./hello/build.bat) executes the Go command `%GOROOT%\bin\go build` with the appropriate parameters and runs the generated executable `hello.exe` :

<pre style="font-size:80%;">
<b>&gt; <a href="./hello/build.bat">build</a> -verbose run</b>
Compile 1 Go source files to directory "target"
Execute target "target\hello.exe"
hello, world
</pre>

Build tool [`mage.exe`][mage_cli] takes its Makefile-like runnable targets from the Go file [`mage.go`](./hello/mage.go); for instance targets **`clean`** and **`build`** :

> **Note** : Mage supports a makefile-style tree of dependencies using the helper library [`github.com/magefile/mage/mg`](https://magefile.org/dependencies/). To declare dependencies, pass any number of dependent functions to `mg.Deps`.

<pre style="font-size:80%;">
<b>&gt; <a href="https://magefile.org/magefiles/">mage</a> clean build &amp; target\hello.exe</b>
hello, world
</pre>

Adding the Mage option **`-v`** will print some progress messages :

<pre style="font-size:80%;">
<b>&gt; <a href="https://magefile.org/magefiles/">mage</a> -v clean build & target\hello.exe</b>
Running target: Clean
Running target: Build
hello, world
</pre>

Finally, one may also invoke the [Mage target][mage_targets] **`run`** directly (target **`run`** requires at least one argument, thus the dummy argument `0` below):

<pre style="font-size:80%;">
<b>&gt; <a href="https://magefile.org/magefiles/">mage</a> clean run 0</b>
hello, world
</pre>

*WIP*

***

*[mics](https://lampwww.epfl.ch/~michelou/)/June 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[mage_cli]: https://magefile.org/
[mage_targets]: https://magefile.org/targets/
[windows_batch_file]: https://en.wikibooks.org/wiki/Windows_Batch_Scripting
