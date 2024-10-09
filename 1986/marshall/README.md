## To build:

``` <!---sh-->
    make all
```

**NOTE**: we **FORCE** disable the optimiser due to a funny problem with different
compilers and systems. See below and [compilers.html](compilers.html) for details.

There is an [alternate version](#alternate-code). The reason is a funny problem:
in modern systems, depending on the platform, compiler and the optimiser, it
would work with one compiler with the optimiser but it would not work with the
other; and if the optimiser state is changed the previous problematic compiler
might work but the other one would not. We describe this in more detail in
[compilers.html](compilers.html) and we encourage you to read it for entertainment
if nothing else.


## To use:

``` <!---sh-->
    ./marshall
```


## Alternate code:

Due to the different [conflicting problems](compilers.html) with `gcc` and
`clang`, we
instead offer the problematic code as an alternate version whereas
[marshall.c](%%REPO_URL%%/1986/marshall/marshall.c) has both the infinite loop and the complicated arg to
`_exit()` commented out, changing the value passed into `_exit()` to `1`.


### Alternate build:

To see if your compiler has the problems noted:


``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./marshall.alt
```

Does it work in your system? That is does it not segfault, does it print it only
once and does it not enter an infinite loop? Or more generally does it print the
text exactly once and then exit?


## Judges' remarks:

This program prints the name of the picture.  The layout is somewhat
pretty though it is not the usual sort of output one would expect
from printing a program!

This program was selected for the 1987 t-shirt collection.


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
