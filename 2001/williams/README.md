## To build:

``` <!---sh-->
    make
```

NOTE: this entry requires the `X11/Xlib.h` header file and the X11 library to
compile.  For more information see the
FAQ on "[X11](../../faq.html#X11)".


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: known bug - please help us fix**

For more detailed information see [2001/williams in bugs.html](../../bugs.html#2001_williams).


## To use:

``` <!---sh-->
    ./williams
```


## Judges' remarks:

[A strange game. The only winning move is not to
play](https://en.wikipedia.org/wiki/WarGames). No, really; you can't
actually win. :)

The formatting really wants a wide screen; if you can't read it that way, it's
the standard "three triangles around a circular" logo for nukes.

This is a pretty straightforward game.


## Author's remarks:

What this program does:

It plays [Missile Command](https://en.wikipedia.org/wiki/Missile_Command),
complete with MIRVs, smart bombs, extra cities, and scoring.

Command line arguments and input files are ignored.

To play, just point and click where you want your ABMs to explode.

The score is 10 points for each missile which is destroyed before
it reaches the ground, -1 point for each ABM used, and 100 bonus
points for each city left at the end of a level.

The game ends when you lose all your cities, although you will have
to wait until the level finishes raining down to see your final score.

### Obfuscation

The main obfuscation technique is the need to compress the code to fit
all the functionality within the size limits.  I could not have included
smart bombs without the rule excluding `{};` characters in the counts.
All of the `#define`s are there to reduce code size.

On the other hand, I did waste a few characters in order to include
some rather obfuscated math in the program.  It uses fixed-point
arithmetic, resulting in the overuse of bitwise shift operators.
Another example is `(x|1)`, which is used in a couple different ways.
The purpose of `A/(x|1)` is probably obvious, but what does `(x|1)%2` do?


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
