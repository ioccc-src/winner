# Most complex ASCII fluid - Honorable mention

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
./endoh1 < configuration.txt
```

## Try:

```sh
./endoh1 < endoh1.c

./endoh1 < pour-out.txt

./endoh1 < fountain.txt
```

Also try using `endoh1_color` as you would `endoh1` above. `make` will compile
this by default.



### Alternate code:

An alternate version of this entry, `endoh1.alt.c`, is provided.
This alternate code is a de-obfuscated version of `endoh1.c`.

To compile this alternate version:

```sh
make alt
```

Use `endoh1.alt` as you would `endoh1` above.

## Judges' remarks:

Let's play [Jeopardy!](https://en.wikipedia.org/wiki/Jeopardy!)

*   A: An obfuscated program that deals with complex numbers and produces animated ASCII graphics.
*   Q: What is a Mandelbrot simulator?

Bzzzt!

Such heavily squeezed fluid simulation (this is parsed uniquely
as fluids are not squeezable) has a few quirks that the judges were
happy to experiment with.

One configuration file was inspired by an [XKCD what if? entry](http://whatif.xkcd.com/6/).

## Author's remarks:

### Synopsis

**DO NOT FORGET** `-DG=1 -DP=4 -DV=8` and make your terminal window larger
than 80 x 25.

```sh
cc endoh1.c -DG=1 -DP=4 -DV=8 -D_BSD_SOURCE -o endoh1 -lm
./endoh1 < endoh1.c
./endoh1 < logo.txt
./endoh1 < column.txt
./endoh1 < pour-out.txt
./endoh1 < tanada.txt
```

### What it is

```
    ,___. ,.       ,.    ,.   ,___. ,.              ,.       ,.
    |/--' ||       `'    ||   |/--' `'              ||       |\_.
    |\__. || ,. ,. ,. ,__/|   |\__. ,. ,____. ,. ,. ||  ,_.  |/-'  ,_.  ,__.
    |/--' || || || || |/-\|   `--\| || |/\/\| || || || ,/-\. ||   ,/-\. |/-\.
    ||    || `\_/| || |\_/|   ,__/| || |||||| `\_/| || `\_/\.`\_. `\_/' || `'
    `'    `'  `--' `' `---'   `---' `' `'`'`'  `--' `'  `-'`' `-'  `-'  `'


     ,.,.                      ,.,.
    ,/\/\. ,.       ,.    ,.  ,/\/\. ,.              ,.      ,__.
    |||#/' ||       `' ,_.||  |||#/' `',_.,__.       ||      ||\\.        ,.
    |||#\. || ,. ,. ,.,/#|||  |\//\. ,.|#||##| ,. ,. || ,.,. |\/-' ,.,. ,.|\.
    |\/--' ||,/\.|| |||#/\/|  `\#||| |||#||/\|,/\.|| ||,/'`\.|#|  ,/'`\.|\/-\.
    `\|    ||`\#||| |||#||\|  ,//\/| ||`\|||||`\#||| ||`\.,/\/\|,.`\.,/'`\| `'
     `'    `' `-'`' `'`-'`-'  `-'`-' `' `'`'`' `-'`' `' `'`--'`'`' `'`'  `'


    ,_.,_. ,.       ,.    ,.  ,_.,_. ,.              ,.      ,.
    |#||#| ||       `'    ||  |#||#| `'              ||      ||,_.
    ||\/#| ||,.  ,. ,.,_.,/|  |\||#| ,.,_.,__.,.  ,. || ,.,. |||#| ,.,. ,.,_.
    |||##| ||||  || |||#||#|  |#||#| |||#||##|||  || ||,/||\.||`-',/||\.|||#\.
    ||`--' ||`\_.|| |||\||#|  |#||#| ||||'||\|`\_.|| ||`\||#|`\.,.`\||/'||`--'
    `'     `' |#||| `'|#||#|  |#||#| `'`' `'`' |#||| `' |||/' |||| |||| `'
              `-'`'   `-'`-'  `-'`-'           `-'`'    `'`'  `'`' `'`'


```

This program is a fluid simulator using [Smoothed-particle hydrodynamics
(SPH)](http://en.wikipedia.org/wiki/Smoothed-particle_hydrodynamics) method.

The SPH particles represent the fluid flow.  Particles have information about
the position, density, and velocity.  In every simulation step, they are
changed by pressure force, viscosity force, and external force (i.e., gravity).

This program reads a text from standard input, and uses it as an initial
configuration of the particles.  The character `#` represents "wall particle" (a
particle with fixed position), and any other non-space characters represent
free particles.

The compilation options `-DG=1 -DP=4 -DV=8` represent, respectively, the factor
of gravity, pressure, and viscosity.  By changing their values, you can see
different fluid behavior.

[Marching square](http://en.wikipedia.org/wiki/Marching_squares)-like algorithm
is used to render the particles.

### Portability

The program requires a C99 compiler; it uses `complex` types and one-line
comments.  It also uses `usleep`, which may require `-D_BSD_SOURCE` or so
to build with no warning.  Under these conditions, it should be portable.
At least, recent compilers with `-std=c99 -Wall -W -Wextra -pedantic` say
nothing.

```sh
gcc -DG=1 -DP=4 -DV=8 -D_BSD_SOURCE -std=c99 -Wall -W -Wextra -pedantic endoh1.c

clang -DG=1 -DP=4 -DV=8 -D_BSD_SOURCE -std=c99 -Wall -W -Wextra -pedantic endoh1.c
```

I expect it to work in any Unix-like environment.  VTxxx/ANSI sequences are
used to clear screen and move cursor to home.

I've tested with gcc-4.6.3 and clang-3.0 on Linux (Ubuntu 12.04)
and gcc-4.5.3 and clang-3.1 on Cygwin.  On Cygwin, gcc and clang complain about
a usage of `I` (complex's imaginary unit), but I bet this is cygwin's issue;
it is surely a C99 feature.

### Obfuscation w/ Spoiler

First of all, the source code itself serves as an initial configuration.
Preprocessing directives (such as `#include`)'s `#` serve as walls.

This program uses `double complex` to represent any 2D vector.  But, note that
`x-axis` and `y-axis` is swapped (real axis = y-axis, imaginary axis = x-axis).
The purpose of swapping is not only obfuscation, but also short coding: for
example, to add gravity to total force, `force += G` suffices, rather than
`force += G*I`.

(Incidentally, you can exert horizontal gravity by using for instance `-DG=I`)

Every five entries of `double complex a[]` contain information of one particle:
position, wall-flag, density, force, and velocity, in turn.

You can use `G`, `P`, and `V` as a guide to find the calculation code of
gravity, pressure, and viscosity forces.

Though some assignments may look meaningless, it is actually meaningful; it
extracts "integer part of real part" from a complex value by assigning (and
casting) it to an integer-type variable.

### Notes about Additional Files

[logo.txt](logo.txt) is a source of the logo in this remark file.

[column.txt](column.txt) is a water column collapse, which is a popular demo of SPH.

[pour-out.txt](pour-out.txt) pours you a cup of tea.

[tanada.txt](tanada.txt) simulates "Terrace farming".  ("Tanada" means a "[terraced rice
fields](https://en.wikipedia.org/wiki/Terrace_(earthworks))" in Japanese.)

[clock.txt](clock.txt) is a "water" clock created by HAMANO Tsukasa.

Other `*.txt` files are from the judges.


[endoh1_color.c](endoh1_color.c) is a variant that shows the density by using terminal 256
colors.

### Acknowledgments

I would like to thank my wife @hirekoke for her teaching me the SPH method.

The judges <strike>ordered</strike> suggested creating a color version
after the contest.

The judges and HAMANO Tsukasa (The silver medalist at this IOCCC) kindly
provided many configuration files.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
