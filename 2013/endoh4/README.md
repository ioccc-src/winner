# Most solid

Yusuke Endoh\
<mame@ruby-lang.org>\
<https://github.com/mame/>\
Mastodon: [@mame@ruby.social](https://ruby.social/@mame)

## To build:

```sh
make
```

## To run:

```sh
./endoh4 < file
./run.sh file
```

The second form is preferable as it will temporarily make the cursor invisible
as recommended by the author. If no file is specified in `run.sh` command line
it will feed to the program [endoh4.c](endoh4.c).

## Try:

```sh
./run.sh cube.txt
```

Hit ctrl-c to end the program.

The author recommends the use of xterm.

For an example, if you are a football/soccer fan, try:

```sh
./run.sh solids/archimedian-solid/a11-truncated-icosahedron.txt
```

## Judges' remarks:

This program is formatted as the net for a tetrahedron (hint: try feeding the
program it's own source code like `./run.sh`).  When it runs there is an
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
clang, and tcc.  It should not be warned with `-pedantic` and `-Wextra`.

### Tips

You may want to use `tput` to hide the terminal cursor.

```sh
tput civis
./endoh4 < cube.txt
tput cnorm
```

or

```sh
./run.sh cube.txt
```

### Bonuses

You can change the screen size.  Let the aspect ratio be about 3:1.

```sh
cc -DS=120,40 -o endoh4 endoh4.c
```

The shape of this code is the geometric net of a regular tetrahedron.
So, try:

```sh
./endoh4 < endoh4.c # or ./run.sh
```

The [solids/](solids/) directory includes various solid data:

- [Platonic solids](http://en.wikipedia.org/wiki/Platonic_solid)
- [Archimedean solids](http://en.wikipedia.org/wiki/Archimedean_solid)
- [Prisms](http://en.wikipedia.org/wiki/Prism_%28geometry%29)
- [Antiprisms](http://en.wikipedia.org/wiki/Antiprism)
- [Bipyramids](http://en.wikipedia.org/wiki/Bipyramid)
- [Trapezohedrons](http://en.wikipedia.org/wiki/Trapezohedron)
- [Johnson solids](http://en.wikipedia.org/wiki/Johnson_solid)

I created the files by using the POV-Ray scripts
([1](http://en.wikipedia.org/wiki/File:Poly.pov) and
[2](http://en.wikipedia.org/wiki/User:AndrewKepert/poly.pov)) in Wikipedia.
They are copyrighted in CC BY-SA 3.0 by "User:Cyp" and "User:AndrewKepert".


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
