## To build:

``` <!---sh-->
    make all
```

The author provided a deobfuscated version. See [Alternate
code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
    STATUS: missing file - please provide it
```

For more detailed information see [1993/ant in bugs.html](../../bugs.html#1993_ant).


## To use:

``` <!---sh-->
    ./ant 'ERE' [file ...]
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

The [ant.c in deobfuscated/](%%REPO_URL%%/1993/ant/deobfuscated/ant.c) is a
deobfuscated version provided by the author. You can look at this code if you
want some clues in how it works.


## Alternate build:

If you wish to build this deobfuscated version, you can do so like:


``` <!---sh-->
    make alt
```


## Alternate use:

Use `ant.alt` like you would `ant` above.


## Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

See the author's POSIX P1003.2-like documentation file [ant.txt](ant.txt) for
more information.

This program demonstrates that POSIX doesn't guarantee readability.  :-)


## Author's remarks:

Some of the features of my entry are:

-  "Lengthy" POSIX.2 style specification and manual :) :)
-  Useful subset of POSIX.2 Extended Regular Expressions.
-  Recursive ERE parser/compiler that generates an NFA railroad.
-  Lazy NFA to DFA evaluation to improve performance speed.
-  Code tested on a variety of platforms.
-  Make driven test script.
-  Can be compiled with ANSI or K&R C.
-  Not a toy, but actually useful and usable on systems that use DOS.
-  See also [ant.txt](ant.txt).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
