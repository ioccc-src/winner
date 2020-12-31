# Homer's Favorite

Andy Sloane
1041 Seneca St.
Hartford, WI 53027
US

## Judges' Comments:

### To build:

        make slone

### To run:

        ./sloane

Looks almost good enough to eat, dunnit?  I suppose you could argue that,
at first blush, this looks like a self-reproducing program.

## Selected Author's Comments:

This program doesn't require any special build options, other than that it
uses sin and cos and hence requires the math library.

You will almost certainly get a compiler warning because I declared a bunch
of global ints without types.  The code looks better this way, though, I
think.  There are also no #includes, so there may be warnings for
undeclared references to printf, etc.  There's a chance that my failure to
include math.h or declare sin or cos will make the donut not render
properly -- it's worked on every system I've tried so far though.

You will need some kind of VT100-ish emulation; so while this compiles and
runs OK in Windows, you will need PuTTYcyg or something like that.

The shape of the source gives a hint about its output: it's a little
animation of a shaded donut rotating over an infinite checkerboard.  Like
many IOCCC entries, it is thus self-documenting.

I wanted to create something as "pure" as I could - meaning that the
entire source code is shaped into a work of art, without being prefixed
by any #define hacks, or even #includes, _and_ is portable enough to not
require any special libraries to do the animating.  I achieved this with
two standard escape codes for clearing the screen and moving the cursor
back to the top-left.

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

