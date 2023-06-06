# Homer's Favorite

Andy Sloane  
US  


## To build:

```sh
make
```


## To run:

```sh
./slone
```

WARNING: if you are easily overstimulated with fast movement or have
photosensitivity please be careful running this entry!

An alternatively version of this entry exists so that one can actually see what
is going on. This is also more ideal for those who are overstimulated by fast
movements. See the alternate code section below.


## Try:

```sh
echo "Do or do not. There is no try."
```


### Alternate code:

The alternate version uses `usleep()` so one can enjoy
the entry with modern systems and which will not be too stimulating for those
who have a problem with fast moving text (like himself). It uses the `Z` macro
as the parameter to `usleep()` which you can override. The default is
`-DZ=65000`. To compile with the default:


```sh
make alt
```

If you wish to override the sleep value try something like:

```sh
make CDEFINE="-DZ=70000" clobber alt
```

Use `sloane.alt` as you would `sloane` above.


## Judges' Comments:

Looks almost good enough to eat, dunnit?  I suppose you could argue that,
at first blush, this looks like a self-reproducing program.


## Author's remarks:

This program doesn't require any special build options, other than that it
uses `sin()` and `cos()` and hence requires the math library.

You will almost certainly get a compiler warning because I declared a bunch
of global ints without types.  The code looks better this way, though, I
think.  There are also no `#include`s, so there may be warnings for
undeclared references to `printf()`, etc.  There's a chance that my failure to
include `math.h` or declare `sin()` or `cos()` will make the
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

There are three main pieces to this program: the donut, the checkerboard,
and the ASCII logo.  The first two are programmed in a straightforward way
(with z-buffering even!), but the mathematics for drawing them is
"optimized".  The ASCII logo has been shrunk into the smallest I could make
it by any means necessary.

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


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
