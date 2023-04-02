# Most Well Rounded Obfuscation:

Andrew T. Shapiro
CSES/CIRES University of Colorado
Campus Box 216
Boulder, CO 80309-0216
USA

## To build:

        make all

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed a bug on systems
where `EOF != -1`. The problem is that `getc()` and the related functions do not
return `-1` on EOF or error but rather `EOF`. However `EOF` is not required to be
`-1` but merely an int < 0 and this program assumed that `getc()` will return
`-1` on EOF or error, not `EOF`. On systems where `EOF != -1` it could be a
problem. For the same reason one should not use `EOF` for the `getopt()`
functions as they return `-1` when all options are parsed (for details on the
definition of `EOF` see `7.21 Input/output<stdio.h>` subsection 1 of the
standard). An interesting problem occurred where changing the `-1` to `EOF`
caused both `warning: illegal character encoding in string literal` and `error:
source file is not valid UTF-8`. But since `EOF` is simply an int < 0 and making
the loop condition check that the return value is >= 0 does not cause a
compilation error and it functions correctly it will address the systems where
`EOF != -1` just as if it checked for `!= EOF`. Thank you Cody for your
assistance!

## To run:

	./shapiro &

## Try:

```sh
./shapiro
^Z
bg
ps x
^C

./shapiro_t1
```

Notice what you see in the output of `ps`!


## Judges' comments:

This entry has many different levels of obfuscation, and yet the
source file is self documenting.  :-)

From time to time, run ps and look at the new processes.

See [shapiro.md](shapiro.md) for more information in the internals of this program.
The file [shapiro.alt.c](shapiro.alt.c) contains a non-obfuscated version of
this program. Note that this alt file is currently missing. See
[bugs.md](/bugs.md) for details.


## Author's comments:

The basic theme (pun) of this program is:
    

> "This time (everything) is not where it should be."
>       ~~~~


My entry ([shapiro.c](shapiro.c)) is mostly comment, formatted in the shape of a 
clock. If you strip out the comments and look at the code you will 
quickly realize that the comments were the important part and that 
the code does very little (see pun above). It writes (to stdout) 
another C program ([shapiro_t2.c](shapiro_t2.c)). This is the first level of 
obfuscation.

The second program ([shapiro_t2.c](shapiro_t2.c) if you use the Makefile
prints a clock in the upper right hand corner of your VTxxx/ANSI display.

Most of the surface obfuscation in the second program
([shapiro_t2.c](shapiro_t2.c)) 
was an attempt to make it as small as possible. You should be able to 
see around this with cb(1) and some more intelligent variable names. 
Once you get past this you will realize that the third level of 
obfuscation is a six member client/server hierarchy. 
(See the [shapiro.md](shapiro.md) file for a detailed description of the
algorithm.)

Lint complains about: precedence confusion, `K` may be used before set,
main() returns random value to invocation environment, value type used 
inconsistently, value type declared inconsistently, function argument 
(number) used inconsistently, function returns value which is always 
ignored, function returns value which is sometimes ignored.
All of which are harmless (famous last words). 

This may or may not work on non ASCII systems (I could not find one to
test it on.)

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
