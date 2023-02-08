# Most solid

Yusuke Endoh  
<mame@ruby-lang.org>  
<https://github.com/mame/>  


## Judges' comments:
### To build:

    make endoh4

### To run:

    ./endoh4

### Try:

NOTE: The author recommends the use of xterm.

    ./endoh4 < cube.txt

For example, if you are a soccer fan, try:

    make all
    ./endoh4 < solids/archimedian-solid/a11-truncated-icosahedron.txt

### Selected Judges Remarks:

This program is formatted as the net for a tetrahedron. (hint, try feeding the
program it's own source code).  When it runs there is an animation for the
computation to work out the convex hull.

## Author's comments:
### Spec

This is a convex polyhedron viewer, which:

1. reads three-dimentional vertices (3N float values) from stdin,
2. calculates a convex hull of them, and
3. renders it.

This simple spec involves many details.

* 3D convex hull calculation
  * recursive gift wrapping algorithm
  * automatical merging of (almost) co-planar faces
    (i.e., faces are not triangulated)
  * random perturbation for robustness
* 3D rendering
  * perspective projection
  * ASCII line drawing: `"',;;;,;'"`
  * camera in a spherical spiral orbit

(Note that this program does not use `math.h`.)

### Portability

I think it conforms with both C89 and C99.
I confirmed that it worked on gcc, clang, and tcc.
It should not be warned with -pedantic and -Wextra.

### Tips

You may want to use `tput` to hide a terminal cursor.

    tput civis
    ./endoh4 < cube.txt
    tput cnorm

### Bonuses

You can change the screen size.  Let the aspect ratio be about 3:1.

    gcc -DS=120,40 -o endoh4 endoh4.c

The shape of this code is the geometric net of a regular tetrahedron.
  So, try:

    ./endoh4 < endoh4.c

The solids.tbz2 file includes various solid data:
[Platonic solids](http://en.wikipedia.org/wiki/Platonic_solid),
[Archimedean solids](http://en.wikipedia.org/wiki/Archimedean_solid),
[Prisms](http://en.wikipedia.org/wiki/Prism_%28geometry%29),
[Antiprisms](http://en.wikipedia.org/wiki/Antiprism),
[Bipyramids](http://en.wikipedia.org/wiki/Bipyramid),
[Trapezohedrons](http://en.wikipedia.org/wiki/Trapezohedron), and
[Johnson solids](http://en.wikipedia.org/wiki/Johnson_solid).

I created the files by using the POV-Ray scripts
([1](http://en.wikipedia.org/wiki/File:Poly.pov) and
 [2](http://en.wikipedia.org/wiki/User:AndrewKepert/poly.pov))
in Wikipedia.
They are copyrighted in CC BY-SA 3.0
by "User:Cyp" and "User:AndrewKepert".

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
