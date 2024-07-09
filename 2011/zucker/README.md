## To build:

``` <!---sh-->
    make
```

There is an alternate version which should work for Windows which distinguishes
binary mode from text mode. See [alternate code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./zucker > image.ppm
```

Now open `image.ppm` with your image viewer of choice.


## Try:

``` <!---sh-->
    ./try.sh
```

After running `try.sh`, open the PPM images `ioccc.ppm`, `hello.ppm` and
`image2.ppm` with your image viewer of choice.


## Alternate code:

This version uses the Windows functions `_setmode()` and `_fileno()` to set
binary mode on `stdout` which the author noted would be necessary for systems
that distinguish binary and text.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `zucker.alt` as you would `zucker` above.


### Alternate try:

Try `zucker.alt` instead of `zucker` above.


## Judges' remarks:

The rendered image is centered and is output as a 600 by 220 pixel PPM.
The vector font is proportional.

This entry uses no local variables. None! At! All!


## Author's remarks:

### An image generator

#### What it does:

This program makes pretty pictures.  To see the default output, try
running

``` <!---sh-->
    ./zucker > ioccc2011.ppm
```

On the author's 2.5 GHz MacBook Pro, this command takes approximately 1 minute
and 18 seconds to run -- your runtime may vary.  You will need an image viewer
capable of displaying [Netpbm images](https://en.wikipedia.org/wiki/Netpbm) in
order to display the output. On the Mac, the system supplied `Preview.app` works
well; otherwise [ImageMagick](http://www.imagemagick.org/) and/or
[GraphicsMagick](http://www.graphicsmagick.org/) are both capable of displaying
Netpbm files, and are available on multiple platforms.

With macOS you can type at the command line:

``` <!---sh-->
    open ioccc2021.ppm
```

and it will open image in the default application Preview.app.

To use ImageMagick you might do something like:

``` <!---sh-->
    convert ioccc2011.ppm ioccc2011.png
```

and then open `ioccc2011.png` in your viewer of choice.

To use GraphicsMagick you might do something like:

``` <!---sh-->
    gm convert ioccc2011.ppm ioccc2011.png
```

and then open `ioccc2011.png` in your viewer of choice.

Aside from the default image, you may create your own by running the
program as follows:

``` <!---sh-->
    ./zucker "your text" > image.ppm
```

To mitigate long runtime, the program can be invoked in a "preview"
mode by appending `-preview` to the command line arguments, like so:

``` <!---sh-->
    ./zucker faster\! -preview > image.ppm
```

If your platform distinguishes between binary and text streams, you may need to
insert some code to reopen standard output in binary mode at the start of
`main()` (the provided [alternate version](#alternate-code) will set binary mode
on `stdout` in Windows). An ASCII platform is assumed.


#### Pedagogical value:

This program is quite suitable for the inexperienced programmer, due
to a number of considerations:

* It is fairly short: just 4 preprocessor directives followed by 29
lines of source.

* It compiles cleanly as ANSI C under gcc 4.2.1 with very strict
compilation flags.

* It uses a very small subset of the keywords available in C, namely
`char`, `float`, `int`, `typedef`, `struct`, `for`, and `return`.
More difficult concepts such as `void`, `if`, `switch`, and
`while` are eschewed for simplicity's sake.

* It also uses a very small number of library functions: just `putchar(3)`,
`cos(3)`, `sin(3)`, `atan2(3)`, `sqrt(3)`, and `pow(3)`.

* New programmers often prefer to use global variables when
possible. Hence, *all* variables in this program (aside from
function parameters) have global scope.

* An important aspect of the computation is graphically illustrated
by the source code itself: the geometric construction of a
reflection ray at an object's surface, given the incoming
direction and surface normal.


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


### How this entry works:

The program is not quite a traditional [ray
tracer](https://en.wikipedia.org/wiki/Ray_tracing_&#x28;graphics&#x29;), but a "[sphere
tracer](sphere-tracing.pdf)" which uses distance fields to encode proximity to
objects in the scene. Using sphere tracing to compute visibility instead of
analytic ray tracing provides two advantages: first, it greatly eases the
computation of [ray-torus](https://en.wikipedia.org/wiki/Toric_lens#Torus)
intersection (which would otherwise require solving a quartic polynomial), and
second, it makes it possible to compute [ambient
occlusion](https://en.wikipedia.org/wiki/Ambient_occlusion) (which is used to
generate soft shadows). Unlike many traditional ray tracers and sphere tracers,
this one uses iteration instead of recursion to compute the effect of
reflections. This, unfortunately, resulted in the programmer going insane;
however, program size was reduced and readability hindered. Neither the
plaintext for the program's default output nor for the Netpbm header appears in
the program source, which hinders readability as well. Also, unlike some
previous IOCCC entries which render ASCII text, this one uses a vector (as
opposed to raster) font. Although the program does not generate uppercase
letters, it handles them in a reasonable manner when they appear in the input.

Even when the program is pretty-printed and preprocessor macros are
translated, it should be fairly resistant to analysis due to reckless
reuse of global variables, the inherently opaque nature of the
math, and its overall density. Global variables are used to store
the results of intermediate computation. As a result, seemingly simple
functions have important side effects. Although some of the global
variables are simply constants, their use is overloaded. For instance,
the variable `X` is used both as the number `40` and as the ASCII
character `'('`.  Maintainability is hindered due to hardcoding
several aspects of the program in multiple locations. As an example,
it is impossible to modify either the image width or height without
changing the source in at least three different places, including
inside the large string literal `J`.

Some of the functions are simple vector algebraic operations such as
vector construction, dot product, and normalization. However, it was
found to be much more compact to define a single operation for
multiply-and-add rather than to have separate functions for addition,
subtraction, and scaling. Again, compactness led to obfuscation.

This program heavily abuses `for` loops. The comma operator is used to
get as much mileage as possible out of statements inside of loop
declarations. Between `for` loops, the comma operator, and the ternary
operator, it was possible to avoid `if` and `while` altogether.

Bitwise and arithmetic operators are used instead of logical operators whenever
gcc doesn't warn about it. Conversely, integer multiplication, division, and
modulus are sometimes used in place of traditional bitwise operators just to
keep the reader on his or her toes. Automatic casting between characters,
integers, and floats is performed just about everywhere. Fascinatingly, this
doesn't seem to affect performance too badly. Sometimes when an explicit cast
(i.e. from `float` to `int`) is needed, the program instead simply assigns to a
free variable of the desired type instead. Both the `array[index]` and
`index[array]` notations are used interchangeably throughout the program.

Two other programs were written to support development of this program. The
first used a randomized search algorithm to deduce the most compact encoding of
the vector font instructions into ASCII; the second used a modified form of the
[Knuth-Plass](https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap) algorithm
to layout the final text on top of a hand-generated ASCII "stencil".  The
programs were not submitted as entries for this year's IOCCC, not because they
lack obfuscation, but because neither is written in C (they are in C++ and
Python, respectively).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
