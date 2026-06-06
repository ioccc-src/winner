Award: Most likely to invade

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    # Press TAB to aim:       Cycles through target choices before firing
    # Press ENTRY to Fire:    Kill lowest matching invader
    # Press ^C to quit early

    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

For an ASCII only version:

``` <!---sh-->
    diff -w prog.c prog.alt.c
```


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    # Press TAB to aim:       Cycles through target choices before firing
    # Press ENTRY to Fire:    Kill lowest matching invader
    # Press ^C to quit early

    ./prog.alt
```


## Judges' remarks:

How long can you evade the invasion?

This entry is one of the smaller games we have seen.
What helps it to be smaller than it would have to be years ago?


### A fun challenge

Create an alternative form of [prog.c](%%REPO_URL%%/2025/howe/prog.c) (i.e., `prog.alt.c`)
that is slightly harder to play by allowing the closest invader to be killed.
Compensate slightly for that difficulty increase by allowing the **shift TAB** key
to cycle in the opposite direction of the **TAB** key.

The above fun challenge is **still open**.
See the "[Fun challenge Info](../index.html#fun_challenge_info)" section for details.


## Author's remarks:


### Overview

August 1980 Casio released the MG-880 calculator with a music keyboard
and `Space Invaders` like game.  The device was extremely popular with
kids at the time (oh hum).  In 2018 Casio released the SL-880 calculator
that revived the game.  This entry implements a variant of that game for
the command line, something you can play at your desk, in the office,
when you need a brief distraction from coding (or judging the IOCCC).


### Building

Simply type `make` to build.  These macros can be customised:

* `PACE` easy = 2, normal = 3, hard = 4

There is a smaller second version, `prog.alt.c`, that is ASCII only
and more closely resembles the original game visually.  Simply type
`make prog.alt`.


### What's Interesting

* Small code, small UI.

* Its a game!  Games are always interesting.

* See game documentation [prog.html](prog.html).


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
