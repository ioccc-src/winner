## To build:

``` <!---sh-->
    make all
```

**NOTE**: this entry requires the `X11/Xlib.h` header file and the X11 library to
compile.  For more information see the
FAQ on "[X11](../../faq.html#X11)".


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**<br>
> **STATUS: missing or dead link or links - please provide it or them**

For more detailed information see [1996/jonth in bugs.html](../../bugs.html#1996_jonth).


## To use:

``` <!---sh-->
    ./jonth :0 :0
```

**NOTE**: the two boards will be on top of each other so you will have to drag one
off the other so that you can properly play.


**NOTE**: if there is no X service open this will crash. If this is the case you
might try:

``` <!---sh-->
    ./jonth
```


## Try:

``` <!---sh-->
    ./jonth host1:0 host2:0
```


## Judges' remarks:

For extra credit, figure out how you can cheat by taking over a square already
occupied by an opponent.


## Author's remarks:

This is multi-user tic-tac-toe for X Windows. You may give one or two X displays
as arguments to this game.

### Known bugs:

Sometimes on Solaris, X gets confused and this program core dumps. The solution:
give two display arguments (`./jonth host:0 host:0`).

If one (or both) windows look like a copy of the window(s) below, try the
`xrefresh(1)` command.

Have a `nice(1)` day.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
