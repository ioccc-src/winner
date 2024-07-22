## To build:

We recommend you try the alternate version first so you can get a better idea of what
this entry was like back in 1993 (though see the [known bug in
bugs.html](../../bugs.html#1993_cmills)). See the [original code](#original-code)
section below to run the original (the bug also exists here).

``` <!---sh-->
    make alt
```

NOTE: this entry requires the `X11/Xlib.h` header file and the X11 library to
compile.  For more information see the
FAQ on "[X11](../../faq.html#X11)".

To configure how many microseconds to sleep before updates try:

``` <!---sh-->
    make clobber SLEEP=200 alt
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: known bug - please help us fix**

For more detailed information see [1993/cmills in bugs.html](../../bugs.html#1993_cmills).


## To use:

``` <!---sh-->
    DISPLAY="your_X_server_display"
    export DISPLAY
    ./cmills.alt [speed]        # must be run on an X11 server
```

where:

`speed` is update speed from 1 to 9 (default is 9).


NOTE: in most cases `DISPLAY` should already be set.


## Original code:

We recommend the version that uses `usleep(3)` to more easily see what is going
on but you can use the original without any delays if you wish.


### Original build:

``` <!---sh-->
    make all
```


### Original use:

Use `cmills` as you would `cmills.alt` above.


## Judges' remarks:

From the San Jose Mercury News (May 15, 1993 page 20A "West Hackers
trounce East in computer quiz game"):

> "Since 1984, a contest has been held on Usenet for the most unreadable,
creative, bizarre but working C program", Gates said. "What is the name of this
contest?"
>
> "**Windows**," shot back _Gassee_, naming Microsoft's premier product - a
product over which Apple sued Microsoft five years ago. Not the right answer -
it's "**The Obfuscated C Contest** [sic]" - but it brought down the house of Apple
partisans...

[The expression on Bill Gates' face was a sight to behold, as reported
to us by several who were there].

You must set `$DISPLAY` in your environment or the program will
dump core.  This is not a bug as the author documented it as
a feature.  :-)

The optional argument is integer which controls the speed of the
program.  By default the speed is 9.  You may want to try 1.

You will have to kill the program (i.e., ^C) to stop it.

WARNING: Slow servers or servers with long request queues will
continue to 'run' for a while after you have killed
the program.

This program makes your windows about as useful as their windows. :-)


## Author's remarks:

The program uses a single backing pixmap (which is the size of the
screen) for all of its subwindows (with a little bit of trickery to
move the offset around).  This is much better (and faster) than the
obvious implementation which would require a full-screen pixmap and
a separate backing pixmap for each subwindow.

The chance that a window breaks is based on it's kinetic energy,
which in turn is based on it's area and speed.  How silly!


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
