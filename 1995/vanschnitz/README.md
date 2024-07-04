## To build:

``` <!---sh-->
    make all
```

The authors provided a deobfuscated version, originally uuencoded but uudecoded by us
in 2023. See [Alternate code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: missing file - please provide it
```

For more detailed information see [1995/vanschnitz in bugs.html](../../bugs.html#1995_vanschnitz).


## To use:

``` <!---sh-->
    ./vanschnitz
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

The authors provided a deobfuscated version of the program. Originally uuencoded we
have decoded it for the wider audience in [vanschnitz.alt.c](%%REPO_URL%%/1995/vanschnitz/vanschnitz.alt.c).

They encourage you to first try and figure out the program without reading the
deobfuscated version.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `vanschnitz.alt` as you would `vanschnitz` above.


## Judges' remarks:

Back in 1995, values of `LEVEL>8` caused some compilers (and in one case a
system) to crash during compilation. In 2023 with modern systems this is not
really a problem.

Back in 1995 we also suggested that for a bad/slow time to try `LEVEL=15` but
this is not a big deal in 2023 either.


## Authors' remarks:

A classic problem in computer science is known as the Towers
of Hanoi.  It involves a set of different-sized disks mounted
on one of three pegs.  The object is to move the pile of disks
to one of the other pegs.  You may only move one disk at a
time, and there is an additional constraint that a disk may
never be placed on top of a smaller disk.

Our program solves the Towers of Hanoi problem.  Well, that's
not exactly true; actually, it's the compiler that solves the
problem.  The resulting program just prints out the correct
solution.

How do you trick a compiler into actually solving the problem?
First, you must tell it how many disks you wish to solve it
for.  This is done by defining the symbol `n` on the compile
line.  For instance, to cause the compiler to solve the Towers
of Hanoi problem with four disks, you would compile the program
like this:

``` <!---sh-->
    gcc hanoi.c -o hanoi -Dn=4
```

A default value of `5` will be used for `n` if you do not define
it on the command line.  The value of `n` cannot be greater than
fifteen (the compiler we used to test has a limit on the `#include`
depth).  The compiler then solves the problem using binary
arithmetic based on whether particular symbols are defined or not.

To loop, the program `#include`s itself.  This is, of course, expensive; one
compile we did with `n=14` took about fifty minutes to compile on our system
(compiling with `n=15` caused our system to crash).

The resulting program that the compiler generates simply
prints out the answer.  Did I say "simply"?  Actually, the
whole resulting program consists of a single `printf(3)` statement,
consisting of a massive string constant of length `35*(2^n-1)`,
followed by `3*(2^n-1)` integers which get formatted into the
string.  For our `n=14` run, this adds up to a string constant
of length 573405, followed by 49149 integers delimited by
commas.  (Generating the string constant depends on the
ANSI C feature in which adjacent character strings are
concatenated; a version that does not use this feature has been
included for people who can only run K&R).  A good way to see
the resulting program (on a Unix system) is to do the command

``` <!---sh-->
    gcc hanoi.c -E -Dn=5 | grep -v \# | grep -v ^\$
```

For an odd number of disks, the program will provide a
solution wherein the disks end up on peg 2; for an even
number of disks, they will end on peg 3.  This should
provide some hint as to what sort of algorithm is used.

We have included a [deobfuscated version](%%REPO_URL%%/1995/vanschnitz/vanschnitz.alt.c) of the program, with
meaningful symbol names and comments, but we encourage you
to try to decipher the program without it...

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
