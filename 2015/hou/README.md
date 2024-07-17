## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2015/hou in bugs.html](../../bugs.html#2015_hou).


## To use:

``` <!---sh-->
    echo something | ./prog
    ./prog < file
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

A good start for understanding this entry might be
[rfc1321.txt](rfc1321.txt). How does it compute this using only a
single looping construct? The original reference source code for this
algorithm is about 355 lines of code, yet this entry is only 199 lines with
one statement per line and it isn't using lots of macro expansion tricks like
the reference code!

Some things that make you go, "huh?"

``` <!---sh-->
    ./prog < prog.c | cut -c-5
    ./prog < Makefile | cut -c-4
```

How are those values magically returned?

What happens with a large file? Something over 256K.

``` <!---sh-->
    ./prog < large_file
```

Where does that message come from?


## Author's remarks:

This looks like a normal C program.

Almost everything is a `double`.

There are tell-tale signs like `pow(2,(?/12))` and `exp(-?*?)` (names redacted).
You can also find a bunch of cosines and polynomial evaluations.

It looks like a ????? ???????????, right?

Run and find out.


### Why obfuscated

Some poor scripting folks only have access to doubles (Jav?script, L?a, BA?IC,
etc.).

As a C programmer, I feel obliged to show a gesture of sympathy, to experience
their pain and provide an answer.

Except when absolutely necessary (`printf`, `int main()`, array indexing), there
isn't a single integer. Even `getchar()` and `EOF` are immediately converted.

Since `bool` counts as an integer type too, there is no boolean either. No
comparison, no `if`, no `?:`, no `||` `&&`. Everything is done in a single loop
that terminates on `printf(3)`. Straight up arithmetic.

`floor(3)` and `ceil(3)` are technically double-to-double functions, but they feel
like cheating. Yes `cos(3)`, no `floor(3)`.


### Limitations

Hard requirements:

* The platform must implement the `double` type as IEEE754-compliant 64-bit
floating point numbers.  The 80-bit intermediate format used by x87 is
considered as an violation of this. The code should print an error message on
such platforms.

* The program must start with the CPU / FPU in round-to-nearest mode.

Soft requirements:

* The compiler must respect `volatile`. The code is formatted to warn about
that, though.

* The printed result is only correct on little-endian machines. The program
takes care to warn about this issue after printing an incorrect big-endian
result. Error messages become garbled, though.

Tested platforms:

* Linux 3.18.7, Rasperberry Pi 2, clang 3.0-6.2, (works)
* Linux 3.18.7, Rasperberry Pi 2, gcc 4.6.3, (works)
* Mac OS X 10, x64, Apple LLVM version 6.1.0 (clang-602.0.53), (works)
* Windows 8.1, x86, MSVC 2012 (works)
* Windows 8.1, x64, MSVC 2012 (works)
* Windows 8.1, x86, MinGW gcc 4.6.2 (fails, prints error message)
* Windows 8.1, x86, MinGW gcc 4.6.2 with -msse2 -mfpmath=sse (works)

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
