## To build:

``` <!---sh-->
    make
```

There is an alternate version that compiles [mkentry.c](%%REPO_URL%%/2000/tomx/mkentry.c). See
[Alternate code](#alternate-code).


## To use:

``` <!---sh-->
    ./tomx
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

This alternate code is based on the author's remarks with a slight fix so that
it will do what it once did, compile and run [mkentry.c](%%REPO_URL%%/2000/tomx/mkentry.c). You can use
it in a similar way as [tomx.c](%%REPO_URL%%/2000/tomx/tomx.c), both executing the source file and
using it as a Makefile and running the code ends up running `mkentry`.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

Polyglots have come and gone, but this was the first one we'd seen
where one language *used* another to perform its tasks.  An interesting
approach.  Admittedly, it's not all that obfuscated - but there's more
to it than you might think, since you have to make sure that your
changes don't change the shell code or the Makefile.


## Author's remarks:

### Summary

This program works as a C source file, a Makefile and also as a shell
(`/bin/sh`) script. But unlike some other multi-language programs, this one is
NOT meant to print `Hello, world` in all 3 cases (At least in the true sense
;-)). The C, Makefile and shell code build upon each other to create a C program (?)
which when executed as a shell script will compile itself through the C compiler
using a Makefile! - Pretty useful, Eh?

Probably, this is the first entry ever to fully satisfy Rule #1 ("Your entry
must be a complete program") in the strictest sense;-)


### Top 5 reasons (IMHO) why this code is an entry for IOCCC

1. A glance at the source itself will tell you that most of the
Obfuscation is NOT in the C code per se, but in the comments
to the C code. (But sadly, I could not find an "International
Obfuscated C COMMENT contest". So I HAD to send this entry
here to the IOCCC itself).

2. Of the 3 languages in the source, the least obfuscated is
C (But again, there was NO obfuscated make/shscript contest)
(Does this hint for a rule in IOCCC-2001 that the major
obfuscation should be in C and not elsewhere???. Mmmmm...).

3. Extending Argument #2... Obfuscation done in the C code
(comments?) creates obfuscated code for the other 2 languages.
This opens new possibilities to be explored in depth in future
`IOCCC`s.

4. LOOKS like a Makefile, WORKS like a shell script and COMPILES
like a C program.

5. Does something useful (See Notes #1 and #2 below).


### Notes

1. The program could have been something other than the simple "Hello, world"
program that it is. It is possible to do `#include "prog2.c"` in the place of
the `main()`, leaving the complexities of the C file elsewhere and making this
source still acceptable to `make` and `sh`. The following modification to the
last few lines will compile the IOCCC's famous [mkentry.c](%%REPO_URL%%/2000/tomx/mkentry.c).

``` <!---makefile-->
    .PHONY: /* true clean */
    #undef   true
    #include "mkentry.c"
```

Ain't that useful?

2. By extending this program's idea, It is possible to do some
very interesting things like generating C code on execution
by adding additional code in  make/sh (open up a loop????).
This opens the possibilities of generating & compiling some
(obfuscated?) C code. (Maybe should try this if this program
fails at IOCCC 2000)

3. Changing the `%:%.c` dependency to a `$(PROG):$(PROG).c` form
can compile this program with some other `make`s (I got it to
work in Windows using nmake and Gnuwin32's sh ;-) )

4. Interesting things to do: try `./tomx.c clean`. This will
do the same as `make clean` :-)). Also: `./tomx.c all`

5. Be careful about the tabs in the source code. Removing them
or converting tabs to spaces can be disastrous.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
