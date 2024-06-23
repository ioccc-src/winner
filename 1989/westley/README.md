## To build:

``` <!---sh-->
    make all
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: known bug - please help us fix
```

For more detailed information see [1989/westley in bugs.html](../../bugs.html#1989_westley).


## Try:

Try compiling and running the 4 resulting programs like:

``` <!---sh-->
    ./compile.sh
```

If you need to specify an alternate compiler path, say because your default
compiler is clang (or in the case of macOS gcc is clang) you can do so like:

``` <!---sh-->
    CC=/opt/local/bin/gcc-mp-12 ./compile.sh
```

If you wish to delay the script or remove the delay you can do so like:

``` <!---sh-->
    DELAY=2 ./compile.sh
```

Finally try:

``` <!---sh-->
    ./westley
    # input some lines of text, sending EOF (usually ctrl-d) to end

    ./try.sh # demo of some input
```


## Judges' remarks:

There is a secret way to get ONE of the versions to print out
"`Hello, world!\n`".  Can you find how to do it?


## Author's remarks:

This is a filter.  If it is run with no arguments, it copies
`stdin` to `stdout`.  With one argument, it ROT13's `stdin` to
`stdout`.  With two arguments, it reverses `stdin` to `stdout`.  With
three arguments, it does both.  It requires the ASCII character
set, with all characters being in `0..255`, and `EOF` must be `-1`.
Also requires two's complement (I think).

The source code will run if ROT13'ed and/or reversed, using a
different algorithm for each version (hereafter referred to as
`ver0` (original), `ver1` (ROT13), `ver2` (reversed), and `ver3`
(ROT13 and reversed)).

When compiling these versions, one needs to define `trgpune`
in the compile line (which the Makefile now has).  Example:

``` <!---sh-->
    cc -Dtrgpune=putchar ver3.c -o ver3
```

`trgpune` is the ROT13 of `getchar()`, so `getchar()` and `putchar()`
are exchanged in the ROT13 counterpart.  It is easy to see that
this is unavoidable.  I must have a `#define` for a library
function; otherwise I would have an unidentified extern for the
ROT13 version.  If I then define this function, it won't link
in the library version for the ORIGINAL code, since my
definition will supersede the library function.  Hence, the
compiler option gives me `putchar()`, and allows me to use
`getchar()`.  I pass a dummy argument to `getchar()` to eliminate
"variable number of args" from lint (unless it checks against
the library).  Otherwise, all versions of lint complain that `main()`
returns random value & constant in conditional context (when I
check for ROT13 version).

`ver0` and `ver1` use a range check and a calculation to do ROT13,
while `ver2` and `ver3` use table lookup.  All versions contain
`main()` and its ROT13 function, `znva()`.  `ver0`/`ver1` (`ver2`/`ver3`) are
(of course) syntactically identical, since the syntax is in the
non-alphabetic characters.  However, since one program starts
at `main()` while it's ROT13 counterpart starts at `znva()`, `znva()`
calls main (`znva()` is also used for output).

All versions use recursion to work.  If the program is NOT
reversing it's output, it prints out the (possibly ROT13'd)
character before recursing, otherwise it prints it out
afterward (or doesn't recurse at all when `EOF` is reached).
Since most of this code is identical, it is put into `znva()` and
called with a first parameter of 0 as a flag (as `main()`, it's
first argument (argc) must be at least one).

I can't use any flow control.  If I used `if()`, I would have a
function `vs()` to define in the ROT13 version.  But a function
called `vs()` turns into a function called `if()` in the original,
so it can't be done.  Therefore, I do:

``` <!---c-->
    expr1 && expr2 && (expr3=etc);
```

which is the same as:

``` <!---c-->
    if (expr1 && expr2) expr3=etc;
```

A/UX on the Macintosh doesn't get this right; it evaluates ALL
expressions if they aren't in an assignment or conditional
statement.  This might warrant a warning, since other compilers
may do this.  I found MANY compilers botched:

``` <!---c-->
    expr1 && (expr2,expr3);
```

`expr2` was OFTEN evaluated even if `expr1` was false.  I removed
such statements to make it more portable.

### Variable names worth noting


`irk` and  `vex` are ROT13 pairs and are synonyms.

`Near` and `Arne` are ROT13 pairs and are anagrams.

`NOON` and `ABBA` are ROT13 pairs and are palindromes.

`tang` and `gnat` are both ROT13 and palindrome pairs!

--

Normally (!), a reversible C program is done thus:

``` <!---c-->
    /**/ forward code /*/ edoc drawkcab /**/
```

If your compiler nests comments, it will get this wrong.
However, I have made some bits of the code palindromic,
(or different, but reversible) so it is more like:

``` <!---c-->
    /**/forward/*//**/ palindromic /**//*/drawkcab/**/
```

The code can therefore be interlaced.  There are eight
such palindromic bits.  You can find them within the
`/*//**/   /**//*/` pairs.

The body of the code of `ver0` and `ver1` is a large lumpy `K` (for
Kernighan); the code of `ver2` and `ver3` is a flat-topped and
lumpier `R` (for Ritchie).  Judicious use of spaces and tabs
helped here.  It barely fits on an 80x24 screen.  Squint.  Note
that the code must start with a blank line, or the reversed version
will lack a terminating newline.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
