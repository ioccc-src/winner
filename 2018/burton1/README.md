## To build:

``` <!---sh-->
    make
```

There is an alternate version of this entry. See [Alternate
code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./prog < any-file
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

An alternate version of this entry, [prog.alt.c](%%REPO_URL%%/2018/burton1/prog.alt.c), is provided
This alternate code was supposed to compile without warnings, however
with modern compilers this is no longer the case so it will only cleanly compile
with `-Wno-` options.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `prog.alt` as you would `prog`.


## Judges' remarks:

One line, one array, one loop and one statement but it prints many bytes. It won.


## Author's remarks:

Feed this anything on `stdin`.

The included [scripthd.sh](%%REPO_URL%%/2018/burton1/scripthd.sh) may be used as a driver program for this entry.
It adds several nice-to-have features, and allows salt-to-taste customizability.

This code has been compiled and tested on:

* OSX-10.11, gcc 4.2.1 and clang 3.0, -O0 and -O3
* X86-Linux, gcc 4.1.2 and 4.8.4, -O0 and -O3
* ARM-QEMU, gcc 4.8.4, -O0 and -O3
* X86-FreeBSD 10.3, clang 3.4.1, -O0 and -O3
* TCC 0.9.26 (x86-64), used as a proxy for [2001/bellard](../../2001/bellard/index.html)
* UNIX V7 pcc (Johnson's C compiler) on a [simulated PDP-11/45](http://simh.trailing-edge.com/)
  (see the "**SPOILER** section below for further detail)


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


### How this entry works:

This started life as a personal challenge: write the shortest hex dump utility
in C.

The self-imposed ground rules in the hunt for shortest:

- The code has to output correctly.
- No extraneous newlines, the code must be portable,
and without bypassing the solution using `execve(2)`, or functions built upon it
(`system(3)`, `popen(3)`, etc).

E.g:


``` <!---c-->
    main(){system("hd");}       // it's turtles all the way down!
```

is not acceptable.

And, "output correctly" is the output format of this entry.  QED.

Early attempts ended up at a reasonably short 157 characters.
This was too long for a one-liner, so it had to be formatted as something more interesting.
This solution is pleasing, but a true one-liner was the hoped-for goal.
Here is the 157 character version in it's entirety:


``` <!---c-->
    char     O,o[  20];L(O){
    putchar  ( O+  48+39  *(9<
    O));}    I(O)  {L(~     15);
    O|| puts(o);}  main     (l){
    for(;~(l=getchar())     ;I(O
    &=15     ))o[  O++      ]=4<
    (4^l     >>5)  ?l:     46,L
    (l>>     4),L  (l&15);O&&
    I(o[     O]=0  );}//157c
```

While thinking about this in the shower (you are not the only one that does this!)
came the idea which reduced the code to just 119 chars.
This dramatic reduction started to feel close to minimal, and the hunt resumed.
The progression to the present size is interesting,
and it is interesting that the same algorithm can be expressed so differently
by slight rearrangement of its parts.

``` <!---c-->
    // 119
    char O,o[20];main(l){for(;~(l=getchar());O||puts(o))o[O++]=isprint(l)?l:46,O&=15,printf("%02x ",l);O[o]=0;O&&puts(o);}
    // 116
    char O,o[20];main(l){for(;O++[o]=~(l=getchar())?4<(4^l>>5)?l:46:0;(O&=15)||puts(o))printf("%02x ",l);O>1&&puts(o);}
    // 115
    char O,o[20];main(l){for(;O[o]=~(l=getchar())?4<(4^l>>5)?l:46:0;(O=-~O&15)||puts(o))printf("%02x ",l);O&&puts(o);}
    // 113
    char O,o[20];main(l){for(;~l;(O=~l?printf("%02x ",l),-~O&15:!O)||puts(o))O[o]=~(l=getchar())?4<(4^l>>5)?l:46:0;}
    // 112
    char O,o[20];main(l){for(;~l;(O=~l?-~O&printf("%02x ",l)*5:!O)||puts(o))O[o]=~(l=getchar())?4<(4^l>>5)?l:46:0;}
    // 111
    char O,o[20];main(l){for(;~l;O||puts(o))O=(O[o]=~(l=getchar())?4<(4^l>>5)?l:46:0)?-~O&printf("%02x ",l)*5:!O;}
    // 110
    char O,o[0];main(l){for(;~l;O||puts(o))O=(O[o]=~(l=getchar())?4<(4^l>>5)?l:46:0)?-~O&printf("%02x ",l)*5:!O;}
    // 109
    char O,o[];main(l){for(;~l;O||puts(o))O=(O[o]=~(l=getchar())?4<(4^l>>5)?l:46:0)?-~O&printf("%02x ",l)*5:!O;}
```

There are solutions without the ASCII sidebar that are significantly shorter.
These do not compete in the same category, since their output is materially different.
They are derived from the solutions above, but are still fascinating as concise utilities,
so here is their progression, for the curious:

``` <!---c-->
    // 102
    I;O(O){putchar(O+48+39*(9<O));}main(l){for(;~(l=getchar());O(++I&15?~15:~37))O(l>>4),O(l&15);O(-38);}
    // 80
    O;main(l){while(~(l=getchar()))printf("%02x%c",l,++O&15?32:10);O&15&&puts("");}
    // 78
    O;main(l){for(;~l;(O=~(l=getchar())?printf("%02x ",l),-~O&15:!O)||puts(""));}
    // 77
    O;main(l){for(;~l;(O=~(l=getchar())?-~O&printf("%02x ",l)*5:!O)||puts(""));}
    // 76
    O;main(l){for(;~l;O||puts(&O))O=~(l=getchar())?-~O&printf("%02x ",l)*5:!O;}
```

It is possible to reduce the size of each of these by one by eliding the trailing newline.
This was not reported above since the newline kept getting appended by processing software,
and it is more interesting to remove characters by changing code than by filtering:

``` <!---sh-->
    $ tr -d '\012' < 109.c | wc -c
    108
    $ tr -d '\012' < 76.c | wc -c
    75
    $ tr -d '\012' < 109.c | cc -o 108 -xc -
    $ verify 108
    $
```

An obfuscated hex dump has been done before:
[1986/bright](../../1986/bright/index.html) is similar in function,
but it uses more characters in just setting up its obfuscation than this entire
solution!


### BIGGER SPOILER:

If you are unhappy with the way DEL (character 127) is handled,
replace the cryptic expression `4<(4^l>>5)?l:46` with `32>l|l>126?46:l`.
Both take the same number of characters, but the former is a bit more interesting.
Bonus question: how does the first expression work?


### BIGGEST SPOILER (and some history):

Technically, `char o[0];` is illegal (SS 6.7.6.2) according to ISO (N1570).  And
`char o[];` is a conditionally supported feature (SS 6.7.6.2, 6.10.8.3).
However, it works in modern C implementations as an extension, including GCC,
Clang and TCC, for X86 and ARM, on multiple operating systems (Linux, OSX/macOS,
FreeBSD), so it is _functionally_ correct.  MicroSoft Visual C++ does not allow
`char o[]` or `char o[0]`, and implements its close relative `char o[1]` such
that writing more than a single char will cause a fault, which is _technically_
correct.

But how does this work at all, even as an extension?  `o[]` allocates one(!)
byte in a zero-filled data area (formerly
[.bss](https://en.wikipedia.org/wiki/.bss) language).  The UNIX-derived systems this code
was run upon all place the storage of `O` and `o` into a zero-filled VM page
with nothing following: thus, there are plenty of available and unused zero
bytes following `O`, addressed via `o`, and this code only needs 17. This is
_undefined_ behavior, but as shown, it is widely available.

The [1979 Seventh Edition UNIX][1] (v7) system pre-dates the IOCCC by several years,
and the source code to `sh`(1) was a **significant inspiration for this contest**.
See the
FAQ on "[IOCCC beginnings](../../faq.html#ioccc_start)".
There are two C compilers present: `cc` written by Dennis Ritchie, and `pcc` written by Steven Johnson.
The nested conditional expressions in 116 and smaller are too complex for `cc` ("Illegal conditional")
but `pcc` handles them correctly, and neither compiler accepts `char o[]` or
`char o[0]` and neither put the bytes in a zero-filled page (as a paged VM was
not yet written for UNIX).

[1]: http://minnie.tuhs.org/cgi-bin/utree.pl
[2]: https://web.archive.org/web/20180521074522/http://www.computerworld.com.au/article/279011/a-z_programming_languages_bourne_shell_sh/?pp=4

More significant is that v7 `printf(3)` does not report the number of characters
written, and therefore 111 compiles but does not work correctly; 113 is the
shortest code that compiles and runs correctly in Ancient UNIX.

Interesting digression: v7 `printf` (`_doprnt`) was written in PDP-11 assembly.
It pre-dates `varargs.h`, and assembly was the only way to gain access to the
variable argument types.  The first edition _The C Programming Language_, 1978,
page 71, remarks:

> By the way, there is no entirely satisfactory way to write a portable function
that accepts a variable number of arguments, because there is no portable way
for the called function to determine how many arguments where actually passed to
it in a given call.  ...  `printf`, the most common C function with a variable
number of arguments, ... is also non-portable and must be modified for different
environments.

It is fascinating to explore the roots of C through the history of the operating
system it was birthed within.  C is often criticized as a difficult, inscrutable
language, but as this contest demonstrates, this is in parody.  _Shell-gol_ is
one of those instances where someone [preferred a different language][2], and
(ab)used the preprocessor to re-mold C into something they found comfortable.
Most of the rest of the system, especially in the kernel, are models of clarity
and efficient expression.

### TL;DR:

So which version is the shortest, portable hex dump?

* 109 works with (most?) modern Unix-like systems and compilers, see example list above.
* 111 works adds Microsoft, is standards-approved, and does not exploit undefined behavior.
* 113 works on Ancient UNIX and the portable C compiler.
* 119 works on all platforms, including the original Ritchie PDP-11 C compiler.

### Final remarks:

Clearly, the smallest possible program violates modern best practice.
It is not even possible to compile cleanly, but it will compile correctly.

Included is [prog.alt.c](%%REPO_URL%%/2018/burton1/prog.alt.c), a modern C implementation that is --
perhaps -- the smallest, clean-compiling version using `clang` or `gcc` with
`-Wall -pedantic`.  Note that while this is larger than all but the original
attempt, it will *not* work with the original Ritchie PDP-11 C compiler, since
the expression within the ternary remains too complex.

Try:

``` <!---sh-->
    cat prog.c prog.alt.c
```

or

``` <!---sh-->
    cmp -b prog.c prog.alt.c
```

to compare the differences (`diff` is not helpful on a one-liner).

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
