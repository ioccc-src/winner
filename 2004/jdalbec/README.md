## To build:

``` <!---sh-->
    make
```

There is an alternate version that allows one to control the number of numbers
to print on a line. See [alternate code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2004/jdalbec in bugs.html](../../bugs.html#2004_jdalbec).


## To use:

``` <!---sh-->
    ./jdalbec number ...
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

This version lets you control how many numbers to show on a line before adding a
newline as it can be harder to see when there are a lot of numbers. For lines
that don't end up having too many line breaks it also makes it easier to see
which line it is on.


### Alternate build:

``` <!---sh-->
    make alt
```

The macro [Ag](https://en.wikipedia.org/wiki/Silver) controls how
many number of lines to print on a line. Set at default to 11 protons, salt, if
you wish to make it silver, 47 (a prime) protons, do:


``` <!---sh-->
    make clobber Ag=47 alt
```

though it might be odd to have 47 numbers on a line as it would defeat the
purpose. :-) Or if you prefer some prime, golden irony:


``` <!---sh-->
    make clobber Ag=79 alt
```


### Alternate use:

Use `jdalbec.alt` as you would `jdalbec` above.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

We still aren't sure whether or not this is a useful program, but
it's the first atomic fission we've seen in the IOCCC.


## Author's remarks:

It's elementary!

See <http://mathworld.wolfram.com/LookandSaySequence.html> and
<http://mathworld.wolfram.com/CosmologicalTheorem.html> and the references
listed there.

Go read the web pages and come back.

This program implements the [look-and-say sequence (one of the above listed
links)](https://mathworld.wolfram.com/LookandSaySequence.html) with the added
feature that each "decay product" is automatically split into its constituent
"elements" separated by spaces.  Furthermore, arguments passed to the program
are treated as separate elements for the purpose of computing further decay
products.  (Compare the output of `./jdalbec 1`, `./jdalbec 11`, and `./jdalbec
1 1`.)  This allows output lines from the program to be passed back to the
program as input (minus the initial generation number).

The common elements are listed in
[CosmologicalTheorem.html](http://mathworld.wolfram.com/CosmologicalTheorem.html).
The non-[primordial](https://en.wikipedia.org/wiki/Primordial_nuclide)
[transuranic elements](https://en.wikipedia.org/wiki/Transuranium_element) are
the [isotopes](https://en.wikipedia.org/wiki/Isotope) of
[Neptunium](https://en.wikipedia.org/wiki/Neptunium) and
[Plutonium](https://en.wikipedia.org/wiki/Plutonium).  Isotopes of a given
[element](https://en.wikipedia.org/wiki/Chemical_element) differ only in the
last digit.  Four common elements could also be written as isotopes of these two
elements: `He=Np(2)`, `Li=Pu(2)`, `Ta=Np(3)`, `W=Pu(3)`.  To get other isotopes,
just change the last digit to a number greater than 3.

The build file runs [jdalbec.c](%%REPO_URL%%/2004/jdalbec/jdalbec.c) through the C preprocessor to
generate `jdalbec2.c` which is edited with `ed(1)` (NOTE: this was
changed to `sed(1)` by the judges) to correct spacing
problems caused by some preprocessors.  (I know you dislike
Perl, but hopefully `ed(1)` is more common on POSIX systems than
Perl.)  The build file then compiles `jdalbec2.c]` and removes the
`jdalbec2.c` file.

I don't think I'm abusing the [Makefile](%%REPO_URL%%/2004/jdalbec/Makefile) since I'm only using
147 characters including white space and the `#!` line and the
commented-out `-Wall -pedantic` options.  The [rules for the
16th IOCCC](../rules.txt) specifically allowed build files up to 521
characters long so my build file would have been well within
those limits.  (What typo?)

`gcc -E -Wall -pedantic` complains that trigraphs are present and that
`"pasting ... does not yield a valid processing token"`.

`gcc -ansi -Wall -pedantic` complains about `#line` directives,
trigraphs, and expressions and statements that have no effect.
The last complaint is false in all but one case.  Removing
the offending expressions causes some compilers to report
syntax errors because they can't determine whether a name
refers to a variable or a type.

Since buffer overflows are a common security problem these
days I have stolen the idea of using a "safe" buffer API from
`vsftpd`.  This means the program should never crash, right?

The program was tested on:
AMD K6/MMX 266MHz, Debian GNU/Linux testing "Sarge", gcc 3.3.2
Intel 486DX 33MHz, Red Hat Linux 7.3, gcc 2.96
PowerPC Macintosh G4 Quicksilver, Mac OS X 10.3.2, gcc 3.3
PowerPC Macintosh G4 Quicksilver, Mac OS X 10.1.5, cc 2.95.2
PowerPC Macintosh Performa 5200CD, Mac OS 8.6, CodeWarrior 11
Sun SPARC Ultra 10, Solaris 8, gcc 3.2

Compiling on Mac OS 8.6 requires some degree of manual
intervention because Mac OS 8.6 doesn't have shell scripting
or even a normal command prompt.  The `CodeWarrior` 11 compiler
is the reason I had to use trigraphs.  I have to preprocess
`jdalbec.c` without trigraphs, save the result as `jdalbec2.c`, then
compile `jdalbec2.c` with trigraphs to get the program to work.
I also have to add an include file and a function call to the
program to get a pseudo command line so I can pass arguments.
The compiler also requires function prototypes by default,
which is why I have prototypes for all my functions.

Compiling on Mac OS X 10.1.5 requires changing `??=` to `#` on
line 3 because the compiler doesn't recognize `??=` as a trigraph
(which I consider a compiler bug).  The initial preprocessing
step on Mac OS X 10.1.5 generates lots of errors in "smart
mode" because the "smart" preprocessor expects a valid C
program as input.  The preprocessor then falls back to "basic
mode" and preprocesses [jdalbec.c](%%REPO_URL%%/2004/jdalbec/jdalbec.c) successfully without warnings,
even when I give it the `-Wall -pedantic` options.  It inserts
a lot of extra spaces into the preprocessed output which is
why I had to add the `ed(1)` step to the build file so that my
macro `#defines` would work.  The compile step gives the usual
messages with `-Wall -pedantic`.  The link step generates a
warning about a name conflict between my `BC()` and a `BC()` from
curses in the main system library.


### <del>BUGS</del> FEATURES:

Arguments matching `/[^2]22$/` cause the program to segfault
after rapidly exhausting the available stack space.  I could
probably fix this by adding some special cases to the code,
but [Blaine the Mono] it's quite a bit more exciting this way,
don't you think?[/Blaine]  Since the trailing `22` will be
its own atom anyway, you can just insert a space in front of
it if you run into this feature (e.g. `1 22` instead of `122`).

Note: you may want to be sure you have a limit on stack size before trying this.
I ran it on Debian GNU/Linux and discovered that I did not have a limit on stack
size.  Fortunately the OS killed the process after a while.  This is consistent
with the output of [1996/schweikh3](%%REPO_URL%%/1996/schweikh3/schweikh3.c) which reports
`malloc lied!  Killed by SIGKILL`.

Arguments matching `/(?:.){10,}/` will produce visually incorrect
results (e.g., generation 1 starting from 1111111111 will
print as `: 1`), but there's nothing interesting about these
arguments that can't be modeled using shorter runs of the same
symbol.

Arguments matching `/(?:.){257,}/` may produce mathematically
incorrect results (e.g., generation 1 starting from a string
of 257 `1`s will be calculated as `11`); the remark from the
previous paragraph applies here also.

The program has exactly 2004 IOCCC countable bytes.  It's
tailor-made for this competition!

Although there are no comments, the program still manages to
be self-documenting in an obscure fashion (periodic table of
the (non-primordial) elements, "OBFUSCATED C").


### Obfuscation

The program is obfuscated:

- By invoking `cpp` twice.
- By the use of `#define`s.
- By the use of `typedef`s.
- By the use of global constants.
- By the use of global functions that replace the standard ones (I particularly
like substituting `At` ([Astatine](https://en.wikipedia.org/wiki/Astatine),
highly unstable) for `abort()`.) By overloading symbols (For example, `B` is a
type, a structure, a structure member, a macro parameter, and a variable.).
- By standard tricks like writing `'\0'` as `1["3"]` or `2["22"]`.
- By using ternary operators to avoid `else`.
- By using the `Sb()` function to create sub-buffers from either end.
- By naming everything after chemical elements or pairs of elements.
- Because it says so in the source. ;)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
