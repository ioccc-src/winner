# Most complex ASCII fluid - Honorable mention

Yusuke Endoh  
<mame@ruby-lang.org>  
<https://github.com/mame/>  


## Judges' comments:
### To build:

    make endoh1

### To run:

    ./endoh1 < configuration.txt

### Try:

    ./endoh1 < endoh1.c

    ./endoh1 < pour-out.txt

    ./endoh1 < fountain.txt

### Selected Judges Remarks:

Let's play Jeopardy!

*   A: An obfuscated program that deals with complex numbers and produces animated ASCII graphics.
*   Q: What is a Mandelbrot simulator?

Bzzzt!

Such heavily squeezed fluid simulation (this is parsed uniquely
as fluids are not squeezable) has a few quirks that the judges were
happy to experiment with.

One configuration file was inspired by an [XKCD what if? entry](http://whatif.xkcd.com/6/).

## Author's comments:
### Synopsis

**DO NOT FORGET "-DG=1 -DP=4 -DV=8"** and make your terminal window larger
than 80 x 25.

    gcc endoh1.c -DG=1 -DP=4 -DV=8 -D_BSD_SOURCE -o endoh1 -lm
    ./endoh1 < endoh1.c
    ./endoh1 < logo.txt
    ./endoh1 < column.txt
    ./endoh1 < pour-out.txt
    ./endoh1 < tanada.txt


### What it is

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


This program is a fluid simulator using "Smoothed-particle hydrodynamics (SPH)"
method.

<http://en.wikipedia.org/wiki/Smoothed-particle_hydrodynamics>

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

"Marching square"-like algorithm is used to render the particles.

<http://en.wikipedia.org/wiki/Marching_squares>


### Portability

The program requires a C99 compiler; it uses `complex` types and one-line
comments.  It also uses `usleep`, which may require `-D_BSD_SOURCE` or somewhat
to build with no warning.  Under these conditions, it should be portable.
At least, recent compilers with `-std=c99 -Wall -W -Wextra -pedantic` says
nothing.

    gcc -DG=1 -DP=4 -DV=8 -D_BSD_SOURCE -std=c99 -Wall -W -Wextra -pedantic endoh1.c
    clang -DG=1 -DP=4 -DV=8 -D_BSD_SOURCE -std=c99 -Wall -W -Wextra -pedantic endoh1.c

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
x-axis and y-axis is swapped (real axis = y-axis, imaginary axis = x-axis).
The purpose of swapping is not only obfuscation, but also short coding: for
example, to add gravity to total force, `force += G` suffices, rather than
`force += G*I`.
(Incidentally, you can exert horizontal gravity by using, such as, `-DG=I`)

Every five entries of `double complex a[]` contain information of one particle:
position, wall-flag, density, force, and velocity, in turn.

You can use `G`, `P`, and `V` as a guide to find the calculation code of
gravity, pressure, and viscosity forces.

Though some assignments may look meaningless, it is actually meaningful; it
extracts "integer part of real part" from a complex value by assigning (and
casting) it to an integer-type variable.


### Notes about Additional Files

"logo.txt" is a source of the logo in this remark file.

"column.txt" is a water column collapse, which is a popular demo of SPH.

"pour-out.txt" pours you a cup of tea.

"tanada.txt" simulates "Terrace farming".  ("Tanada" means a "terraced rice
fields" in Japanese.)

"clock.txt" is a "water" clock created by HAMANO Tsukasa.

Other \*.txt files are due to the judges.


"endoh1\_color.c" is a variant that shows the density by using terminal 256
colors.


### Acknowledgment

I would like to thank my wife @hirekoke for her teaching me the SPH method.

The judges <strike>ordered</strike> suggested creating a color version
after the judgment.

The judges and HAMANO Tsukasa (The silver medalist at this IOCCC) kindly
provided many configuration files.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
