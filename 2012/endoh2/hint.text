# PiE in the sky award

Yusuke Endoh  
<mame@ruby-lang.org>  
<https://github.com/mame/>  


## Judges' comments:
### To build:

    make endoh2

### To run:

    ./endoh2 > pi.c
    gcc -o pi pi.c
    ./pi > 314.c
    ...

    ./endoh2 e > e.c  
    gcc -o e e.c
    ./e > 271.c
    ...

### Try:

    make pi
    make e
    make everything

### Selected Judges Remarks:

A pi/e printing quasi-quine in ASCII art with a compressed font in it;
what else to wish for in this program? Virtual machine emulation?

## Author's comments:
Yeah, "Again".  Sorry.  But I don't feel guilty or uncomfortable.

This entry is based on 'over-used themes' such as self reproducing
program and pi or e computation.  I know you're tired of them.


But have you ever seen **all-in-one**?


### What it is

This program generates a new program in the shape of the Greek letter
`pi`.  Then, the generated program:

- computes 3 digits of pi and prints it as a ASCII-art program that:
- computes 4 digits of pi and prints it as a ASCII-art program that:
- computes 5 digits of pi and prints it as a ASCII-art program that:
- computes 6 digits of pi and prints it as a ASCII-art program that:
- etc.

One more thing...  When you give a command line option "e" to the
first program, the generated one will compute Napier's constant
rather than pi.


### Obfuscation

This program itself is in the shape of a spigot.  This is derived
from analogy with "spigot algorithm" which infinitely computes the
value of a mathematical constant such as `pi` or `e`.

<http://en.wikipedia.org/wiki/Spigot_algorithm>

The two sets of programs, 314\*.c and 271\*.c, are almost the same
except its shape and constant computation part.  I tailored the
common part to parse in both shapes ("3.14..." and "2.71..."), by
tweaking the computation order and adding meaningless code fragment.

On the other hand, to make it fit inside one screen (80 x 25), my
program is shortened properly, more than it looks.  (As you may
know, Quine needs to make its program size doubled.)
For example, this program involves 3x5 bitmap font data of ten
characters ('0' -- '9'), as just 20 bytes: "G1%xJ{;Q7wunmuGuu%uu".
We can decode character n as `275*s[n+10] - 8*s[n] - 8`.  I solved the
system of Bezout's identities to find the magic string, with the
aid of a brute force.  See `find-font-table.rb` in detail.

<http://en.wikipedia.org/wiki/B%C3%A9zout's_identity>

I used many other tricks for short coding.

I'm sorry that many ASCII-art-style winning entries of IOCCCs
ignore preprocessor directives.  In my program, #include is a part
of ASCII-art with comment padded.

These design requirements made my program well-obfuscated
willy-nilly.


### Portability

I expect it to work in any major environment and C compiler.
To build with no warning, it requires two C99 features: string
literal more than 509 characters and omissible return in main
function.  In fact, recent compilers with "-std=c99 -Wall -W
-Wextra -pedantic" would say nothing.

    gcc -std=c99 -Wall -W -Wextra -pedantic spigot.c
    clang -std=c99 -Wall -W -Wextra -pedantic spigot.c

I've tested with gcc-4.6.3 and clang-3.0 on Linux (Ubuntu 12.04)
and gcc-4.5.3 and clang-3.1 on Cygwin.


### Synopsis

    gcc endoh2.c -o endoh2

    ./endoh2 > pi.c
    cat pi.c

    gcc pi.c     -o pi     ; ./pi     > 314.c     ; cat 314.c
    gcc 314.c    -o 314    ; ./314    > 3141.c    ; cat 3141.c
    gcc 3141.c   -o 3141   ; ./3141   > 31415.c   ; cat 31415.c
    gcc 31415.c  -o 31415  ; ./31415  > 314159.c  ; cat 314159.c
    gcc 314159.c -o 314159 ; ./314159 > 3141592.c ; cat 3141592.c
    etc...

    ./endoh2 e > e.c
    cat e.c

    gcc e.c      -o e      ; ./e      > 271.c     ; cat 271.c
    gcc 271.c    -o 271    ; ./271    > 2718.c    ; cat 2718.c
    gcc 2718.c   -o 2718   ; ./2718   > 27182.c   ; cat 27182.c
    gcc 27182.c  -o 27182  ; ./27182  > 271828.c  ; cat 271828.c
    gcc 271828.c -o 271828 ; ./271828 > 2718281.c ; cat 2718281.c
    etc...

You can do `make everything` for the process (with no `cat`).

Note: The executable may return a failure (non-zero) exit status
unless -std=c99 option is given.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
