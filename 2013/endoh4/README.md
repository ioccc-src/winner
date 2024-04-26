## To build:

``` <!---sh-->
    make
```

If you wish to change the size (see the [Author's remarks](#authors-remarks)
below) you can do so with the `SIZE` variable. For instance you can do:


``` <!---sh-->
    make clobber SIZE=50,50 all
```

but you can also do this directly with the [endoh4.sh](%%REPO_URL%%/2013/endoh4/endoh4.sh) script as
described below.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2013 endoh4 bugs](../../bugs.html#2013_endoh4).


## To use:

``` <!---sh-->
    ./endoh4 < file
    ./endoh4.sh file
```

The second form is preferable as it will temporarily make the cursor invisible
as recommended by the author. If no file is specified in the `./endoh4.sh` command
line it will feed to the program [endoh4.c](%%REPO_URL%%/2013/endoh4/endoh4.c).


## Try:

``` <!---sh-->
    ./endoh4.sh cube.txt
```

Hit ctrl-c to end the program.

The author recommends the use of xterm.

For an example, if you are a football/soccer fan, try:

``` <!---sh-->
    ./endoh4.sh solids/archimedian-solid/a11-truncated-icosahedron.txt
```

You can provide more than one file:

``` <!---sh-->
    ./endoh4.sh solids/archimedian-solid/a11-truncated-icosahedron.txt cube.txt
```

Hit ctrl-c/intr to go to the next file.

If you wish to change the size to `50,50` without passing any arg:


``` <!---sh-->
    SIZE=50,50 ./endoh4.sh
```

Not specifying a file feeds [endoh4.c](%%REPO_URL%%/2013/endoh4/endoh4.c) to the program.


## Judges' remarks:

This program is formatted as the net for a tetrahedron (hint: try feeding the
program it's own source code like `./endoh4.sh`).  When it runs there is an
animation for the computation to work out the convex hull.


## Author's remarks:

### Spec

This is a convex polyhedron viewer, which:

1. reads three-dimensional vertices (3N float values) from `stdin`,
2. calculates a convex hull of them, and
3. renders it.

This simple spec involves many details.

* 3D convex hull calculation
  * recursive gift wrapping algorithm
  * automatic merging of (almost) co-planar faces (i.e., faces are not
  triangulated)
  * random perturbation for robustness
* 3D rendering
  * perspective projection
  * ASCII line drawing: `"',;;;,;'"`
  * camera in a spherical spiral orbit

(Note that this program does not use `math.h`.)


### Portability

I think it conforms with both C89 and C99.  I confirmed that it worked on gcc,
clang, and tcc.  It should not trigger warnings with `-pedantic` and `-Wextra`.


### Tips

You may want to use `tput` to hide the terminal cursor.

``` <!---sh-->
    tput civis
    ./endoh4 < cube.txt
    tput cnorm
```

or

``` <!---sh-->
    ./endoh4.sh cube.txt
```

### Bonuses

You can change the screen size.  Let the aspect ratio be about 3:1.

``` <!---sh-->
    cc -DS=120,40 -o endoh4 endoh4.c
```

The shape of this code is the geometric net of a regular tetrahedron.
So, try:

``` <!---sh-->
    ./endoh4 < endoh4.c # or ./endoh4.sh
```

The `solids` directory includes various solid data:

- [Platonic solids](http://en.wikipedia.org/wiki/Platonic_solid)
- [Archimedean solids](http://en.wikipedia.org/wiki/Archimedean_solid)
- [Prisms](http://en.wikipedia.org/wiki/Prism_%28geometry%29)
- [Antiprisms](http://en.wikipedia.org/wiki/Antiprism)
- [Bipyramids](http://en.wikipedia.org/wiki/Bipyramid)
- [Trapezohedrons](http://en.wikipedia.org/wiki/Trapezohedron)
- [Johnson solids](http://en.wikipedia.org/wiki/Johnson_solid)

I created the files by using the POV-Ray scripts
([1](http://en.wikipedia.org/wiki/File:Poly.pov) and
[2](http://en.wikipedia.org/wiki/User:AndrewKepert/poly.pov) in Wikipedia.
They are copyrighted in CC BY-SA 3.0 by "User:Cyp" and "User:AndrewKepert".


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
