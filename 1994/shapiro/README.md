## To build:

``` <!---sh-->
    make all
```

There is an alternate version that is unobfuscated, provided by the author. See
[Alternate code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**<br>

For more detailed information see [1994/shapiro in bugs.html](../../bugs.html#1994_shapiro).


## To use:

``` <!---sh-->
    ./shapiro &
```

Now find the clock in the same terminal window (or console if at the console).


## Try:

``` <!---sh-->
    ./shapiro
    ^Z
    bg
    ps x
    fg
    ^C

    ./shapiro_t1
```

Notice what you see in the output of `ps`! Observe too what happens after you
bring it back to the foreground.


## Alternate code:

This version, [shapiro.alt.c](%%REPO_URL%%/1994/shapiro/shapiro.alt.c), is an
unobfuscated version provided by the author.


## Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `shapiro.alt` as you would `shapiro` above.


## Judges' remarks:

This entry has many different levels of obfuscation, and yet the
source file is self documenting.  :-)

From time to time, run `ps(1)` and look at the new processes.

If you want more information on the internals of this program, see
[shapiro.html](shapiro.html).


## Author's remarks:

The basic theme (pun) of this program is:


> "This **time** (everything) is not where it should be."


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


My entry, [shapiro.c](%%REPO_URL%%/1994/shapiro/shapiro.c), is mostly comments, formatted in the shape of a
clock. If you strip out the comments and look at the code you will
quickly realize that the comments were the important part and that
the code does very little (see pun above). It writes (to `stdout`)
another C program (`shapiro_t2.c`). This is the first level of
obfuscation.

The second program (`shapiro_t2.c`) prints a clock in the upper right hand
corner of your VTxxx/ANSI display.

Most of the surface obfuscation in the second program,
`shapiro_t2.c`, was an attempt to make it as small as possible.
You should be able to see around this with `cb(1)` and some more intelligent
variable names.  Once you get past this you will realize that the third level of
obfuscation is a six member client/server hierarchy.  (See the
[shapiro.html](shapiro.html) web page for a detailed description of the algorithm.)

`lint` complains about: precedence confusion, `K` may be used before set,
`main()` returns random value to invocation environment, value type used
inconsistently, value type declared inconsistently, function argument
(number) used inconsistently, function returns value which is always
ignored, function returns value which is sometimes ignored.
All of which are harmless (famous last words).

This may or may not work on non ASCII systems (I could not find one to
test it on.)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
