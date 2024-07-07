## To build:

``` <!---sh-->
    make all
```


The author provided a spoiler version as alternate code. See [Alternate
code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: known bug - please help us fix
```

For more detailed information see [1994/tvr in bugs.html](../../bugs.html#1994_tvr).


## To use:

``` <!---sh-->
    ./tvr mode screensize/2 < colormapfile
```

Mode may be a value from 0 to 12.


## Try:

``` <!---sh-->
    ./try.color.sh              # for colour displays
    ./try.bw.sh                 # for Black & White displays
```


## Alternate code:


### NOTICE to those who wish for a greater challenge

**If you want a greater challenge, don't read any further**:
just try to understand the program without looking at the Alternate code.

If you get stuck, come back and look at the Alternate code.


### Alternate build:

The author provided us a less obfuscated version that might be of interest to some.

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./tvr.alt altmode screensize/2 < colormapfile
```

where `altmode` `1` - `4` correspond to mode `0` - `3` in the original entry and
`altmode 0` calculates Mandelbrot/Julian sets correctly.


### Alternate try:

``` <!---sh-->
    ./try.alt.color.sh          # for colour displays
    ./try.alt.bw.sh             # for Black & White displays
```


## Judges' remarks:

This entry requires the use of X11.  It will form two windows (hopefully your
window manager will ask you where to place these in your display) which you
should place side by side.  Move the cursor around in one of the two windows and
watch what happens.

The fractally minded may be able to detect that mode 0 does not calculate
Mandelbrot/Julian sets correctly.  Can you find the bug?  Better still, can you
fix it without breaking something else?


## Author's remarks:

### Interactive Fractals for X Window System


This program contains four pairs of fractals/effects and three methods of
animating them. There are two windows for a pair of fractals, one of which
contains static fractal (e.g., [Mandelbrot](https://en.wikipedia.org/wiki/Mandelbrot_set) set)
and the other an animating
one (e.g., [Julia](https://en.wikipedia.org/wiki/Julia_set) set) which is derived
from the same formula as the static one. Only one pair of fractals can be
displayed in one process.

To animate the fractal, you must move your mouse on the static
fractal window and the animated fractal will be calculated based
on mouse coordinates. If you are on one of the two non-stable
modes (more about them later) you can stabilize the picture by
pressing a mouse button. Pressing it does nothing on stable mode.

The three modes are:

- non-stable mode with simple 'attractor searcher'
- non-stable mode
- stable mode

On Mandelbrot/Julia mode the stable mode calculates normal Julia set according
to the Mandelbrot coordinates (mouse position). On non-stable modes the picture
slowly transforms to the same picture as on the stable mode but transformation
can take some time. Usually, and especially if changes are relatively small
between mouse movements or frame rate is high, the non-stable mode makes much
more interesting effects IMHO. The difference between the two non-stable modes
is that the first tries to stabilize the picture. It doesn't stabilize much, but
it helps in some cases quite a lot. One notable case where help can be seen is
when you first move your mouse to non-black areas of the Mandelbrot set, then
back to near the center. In some cases 'attractor searcher' can be seen as
noise.

The first of the fractal pairs is Mandelbrot/Julia set as mentioned before. The
second is a variation of that. The third makes nice 3D-look-a-like effects and
the fourth is a variation of that with more nice effects.


### Usage:

``` <!---sh-->
    ./tvr mode screensize/2 < colormapfile
```


The first parameter is the operating-mode of the program. There are 4 fractal
pairs and 3 display modes, making total of 12 modes. `screensize` is half of the
actual `screenlength/width`. I.e. if you use 128 as a second parameter, you will
get two 256x256 windows.

The program needs reasonable values for both of these parameters to
operate. A good first try could be `0 128` or `8 128`. The `colormap` has
to be redirected into the programs standard input via the `colormapfile`
parameter as shown above.

Note that you will need approximately `(second_parameter^2)*64` bytes of free
main memory or the machine will swap heavily (memory references are quite random
and may confuse paging algorithms easily).  This means that for 512x512 windows
you will need 4M of memory.


### `colormapfile`

This is the file from which program reads colors for screen `colormap`. The
first line of the file must be a number between `3..254`. This informs the
program how many colors there are to be expected. This is also the maximum
number of iterations used on picture calculations. Lines after that are X11
color names. The program expects to find, and will use, the number of colors
reported on the first line.

There are two `colormapfile`s to start with. One with colors and another with
only black and white. If you have enough colors on your display you can use the
one with colors (even on `grayscale`). The other is meant mainly for a one bit
plane display (on which the picture looks terrible compared to a 8 bit plane
display).


### Compilation

You should compile this entry with an optimizing compiler with the
highest level of optimization possible. You will also need an ANSI
compatible compiler (`gcc -ansi -pedantic` will do fine).

This entry has been tested on wide variety of machines including:

```
    Machine             OS
    -------             --
    Decstation 5000/240 Ultrix 4.3A
    DECAlpha 3000/300   OSF/1 v1.3
                        and v2.0
    IBM RS6000          AIX v3
    SPARCStation IPX    SunOS 4.1.3
    i486                Linux v1.1.8
                        (binarysize
                        3576 bytes
                        using
                        `gcc -O6 -s -N` ;)
    HP 9000/730         HP-UX
```

Also, many of the X server and X library versions have been tested and the
program should be highly portable. The program may slow down considerably on
machines where table references are slow as the program makes extensive use of
them. Also, due to the huge amount of data sent to the X server, considerable
slowdown can be noticed if the X server is slow or especially if the connection
between the X server and the client is slow. (Don't try this on 9600 bps modem
line. I did ;) )


### Obfuscation

Obfuscation is done on different levels. Almost none of it is made at the macro
level, so `cpp`ing the code won't give you much. Perhaps most notable is the
algorithmic obfuscation. Simple formula has been turned into something
completely different. Also it may be a surprise to find out which piece of the
code calculates non-stable fractals and how it does that. Many obfuscations were
left out of the program because speed of animation was one of the key issues.
Well, obfuscated or not, some of the effects are very nice ;)


### Memory refreshment

Mandelbrot set is calculated from the formula

```
         2
    Z   = Z  + Z
     n+1   n    0
```

and the Julia set is calculated from the formula

```
         2
    Z   = Z  + C
     n+1   n
```

where `C` is the same throughout the picture.  Both calculation are finished
when `|Z| >= 2.0`.  For the other fractals, the basic methods are the same but
the formula is different (look at the source ;) )

Note that Mandelbrot and Julia on this program aren't exactly correct. Find out
why ;)


### Bugs

- No error checking. If `DISPLAY` is not set program dumps core.  This may also
happen if a request of some of the resources fails e.g. getting colors.
- No expose event handling.
- It may be possible that the program starts drawing before window is mapped as
there is no `XSync()`. In that case drawn data is lost. Also, some window manager
configurations places the second window on top of the first and again drawn
data will be lost. By default, windows are placed next to the other in the
top left corner of the screen.
- Zooming is not possible.
- Eats LOTS of memory on BIG pictures. Also lots of CPU resources.  Under mode
0, the boundary condition is not checked properly.  The condition `|Z| >= 2.0`
should be checked exactly (by comparing `x*x+y*y` with `2*2`), or else artifacts
are introduced.  The result of this error is a "bubbly" appearance (at least in
mono).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
