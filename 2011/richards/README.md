## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: doesn't work with some platforms - please help us fix it**

For more detailed information see [2011/richards in bugs.html](../../bugs.html#2011_richards).


## To use:

``` <!---sh-->
    echo expression | ./richards
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Oh no, yet another
[dc](https://en.wikipedia.org/wiki/Dc_&lpar;computer_program&rpar;)-style calculator? (see
[2000/dlowe](../../2000/dlowe/index.html) using an embedded Perl interpreter and deemed `Worst
Abuse of the Rules`).  Well, this one does it (expression calculation, that is,
not the rule abuse) in a different way.  The author claims that his calculator
does just-in-time compilation.  What would you do to prove or disprove his claim
without attempting to unravel the source?


## Author's remarks:

This is an implementation of the classic UNIX
[dc](https://en.wikipedia.org/wiki/Dc_&lpar;computer_program&rpar;) command, the
[reverse Polish](https://en.wikipedia.org/wiki/Reverse_Polish_notation)
calculator. Actually it's a pretty bad implementation, since it only implements
32-bit integers (well, `sizeof(int)`-sized integers). It only implements the
commands `+`, `-`, `*`, `/`, `p` (only for numbers), register stacks, macros and
comparisons. Wow, you'd think I could've done better in 2K of code.

OH! I forgot to mention! It's a
[JIT](https://en.wikipedia.org/wiki/Just-in-time_compilation).

Wait, don't stop reading! I know what you're thinking, platform-specific code is
discouraged in IOCCC. But do you see any platform-specific code? There's no
assembler here! This
[JIT](https://en.wikipedia.org/wiki/Just-in-time_compilation) works on a dozen
platforms, and the only platform-specific assumptions it makes are that the
stack grows down and integers are at least 32-bit.

You will probably get warnings while compiling the code. In particular:

* If your system requires the inclusion of `alloca.h` to use alloca, use the
  compile flag `-DAH`.

* If your system cannot use `mmap()`, use the compile flag `-DNM`.

* I don't include any headers I don't strictly need to, so you'll get warnings
  about (at least) `memcpy()`, `isdigit()`, `atoi()`, `calloc()`, `malloc()`
  and `alloca()` if you didn't use `-DAH`.
        - NOTE from judges: we added these includes in 2023.

* GCC likes to complain about `while (a = b)` (assignments as a condition).

* I don't return from `main()`, even though it's declared to return `int`.

Platforms on which all known/tested optimization levels work with no additional
flags:

 * gcc 4.6.2 + x86[\_64] + GNU/Linux, Mac OS X or Windows
 * clang 2.9-16 + x86[\_64] + GNU/Linux or Mac OS X
 * tcc 0.9.25
 * gcc 4.4.5 + alpha, arm, mips[el], powerpc[64], s390x (IBM zSeries)
 * gcc 4.1.3 + vax + NetBSD

Platforms which work but not at all optimization levels or needing special
flags:

 * owcc 1.9 + x86 + Windows: Needs `-DNM -DAH -fno-stack-check`
 * gcc 4.4.5 + sh4: -O0 works, higher optimization levels don't work for unknown reasons.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
