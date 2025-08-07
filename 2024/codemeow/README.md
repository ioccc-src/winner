## Award presentation:

Watch the following [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse) YouTube show:

> [IOCCC28 - 2024/codemeow - Prize in tray planting](https://www.youtube.com/watch?v=OxRLL_RFZHs)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Sometimes you cannot see the forest thru the trees.  But when you
cannot see the trees thru the forest, it may be because the trees are
not that tall.

This program generates such "mini-trees": over time and in time of you
know what we mean.  Even though compiled C code might "_grow on parse
trees_", we think this code will also "grow on you" as the C expression
goes.  😉


## Author's remarks:


This work is highly inspired by `cbonsai` program (which was inspired by bonsai.sh, which was inspired by bonsai.js), but this one does not use ncurses and fits into IOCCC rules' size.


### Mac OS X

A little notice, that you need a terminal that supports ANSI codes and does not reinvent the wheel. I have tested it on `iTerm2` and `xterm` and it sure works, but sometimes detect the windows size wrongly, so best of luck.


### Warnings

The [iocccsize tool](https://github.com/ioccc-src/mkiocccentry/blob/master/iocccsize.c) warns about `triggered a word buffer overflow!` as I use the double values to stora data. It's okay, no error here.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
