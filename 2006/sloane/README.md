## To build:

``` <!---sh-->
    make alt
```

We recommend the alt version so that you can see what this looked like back in 2006.
If you wish to see the original faster version see [Original
code](#original-code) below.


## To use:

``` <!---sh-->
    ./slone.alt
```


## Try:

The alternate version, which we recommend that you use in order to see what is
happening with modern systems, and to not flash too quickly, which can be
problematic for some people, can be configured to different speeds by way of the
value used in `usleep()`. The default is `75000` but you can easily change
it. To do so try:

``` <!---sh-->
    make clobber SLEEP=70000 clobber alt
    ./sloane.alt
```

If you wish to make it like the original, as if the below [original
code](#original-code) was being used, you can do:

``` <!---sh-->
    make SLEEP=0 clobber alt
    ./sloane.alt
```


## Original code:

Should you wish to see the original you may do so with the original code,
[sloane.c](%%REPO_URL%%/2006/sloane/sloane.c).


### Original build:

``` <!---sh-->
    make clobber all
```


### Original use:

``` <!---sh-->
    ./sloane
```

**WARNING**: if you are easily overstimulated with fast movement or have
photosensitivity please be careful running this version and instead see the
above!

**NOTE**: again as above, to see what is going on, we recommend that you instead use
the alternate code which we described in the [To build](#to-build) and
[Try](#try) sections above.


## Judges' Comments:

Looks almost good enough to eat, dunnit?  I suppose you could argue that,
at first blush, this looks like a self-reproducing program.


## Author's remarks:

This program doesn't require any special build options, other than that it
uses `sin(3)` and `cos(3)` and hence requires the math library.

You will almost certainly get a compiler warning because I declared a bunch
of global `int`s without types.  The code looks better this way, though, I
think.  There are also no `#include`s, so there may be warnings for
undeclared references to `printf(3)`, etc.  There's a chance that my failure to
include `math.h` or declare `sin(3)` or `cos(3)` will make the
[donut](https://en.wikipedia.org/wiki/Doughnut) not render
properly -- it's worked on every system I've tried so far though.

You will need some kind of VT100-ish emulation; so while this compiles and
runs OK in Windows, you will need PuTTYcyg or something like that.

The shape of the source gives a hint about its output: it's a little
animation of a shaded donut rotating over an infinite checkerboard.  Like
many IOCCC entries, it is thus self-documenting.

I wanted to create something as "pure" as I could - meaning that the entire
source code is shaped into a work of art, without being prefixed by any
`#define` hacks, or even `#includes`, _and_ is portable enough to not require
any special libraries to do the animating.  I achieved this with two standard
escape codes for clearing the screen and moving the cursor back to the top-left.

The donut isn't raytraced.  It's much simpler than that.


### How is it obfuscated?

There are three main pieces to this program: the donut, the checkerboard, and
the ASCII logo.  The first two are programmed in a straightforward way (with
[z-buffering](https://en.wikipedia.org/wiki/Z-buffering) even!), but the
mathematics for drawing them is "optimized".  The ASCII logo has been shrunk
into the smallest I could make it by any means necessary.

The logo can actually be compressed much better (ironically, by doing
something simpler), but I didn't discover this until well after submitting.


### Puzzles

In increasing order of difficulty:

 - Can you change the shading of the donut and checkerboard?

 - Can you change the movement rates of the donut, the checkerboard, and
   the scrolling logo?

 - Can you change the inner/outer radii of the donut?  The height/scaling
   of the checkerboard?

 - How is the "IOCCC 2006" logo encoded?  Can you put something else in its
   place?  Can you find a smaller encoding?


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
