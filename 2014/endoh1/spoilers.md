# Q(uine)R code generator

## What is difficult?

As you may know, QR code (specification: ISO/IEC 18004) is quite complex.  It
requires a bit stream, Reed-Solomon codes, BCH codes, data relocation, big (and
irregular!) numerical tables, human-oriented pattern arrangement (difficult to
implement by a small program), etc.

On the other hand, a quine has a big restriction: it needs to have two copies of
the program!

Do you think that it is possible to write QR code encoder in C within *1kB*?


## How did I achieve that?

It is known that we can mitigate the quine restriction by `eval`.
For example, this is a quine written in Ruby:

``` <!---ruby-->
    eval s="print 'eval s='; p s"
```

Note that `print` appears just once in the program.

To emulate this approach in C, I adopted the following structure.

```
    char s[]="<main code>int main() { <VM code> }";
    int main() { <VM code>; }
```

* `<VM code>` : An own VM implementation (written in C) that executes the main
code.
* `<main code>` : An object code of quine and QR code encoder (written in the
assembly language of the VM).

`<main code>` (about 1100 bytes) appears once and `<VM code>` (about 450 bytes)
appears twice.  So the whole code is about 1100 + 450 * 2 = 2000 bytes.  Hooray!


## What sort of VM is that?

The VM is a kind of stack machine which makes the object code compact.  The
instruction set is carefully selected to minimize the sizes of both `<main
code>` and `<VM code>`.

* 21 integer registers access
  * read, write, inc-and-read, dec-and-read
* Binary operations
  * add, sub, mul, div, mod, xor, less than, equal, right shift
* Stack operation
  * push (an immediate value)
* Heap access
  * load, store
* If-Then-Else
* While-Loop
* Misc.
  * putchar, exit

The instructions have variable lengths, but many of them are represented as one
printable character.  (See [machine.rb](%%REPO_URL%%/2014/endoh1/machine.rb) and
[assemble.rb](%%REPO_URL%%/2014/endoh1/assemble.rb) in detail.) The mapping between instructions and
characters is also carefully designed to minimize `<VM code>`, which makes the
resulted program non-human-readable.


## How did I create the main code?

It is too tedious to write the machine language directly.  So I wrote the source
code in Ruby syntax and created a Ruby-to-VM compiler that involves alpha
renaming and automatic register allocation only for this purpose.

* [src.rb](%%REPO_URL%%/2014/endoh1/src.rb): the source code of QR code encoder written in Ruby syntax.
* [vm.c](%%REPO_URL%%/2014/endoh1/vm.c): the source code of the VM.

The compiler tool chain is the following.

```
    src.rb              interp.c
      |                   |
      | [parse.rb]        |
      V                   |
    ast.txt               |
      |                   |
      | [serialize.rb]    |
      V                   |
    seq.txt               |
      |                   |
      | [alpha.rb]        |
      V                   |
    alpha.txt             |
      |                   |
      | [register.rb]     |
      V                   |
    reg.txt               |
      |                   |
      | [assemble.rb]     |
      V                   |
    raw.txt               |
      |                   |
      +---------+---------+
		|
		| [link.rb]
		V
	      main.c
		|
		| [gen-prog.c]
		V
	      prog.c
```

* [parse.rb](%%REPO_URL%%/2014/endoh1/parse.rb) converts Ruby to AST.
* [serialize.rb](%%REPO_URL%%/2014/endoh1/serialize.rb) converts AST to intermediate instruction sequence.
* [alpha.rb](%%REPO_URL%%/2014/endoh1/alpha.rb) applies "alpha-renaming" to the instruction sequence.
* [register.rb](%%REPO_URL%%/2014/endoh1/register.rb) applies "register allocation".
* [assemble.rb](%%REPO_URL%%/2014/endoh1/assemble.rb) converts the sequence to the final stack-machine instructions.
* [vm.c](%%REPO_URL%%/2014/endoh1/vm.c) is an implementation of the VM.
* [link.rb](%%REPO_URL%%/2014/endoh1/link.rb) generates `main.c` by linking the instructions and interpreter source.
* `gen-prog.rb` generates [prog.c](%%REPO_URL%%/2014/endoh1/prog.c) based on `main.c`.

You can run the process by `rake` command.  `ruby-minisat` gem is needed.

``` <!---sh-->
    $ gem install ruby-minisat
    $ rake
```

## Tools

I checked that the following QR code readers can read the output of my program.

* Linux: [ZBar bar code reader][1].


### A note from the judges in 2023:

The author also tested an Android app called Barcode Scanner which used to be
found at
`https://play.google.com/store/apps/details?id=com.google.zxing.client.android`
but it appears to no longer exist.

[1]: http://zbar.sourceforge.net/

You can use [tool.rb](%%REPO_URL%%/2014/endoh1/tool.rb) to convert the output to a png file.

``` <!---sh-->
    ./main Hello | ruby tool.rb > hello.png

    $ zbarimg -q hello.png
    QR-Code:Hello

    $ ruby tool.rb prog.c
    $ ruby tool.rb prog.c | ruby tool.rb
```


## Limitations

* QR code error correction level is fixed to L (Low).
* It supports only byte mode (not numeric, alphanumeric, kanji mode...).
* The mask pattern is fixed to 4.
* The mask is not applied to the remained bits.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
