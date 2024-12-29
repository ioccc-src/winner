## To build:

``` <!---sh-->
    make all
```

**NOTE**: we **FORCE** disable the optimiser due to a funny problem with different
compilers and systems. See below and [compilers.html](compilers.html) for details.

There is an [alternate version](#alternate-code). The reason is a funny problem:
in modern systems, depending on the platform, compiler and whether or not the
optimiser is enabled, it might work with one compiler but non the other. But
then if you swap the optimiser state the compiler that worked would no longer
work and the compiler that did not work would. We describe this in more detail
in [compilers.html](compilers.html) and we encourage you to read it for
entertainment if nothing else.


## To use:

``` <!---sh-->
    ./marshall
```


## Alternate code:

Due to the different [conflicting problems](compilers.html) with `gcc` and
`clang`, we offer the problematic code as an alternate version whereas
[marshall.c](%%REPO_URL%%/1986/marshall/marshall.c) has both the loop (that
turned into an infinite loop) commented out and the complicated arg to `_exit(2)`
commented out, changing the value passed into `_exit()` to `1`.


### Alternate build:

To see if your compiler has the problems noted above and in
[compilers.html](compilers.html), first build the alternate code:


``` <!---sh-->
    make alt
```


### Alternate use:

Once the alternate code is built, see if your compiler has the problem:

``` <!---sh-->
    ./marshall.alt
```

Does it work in your system? That is does it print the text only once and does
it not enter an infinite loop? In other words, does it print the text _exactly
once_ and then exit, without dumping core?


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
