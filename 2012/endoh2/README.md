## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./endoh2 > pi.c
    gcc -o pi pi.c
    ./pi > 314.c
```

and:

``` <!---sh-->
    ./endoh2 e > e.c
    gcc -o e e.c
    ./e > 271.c
```

...


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

A
[pi](https://en.wikipedia.org/wiki/Pi)/[e](https://en.wikipedia.org/wiki/E_&lpar;mathematical_constant&rpar;)
printing quasi-[quine](https://en.wikipedia.org/wiki/Quine_&lpar;computing&rpar;) in [ASCII
art](https://en.wikipedia.org/wiki/ASCII_art) with a compressed font in it; what
else to wish for in this program? [Virtual
machine](https://en.wikipedia.org/wiki/Virtual_machine) emulation?


## Author's remarks:

Yeah, "Again".  Sorry.  But I don't feel guilty or uncomfortable.

This entry is based on 'over-used themes' such as self reproducing
program and [pi](https://en.wikipedia.org/wiki/Pi) or
[e](https://en.wikipedia.org/wiki/E_&lpar;mathematical_constant&rpar;) computation.  I
know you're tired of them.

But have you ever seen them **all-in-one**?

### What it is

This program generates a new program in the shape of the Greek letter
`pi`.  Then, the generated program:

- computes 3 digits of pi and prints it as an ASCII-art program that:
- computes 4 digits of pi and prints it as an ASCII-art program that:
- computes 5 digits of pi and prints it as an ASCII-art program that:
- computes 6 digits of pi and prints it as an ASCII-art program that:
- ...

One more thing...  When you give a command line argument `e` to the
first program, the generated one will compute [Napier's
constant](https://en.wikipedia.org/wiki/E_&lpar;mathematical_constant&rpar;)
rather than pi.


### Obfuscation

This program itself is in the shape of a
[spigot](https://en.wikipedia.org/wiki/Tap_&lpar;valve&rpar;).  This is derived as an
analogy with [spigot algorithm](https://en.wikipedia.org/wiki/Spigot_algorithm)
which infinitely computes the value of a mathematical constant such as
[pi](https://en.wikipedia.org/wiki/Pi) or
[e](https://en.wikipedia.org/wiki/E_&lpar;mathematical_constant&rpar;).

The two sets of programs, `314*.c` and `271*.c`, are almost the same
except their shape and constant computational part.  I tailored the
common part to parse in both shapes (`3.14...` and `2.71...`), by
tweaking the computational order and adding meaningless code fragments.

On the other hand, to make it fit inside one screen (80 x 25), my program is
shortened properly, more than it looks.  (As you may know,
[quines](https://en.wikipedia.org/wiki/Quine_&lpar;computing&rpar;) need to make its
program size doubled.) For example, this program involves 3x5 bitmap font data
of ten characters (`0` -- `9`), as just 20 bytes: `G1%xJ{;Q7wunmuGuu%uu`.  We
can decode character `n` as `275*s[n+10] - 8*s[n] - 8`.  I solved the system of
[Bézout's identity](https://en.wikipedia.org/wiki/B%C3%A9zout%27s_identity) to
find the magic string, with the aid of a brute force.  See `find-font-table.rb`
in detail.

I used many other tricks for short coding.

I'm sorry that many ASCII-art-style winning entries of
[IOCCC](../../years.html) ignore [C preprocessor
directives](https://en.wikipedia.org/wiki/C_preprocessor).  In my program,
`#include` is a part of ASCII-art with comments padded.

These design requirements made my program well-obfuscated
willy-nilly.


### Portability

I expect it to work in any major environment and C compiler.  To build with no
warning, it requires two C99 features: allow string literal to be more than 509
characters and not requiring a return in `main()`.  In fact, recent compilers
with `-std=c99 -Wall -W -Wextra -pedantic` would say nothing.


``` <!---sh-->
    gcc -std=c99 -Wall -W -Wextra -pedantic spigot.c
    clang -std=c99 -Wall -W -Wextra -pedantic spigot.c
```

I've tested with gcc-4.6.3 and clang-3.0 on Linux (Ubuntu 12.04)
and gcc-4.5.3 and clang-3.1 on Cygwin.


### Synopsis

``` <!---sh-->
    cc endoh2.c -o endoh2

    ./endoh2 > pi.c
    cat pi.c

    cc pi.c     -o pi     ; ./pi     > 314.c     ; cat 314.c
    cc 314.c    -o 314    ; ./314    > 3141.c    ; cat 3141.c
    cc 3141.c   -o 3141   ; ./3141   > 31415.c   ; cat 31415.c
    cc 31415.c  -o 31415  ; ./31415  > 314159.c  ; cat 314159.c
    cc 314159.c -o 314159 ; ./314159 > 3141592.c ; cat 3141592.c
    etc...

    ./endoh2 e > e.c
    cat e.c

    cc e.c      -o e      ; ./e      > 271.c     ; cat 271.c
    cc 271.c    -o 271    ; ./271    > 2718.c    ; cat 2718.c
    cc 2718.c   -o 2718   ; ./2718   > 27182.c   ; cat 27182.c
    cc 27182.c  -o 27182  ; ./27182  > 271828.c  ; cat 271828.c
    cc 271828.c -o 271828 ; ./271828 > 2718281.c ; cat 2718281.c
    etc...
```

You can do `make everything` for the process (with no `cat`).

Note: The executable may return a failure (non-zero) exit status
unless `-std=c99` option is given.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
