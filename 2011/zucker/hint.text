# Most shiny

Matt Zucker  
<mzucker1@swarthmore.edu>  
<http://www.swarthmore.edu/NatSci/mzucker1/>  


## Judges' comments:
### To build:

    make zucker

### To run:

    ./zucker > image.ppm

### Try:

    ./zucker "Hello!!!" > hello.ppm
    ./zucker faster\! -preview > image2.ppm

    # Display the PPM image with your favorite image viewer

### Selected Judges Remarks:

The rendered image is centered and is output as a 600 by 220 pixel PPM.
The vector font is proportional.

This entry uses no local variables. None! At! All!

## Author's comments:
An image generator
==================

What it does:
-------------

This program makes pretty pictures.  To see the default output, try
running

        ./zucker > image.ppm

On the author's 2.5 GHz MacBook Pro, this command takes approximately
1 minute and 18 seconds to run -- your runtime may vary.  You will
need an image viewer capable of displaying Netpbm images in order to
display the output. On the Mac, [Xee](http://wakaba.c3.cx/s/apps/xee)
works well; otherwise [ImageMagick](http://www.imagemagick.org/)
and/or [GraphicsMagick](http://www.graphicsmagick.org/) are both
capable of displaying Netpbm files, and are available on multiple
platforms. (Using Xee is particularly nice because it periodically
reloads the image as it is rendered.)

Aside from the default image, you may create your own by running the
program as follows:

        ./zucker "your text" > image.ppm

To mitigate long runtimes, the program can be invoked in a "preview"
mode by appending `-preview` to the command line arguments, like so:

        ./zucker faster\! -preview > image.ppm

If your platform distinguishes between binary and text streams, you
may need to insert some code to reopen standard output in binary mode
at the start of `main`. An ASCII platform is assumed.

Pedagogical value:
------------------

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

  * It also uses a very small number of library functions: just `putchar`,
    `cos`, `sin`, `atan2`, `sqrt`, and `pow`.

  * New programmers often prefer to use global variables when
    possible. Hence, *all* variables in this program (aside from
    function parameters) have global scope.

  * An important aspect of the computation is graphically illustrated
    by the source code itself: the geometric construction of a
    reflection ray at an object's surface, given the incoming
    direction and surface normal.
    

Further details (contains spoilers):
------------------------------------

The program is not quite a traditional ray tracer, but a "sphere
tracer" which uses distance fields to encode proximity to objects in
the scene. Using sphere tracing to compute visibility instead of
analytic ray tracing provides two advantages: first, it greatly eases
the computation of ray-torus intersection (which would otherwise
require solving a quartic polynomial), and second, it makes it
possible to compute ambient occlusion (which is used to generate soft
shadows). Unlike many traditional ray tracers and sphere tracers, this
one uses iteration instead of recursion to compute the effect of
reflections. This, unfortunately, resulted in the programmer going
insane; however, program size was reduced and readability
hindered. Neither the plaintext for the program's default output nor
for the Netpbm header appears in the program source, which hinders
readability as well. Also, unlike some previous IOCCC entries which
render ASCII text, this one uses a vector (as opposed to raster)
font. Although the program does not generate uppercase letters, it
handles them in a reasonable manner when they appear in the input.

Even when the program is pretty-printed and preprocessor macros are
expanded, it should be fairly resistant to analysis due to reckless
reuse of global variables, to the inherently opaque nature of the
math, and to its overall density. Global variables are used to store
the results of intermediate computation. As a result, seemingly simple
functions have important side effects. Although some of the global
variables are simply constants, their use is overloaded. For instance,
the variable `X` is used both as the number 40 and as the ASCII
character `'('`.  Maintainability is hindered due to hardcoding
several aspects of the program in multiple locations. As an example,
it is impossible to modify either the image width or height without
changing the source in at least three different places, including
inside the large string literal.

Some of the functions are simple vector algebra operations such as
vector construction, dot product, and normalization. However, it was
found to be much more compact to define a single operation for
multiply-and-add rather than to have separate functions for addition,
subtraction, and scaling. Again, compactness led to obfuscation.

This program heavily abuses `for` loops. The comma operator is used to
get as much milage as possible out of statements inside of loop
declarations. Between `for` loops, the comma operator, and the ternary
operator, it was possible to avoid `if` and `while` altogether.

Bitwise and arithmetic operators are used instead of logical operators
whenever gcc doesn't warn about it. Conversely, integer
multiplication, division, and modulus are sometimes used in place of
traditional bitwise operators just to keep the reader on his or her
toes. Automatic casting between characters, integers, and floats is
performed just about everywhere. Fascinatingly, this doesn't seem to
affect performance too badly. Sometimes when an explicit cast
(i.e. from float to int) is needed, the program instead simply assigns
to a free variable of the desired type instead. Both the `array[index]`
and `index[array]` notations are used interchangably throughout the
program.

Two other programs were written to support development of this
program. The first used a randomized search algorithm to deduce the
most compact encoding of the vector font instructions into ASCII; the
second used a modified form of the Knuth-Plass algorithm to layout the
final text on top of a hand-generated ASCII "stencil".  The programs
were not submitted as entries for this year's IOCCC, not because they
lack obfuscation, but because neither is written in C (they are in C++
and Python, respectively).

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
