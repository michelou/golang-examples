# <span id="top">Book <i>Functional Programming in Go</i></span> <span style="size:30%;"><a href="../README.md">⬆</a></span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://golang.org/" rel="external"><img style="border:0;" src="../docs/images/go-logo-blue.svg" width="120" alt="Go project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">Directory <strong><code>meeus-examples\</code></strong> contains <a href="https://golang.org/" rel="external" alt="Go">Go</a> code examples presented in Dylan Meeus book "<a href="https://www.packtpub.com/product/functional-programming-in-go/9781801811163"><i>Functional Programming in Go</i></a>" (Packt 2023).
  </td>
  </tr>
</table>

## <span id="FirstClassFuncs">`FirstClassFuncs` Example</span>

Command [`build.bat`](./FirstClassFuncs/build.bat) executes the Go command `%GOROOT%\bin\go build` with the appropriate parameters and runs the generated executable `FirstClassFuncs.exe` :

<pre style="font-size:80%;">
<b>&gt; <a href="./FirstClassFuncs/build.bat">build</a> -verbose run</b>
Compile Go source files to directory "target"
Execute target "target\FirstClassFuncs.exe"
input: [1 1 2 3 5 8 13]
i > 5: [8 13]
</pre>

Build tool [`mage.exe`][mage_cli] takes its Makefile-like runnable targets from the Go file [`mage.go`](./FirstClassFuncs/mage.go); for instance targets **`clean`** and **`build`** :

> **Note** : Mage supports a makefile-style tree of dependencies using the helper library [`github.com/magefile/mage/mg`](https://magefile.org/dependencies/). To declare dependencies, pass any number of dependent functions to `mg.Deps`.

<pre style="font-size:80%;">
<b>&gt; <a href="https://magefile.org/magefiles/">mage</a> clean build &amp; target\FirstClassFuncs.exe</b>
input: [1 1 2 3 5 8 13]
i > 5: [8 13]
</pre>

Adding the Mage option **`-v`** will print some progress messages :

<pre style="font-size:80%;">
<b>&gt; <a href="https://magefile.org/magefiles/">mage</a> -v clean build & target\FirstClassFuncs.exe</b>
Running target: Clean
Cleaning...
Running target: Build
Building...
input: [1 1 2 3 5 8 13]
i > 5: [8 13]
</pre>

Finally, one may also invoke the [Mage target][mage_targets] **`run`** directly (target **`run`** requires at least one argument, thus the dummy argument `0` below):

<pre style="font-size:80%;">
<b>&gt; <a href="https://magefile.org/magefiles/">mage</a> clean run 0</b>
input: [1 1 2 3 5 8 13]
i > 5: [8 13]
</pre>

*WIP*

***

*[mics](https://lampwww.epfl.ch/~michelou/)/February 2025* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[mage_cli]: https://magefile.org/
[mage_targets]: https://magefile.org/targets/
[windows_batch_file]: https://en.wikibooks.org/wiki/Windows_Batch_Scripting
