## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    echo Some text | ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Before analysing the code in detail we were able to guess two out of four tests
this entry uses to tell the 5 languages/flavors apart. Can you find all four?

The way the text is encoded in the output doesn't cease to amaze. Can you tell
why an array of 512 elements is needed?

NOTE: the author calls the program `Fuuko` and so the source file referred to in
their remarks uses `fuuko.c`. The [Makefile](%%REPO_URL%%/2015/yang/Makefile) will compile everything
so you need not worry about this.


## Author's remarks:

`Fuuko` is a [sea star](https://en.wikipedia.org/wiki/Starfish) generator.  Feed
her some input through `stdin` to get lots of sea star patterns on `stdout`.

``` <!---sh-->
    cc -O3 -std=c90 fuuko.c -lm -o fuuko_c90
    echo IOCCC | ./fuuko_c90 > output_c90.c
```

If you compile with a C99 compiler instead of C90, the sea stars will
have eyes.

``` <!---sh-->
    cc -O3 -std=c99 fuuko.c -lm -o fuuko_c99
    echo IOCCC | ./fuuko_c99 > output_c99.c
```

Don't like [sea stars](https://en.wikipedia.org/wiki/Starfish)?  Use a C++98
compiler to get a [dango](https://en.wikipedia.org/wiki/Dango) instead.

``` <!---sh-->
    g++ -O3 -std=c++98 fuuko.c -lm -o fuuko_cpp98
    echo IOCCC | ./fuuko_cpp98 > output_cpp98.c
```

Don't like [dango](https://en.wikipedia.org/wiki/Dango) either?  Use a C++11
compiler to get just [circles](https://en.wikipedia.org/wiki/Circle) (or [Swiss
cheese](https://en.wikipedia.org/wiki/Swiss_cheeses_and_dairy_products), if you
prefer that).

``` <!---sh-->
    g++ -O3 -std=c++11 fuuko.c -lm -o fuuko_cpp11
    echo IOCCC | ./fuuko_cpp11 > output_cpp11.c
```

Don't like any of these patterns?  Use a C11 compiler and there will be
no extra pattern.

``` <!---sh-->
    cc -O3 -std=c11 fuuko.c -lm -o fuuko_c11
    echo IOCCC | ./fuuko_c11 > output_c11.c
```

Regardless of which of these C/C++ dialects you choose, the output
will all be valid C90 code that reproduces original input on `stdout`,
filled with pointer dereferences (C stars).

Next time people ask you for a few pointers on C, you can run their
question through `Fuuko` and give them pointers all day long.


### Compatibility

`Fuuko` has been tested under these environments:

- gcc 4.9.3 on Cygwin
- gcc 4.9.2 on Linux
- gcc 4.8.4 on Linux
- gcc 4.6.3 on Linux (doesn't support C11 nor C++11)
- gcc 4.3.5 on JS/Linux
- clang 3.5.2 on Cygwin (doesn't work with optimization enabled,
  probably cygwin bug)
- clang 3.5.0 on Linux
- clang 3.4.1 on Linux
- tcc 0.9.25 on JS/Linux (C99 only)


### Features

The most obscure parts are in detecting the subtle differences in
different dialects.  The standard committees put a lot of effort into
avoiding "quiet changes", but `Fuuko` is still able to exploit a few of
those.  It should be an interesting exercise for the reader to figure
how she did it.

Output patterns are usually random (except for C11).  The built-in random number
generator is seeded using
[ASLR](https://en.wikipedia.org/wiki/Address_space_layout_randomization).  On
systems where ASLR is not so random (such as cygwin), you can introduce
randomness by changing number of command line arguments to `Fuuko`.

Output is somewhat robust: corruption on most of the lines will
usually result in a compiler warning.  This is because the output is
vastly redundant: For ~1K of input, expect output to be on the order
of ~1MB, and take ~500MB of RAM to compile.

[CRC32](https://en.wikipedia.org/wiki/Computation_of_cyclic_redundancy_checks#CRC-32_algorithm)
of source code is embedded in the source code itself.

The process of writing this program can be seen by opening
[deobfuscation.html](deobfuscation.html) in a browser that supports JavaScript.

Code layout is inspired by [Ibuki
Fuuko](https://clannad.fandom.com/wiki/Fuko_Ibuki), for her love of sea stars.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
