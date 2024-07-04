## To use:

``` <!---sh-->
    make
```

There are two alt versions that let you control the compile time variables that
control the fluid behaviour and the added variables to speed up or slow down the
fluid as well as setting a timeout (if not 0): one for the original black and
white and one for the colour one added by the author (at the request of the
judges at the time of the contest).  Another version is the deobfuscated version
provided by the author as well.  See the [Alternate code](#alternate-code)
section below for more details.

``` <!---sh-->
    ./endoh1 < file
```

WARNING: if you're sensitive to/don't like flashing colours/text or just want to
see what this looks like not going so fast then you might wish to try the
[Alternate code](#alternate-code) instead.


## Try:

``` <!---sh-->
    ./try.bw.sh endoh1.c
    ./try.sh endoh1.c

    ./try.bw.sh pour-out.txt
    ./try.sh pour-out.txt

    ./try.bw.sh fountain.txt
    ./try.sh fountain.txt
```


## Alternate code:

The files [endoh1.alt.c](%%REPO_URL%%/2012/endoh1/endoh1.alt.c) and
[endoh1_color.alt.c](%%REPO_URL%%/2012/endoh1/endoh1_color.alt.c) correspond to [endoh1.c](%%REPO_URL%%/2012/endoh1/endoh1.c) and
[endoh1_color.c](%%REPO_URL%%/2012/endoh1/endoh1_color.c) but which allow you to speed up or slow down
the fluid and change the behaviour of the fluid. The file
[endoh1.alt2.c](%%REPO_URL%%/2012/endoh1/endoh1.alt.c) is deobfuscated and was provided by the author.


### Alternate build:

For the default values, try:

``` <!---sh-->
    make alt
```

In the `alt` versions a default time of 10 seconds is set as an alarm so that
one can more easily go through the list of files to see them all in succession,
for fun. That is controlled by the variable `TIMER` at compilation.
For instance if you wish to change the value to 5:

``` <!---sh-->
    make clobber TIMER=5 alt
```

If you want to disable the alarm time, set it to 0:

``` <!---sh-->
    make clobber TIMER=0 alt
```

It cannot be < 0 or > 60 (arbitrarily selected).

The `SLEEP` variable is to delay the time between updates to make it easier to
see and to not flash too quickly. The code protects against a value < 0 and
defaults to 12321 but you can change it to. For instance to slow it down you
could increase the sleep time from `12321` to `50000`:

``` <!---sh-->
    make clobber SLEEP=50000 alt
```


If you wish to speed it up you might decrease the sleep time from `12321` to
`9999`:

``` <!---sh-->
    make clobber SLEEP=9999 alt
```

WARNING: the lower the value the faster it will flash so be careful if you're
sensitive to this.


If you wish to change the gravity factor, pressure factor and/or
viscosity factor, you should redefine the values `GRAVITY`, `PRESSURE` and/or
`VISCOSITY` macros, respectively. For instance if you wish to change the
viscosity and pressure factors but leave the other values alone:

``` <!---sh-->
    make clobber VISCOSITY=X PRESSURE=Y alt
```

where `X` and `Y` are numbers or the letter `I` and which are, respectively, the
viscosity and pressure factors. There is no attempt to check the value or type
because doing so prevents the macros from being defined to `I` which would
prevent the author's remarks about it from being done.


You might also wish to try redefining the macros `G`, `P` and/or `V`. For
instance:


``` <!---sh-->
    make clobber GRAVITY=5 PRESSURE=5 VISCOSITY=5 alt
```

You might try even:

``` <!---sh-->
    make clobber GRAVITY=I alt
```

See the author's remarks for details on these macros where:

```
    G = GRAVITY
    P = PRESSURE
    V = VISCOSITY
```


### Alternate use:

Use `endoh1.alt`, `endoh1_color.alt` and `endoh1.alt2` as you would `endoh1`
and `endoh1_color` above.


### Alternate try:

To see two different ways run on the source file and each of the text files,
try:

``` <!---sh-->
    ./try.alt.sh
```

The second run of each will be with the gravity factor set to `I`.

To see the same thing but in the original uncoloured version, try:

``` <!---sh-->
    ./try.alt.bw.sh
```


## Judges' remarks:

Let's play [Jeopardy!](https://en.wikipedia.org/wiki/Jeopardy!)

A: An obfuscated program that deals with complex numbers and produces animated ASCII graphics.
Q: What is a Mandelbrot simulator?

Bzzzt!

Such heavily squeezed fluid simulation (this is parsed uniquely
as fluids are not squeezable) has a few quirks that the judges were
happy to experiment with.

One configuration file was inspired by an [XKCD what if?
entry](https://web.archive.org/web/20230711134609/https://whatif.xkcd.com/6/).


## Author's remarks:

### Synopsis

**DO NOT FORGET** `-DG=1 -DP=4 -DV=8` and make your terminal window larger
than 80 x 25.

``` <!---sh-->
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

This program is a fluid simulator using the SPH:
[Smoothed-particle hydrodynamics](http://en.wikipedia.org/wiki/Smoothed-particle_hydrodynamics) method.

The SPH particles represent the fluid flow.  Particles have information about
the position, density, and velocity.  In every simulation step, they are
changed by pressure force, viscosity force, and external force (i.e., gravity).

This program reads a text from standard input, and uses it as an initial
configuration of the particles.  The character `#` represents a "wall particle" (a
particle with a fixed position), and any other non-space characters represent
free particles.

The compilation options `-DG=1 -DP=4 -DV=8` represent, respectively, the factor
of gravity, pressure, and viscosity.  By changing their values, you can see
different fluid behavior.

[Marching square](http://en.wikipedia.org/wiki/Marching_squares)-like algorithm
is used to render the particles.


### Portability

The program requires a C99 compiler; it uses `complex` types and one-line
comments.  It also uses `usleep(3)`, which may require `-D_BSD_SOURCE` or so
to build with no warning.  Under these conditions, it should be portable.
At least, recent compilers with `-std=c99 -Wall -W -Wextra -pedantic` say
nothing.

``` <!---sh-->
    gcc -DG=1 -DP=4 -DV=8 -D_BSD_SOURCE -std=c99 -Wall -W -Wextra -pedantic endoh1.c

    clang -DG=1 -DP=4 -DV=8 -D_BSD_SOURCE -std=c99 -Wall -W -Wextra -pedantic endoh1.c
```

I expect it to work in any Unix-like environment.  VTxxx/ANSI sequences are
used to clear screen and move cursor to home.

I've tested with gcc-4.6.3 and clang-3.0 on Linux (Ubuntu 12.04)
and gcc-4.5.3 and clang-3.1 on Cygwin.  On Cygwin, gcc and clang complain about
a usage of `I` (complex's imaginary unit), but I bet this is cygwin's issue;
it is surely a C99 feature.


### Obfuscation

First of all, the source code itself serves as an initial configuration.
Preprocessing directives (such as `#include`)'s `#` serve as walls.

This program uses `double complex` to represent any 2D vector.  But, note that
the `x-axis` and `y-axis` are swapped (real axis = y-axis, imaginary axis =
x-axis).  The purpose of swapping is not only obfuscation, but also short
coding: for example, to add gravity to total force, `force += G` suffices,
rather than `force += G*I`.

(Incidentally, you can exert horizontal gravity by using for instance `-DG=I`)

Every five entries of `double complex a[]` contain information of one particle:
position, wall-flag, density, force, and velocity, in turn.

You can use `G`, `P`, and `V` as a guide to find the calculation code of
gravity, pressure, and viscosity forces.

Though some assignments may look meaningless, they are actually meaningful; they
extract "integer part of real part" from a complex value by assigning (and
casting) it to an integer-type variable.


### Notes about Additional Files

[logo.txt](logo.txt) is a source of the logo in this remark file.

[column.txt](column.txt) is a water column collapse, which is a popular demo of SPH.

[pour-out.txt](pour-out.txt) pours you a cup of tea.

[tanada.txt](tanada.txt) simulates "Terrace farming".  ("Tanada" means a
"[terraced rice](https://en.wikipedia.org/wiki/Terrace_&#x28;earthworks&#x29; fields)" in Japanese.)

[clock.txt](clock.txt) is a "water" clock created by HAMANO Tsukasa.

Other `*.txt` files are from the judges.


[endoh1_color.c](%%REPO_URL%%/2012/endoh1/endoh1_color.c) is a variant that shows the density by using terminal 256
colors.

### Acknowledgments

I would like to thank my wife @hirekoke for her teaching me the SPH method.

The judges <del>ordered</del> suggested creating a color version
after the contest.

The judges and HAMANO Tsukasa (The silver medalist at this IOCCC) kindly
provided many configuration files.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
