# Most algorithms in one program

Merlyn LeRoy (Brian Westley)  
US  
<http://www.westley.org>  

## To build:

```sh
make all
```


NOTE: this entry only partly works with clang; clang requires that the second, third and
fourth args to `main()` be `char **`. Only `westley.c` and `ver0.c` (see below) will
compile with clang. It's possible to get `ver1.c` to compile too but this causes
problems with generating the output of the remaining files so we have opted, at
least for now, to not do that, as it does not have to output just source code.
The original source code sometimes segfaults with `ver2` which also happens with
the fix but it'll only compile with a compiler that does not require the second,
third and fourth args of `main()` to be a `char **`.


## Try:

```sh
./westley < westley.c > ver0.c
./westley 1 < westley.c > ver1.c
./westley 1 2 < westley.c > ver2.c
./westley 1 2 3 < westley.c > ver3.c
```


Try compiling and running the 4 resulting programs. To compile try:

```sh
make ver0
make ver1
make ver2
make ver3
```

Then run:

```sh
./westley
# input some lines of text, sending EOF (usually ctrl-d) to end
echo IOCCC | ./ver0
echo Version 1 | ./ver1
echo Version 2 | ./ver2
echo Version 3 | ./ver3
```

## Judges' remarks:


There is a secret way to get ONE of the versions to print out
"`Hello, world!\n`".  Can you find how to do it?


## Author's remarks:

This is a filter.  If it is run with no arguments, it copies
stdin to stdout.  With one argument, it ROT13's stdin to
stdout.  With two arguments, it reverses stdin to stdout.  With
three arguments, it does both.  It requires the ASCII character
set, with all characters being in 0..255, and EOF must be -1.
Also requires two's complement (I think).

The source code will run if ROT13'ed and/or reversed, using a
different algorithm for each version (hereafter referred to as
`ver0` (original), `ver1` (ROT13), `ver2` (reversed), and `ver3` 
(ROT13 and reversed)).

When compiling these versions, one needs to define 'trgpune'
in the compile line (which the Makefile now has).  Example:

```sh
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
the library).  Otherwise, all versions lint reasonably (main
returns random value & constant in conditional context [when I
check for ROT13 version] is all it complains about).

`ver0` and `ver1` use a range check and a calculation to do ROT13,
while `ver2` and `ver3` use table lookup.  All versions contain
`main()` and its ROT13 function, `znva()`.  `ver0`/`ver1` [`ver2`/`ver3`] are
(of course) syntactically identical, since the syntax is in the
non-alphabetic characters.  However, since one program starts
at `main()` while it's ROT13 counterpart starts at `znva()`, `znva()`
calls main (`znva()` is also used for output).

All versions use recursion to work.  If the program is NOT
reversing it's output, it prints out the (possibly ROT13'd)
character before recursing, otherwise it prints it out
afterward (or doesn't recurse at all when EOF is reached).
Since most of this code is identical, it is put into `znva()` and
called with a first parameter of 0 as a flag (as `main()`, it's
first argument (argc) must be at least one).

I can't use any flow control.  If I used if(), I would have a
function vs() to define in the ROT13 version.  But a function
called vs() turns into a function called if() in the original,
so it can't be done.  Therefore, I do:

```c
expr1 && expr2 && (expr3=etc);
```

which is the same as:

```c
if (expr1 && expr2) expr3=etc;
```

A/UX on the Macintosh doesn't get this right; it evaluates ALL
expressions if they aren't in an assignment or conditional
statement.  This might warrant a warning, since other compilers
may do this.  I found MANY compilers botched:

```c
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

```c
/**/ forward code /*/ edoc drawkcab /**/
```

If your compiler nests comments, it will get this wrong.
However, I have made some bits of the code palindromic,
(or different, but reversible) so it is more like:

```c
/**/forward/*//**/ palindromic /**//*/drawkcab/**/
```

The code can therefore be interlaced.  There are eight
such palindromic bits.  You can find them within the
`/*//**/   /**//*/` pairs.

The body of the code of `ver0` and `ver1` is a large lumpy 'K' (for
Kernighan); the code of `ver2` and `ver3` is a flat-topped and
lumpier 'R' (for Ritchie).  Judicious use of spaces and tabs
helped here.  It barely fits on an 80x24 screen.  Squint.  Note
that the code must start with a blank line, or the reversed version
will lack a terminating newline.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
