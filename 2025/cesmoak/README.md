Award: Retro space award

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog [width] < prog.c | ./prog | ./prog | ./prog > some.pgm
    ./prog [-d] < some.data > some.pgm
    ./prog [width] < prog.c | ./prog | ./prog -d > some.pgm
```


## Try:

``` <!---sh-->
    # NOTE: try_examples.sh might take 9 - 18 minutes

    ./try_examples.sh

    # NOTE: try_rpg.sh might take 8 - 16 minutes

    ./try_rpg.sh

    # NOTE: try_tools.sh might take 8 - 16 minutes

    ./try_tools.sh

    # NOTE: try.sh might might take 9 - 18 hours

    ./try.sh
```


## Judges' remarks:

Black holes are known to distort space and time.  Fortran depends on
character spaces, and stool the test of time.  And with this marvelous
entry, you experience both, and more!

Since the age of 4, back in 1964, one of the
judges has fond memories of playing at an
[IBM 029 keypunch](https://en.wikipedia.org/wiki/Keypunch#IBM_029_Card_Punch)
to make lots of fun punch cards.  Moreover, tray sized boxes of punch
cards made excellent card towers: much better than playing cards, and
many more of them too.

Do you know your [punch card extended character
set](https://en.wikipedia.org/wiki/Punched_card#/media/File:Blue-punch-card-front-horiz.png)?
If might help you decode some of the intermediate output without having to compile.  ;-)


### A fun challenge

Please checkout the [fun challenge&lpar;s&rpar;](../challenge.html#cesmoak) for this winning entry.


### For the impatient


#### try_examples.sh

The [2025/cesmoak/try_examples.sh](%%REPO_URL%%/2025/cesmoak/try_examples.sh) script can take
a while to execute.
To see what it may produce, see:

* download mandelbrot.ppm as out.mandelbrot.ppm ==> [2025/cesmoak/out.mandelbrot.ppm](out.mandelbrot.ppm)
* download march.ppm as out.march.ppm ==> [2025/cesmoak/out.march.ppm](out.march.ppm)
* download tracer.ppm as out.tracer.pgm.tracer.ppm ==> [2025/cesmoak/out.tracer.pgm](out.tracer.pgm)

View the downloaded ppm files with your favorite image viewer.


#### try_rpg.sh

The [2025/cesmoak/try_rpg.sh](%%REPO_URL%%/2025/cesmoak/try_rpg.sh) can take
a while to execute.
To see what it may produce, see:

* view prog.deck ==> [2025/cesmoak/out.prog.deck](%%REPO_URL%%/2025/cesmoak/out.prog.deck)
* download paper.pgm as out.paper.pgm ==> [2025/cesmoak/out.paper.pgm](out.paper.pgm)
* download print.pgm as out.print.ppm ==> [2025/cesmoak/out.print.pgm](out.print.pgm)

View the downloaded ppm files with your favorite image viewer.


#### try_tools.sh

The [2025/cesmoak/try_tools.sh](%%REPO_URL%%/2025/cesmoak/try_tools.sh) can take
a while to execute.
To see what it may produce, see:

* download contour_160x80.pgm as out.contour_160x80.pgm ==> [2025/cesmoak/out.contour_160x80.pgm](out.contour_160x80.pgm)


#### try.sh

The [2025/cesmoak/try.sh](%%REPO_URL%%/2025/cesmoak/try.sh) script can take
a while to execute.
To see what it may produce, see:

* download render_60x30.pgm as out.render_60x30.pgm ==> [2025/cesmoak/out.render_60x30.pgm](out.render_60x30.pgm)
* download print_160x80.pgm as out.print_160x80.pgm ==> [2025/cesmoak/out.print_160x80.pgm](out.print_160x80.pgm)
* download print_480x240.pgm as out.print_480x240.pgm ==> [2025/cesmoak/out.print_480x240.pgm](out.print_480x240.pgm)
* download print_1200x600.pgm as out_1200x600.pgm ==> [2025/cesmoak/out.print_1200x600.pgm](out.print_1200x600.pgm)

View the downloaded pgm files with your favorite image viewer.


### A fun challenge

Write a "textual Fortran" program to to something else interesting,
such as to print a fractal curve, print the value of pi to 1000
decimal places, or count the number of months ending in Tuesday
for a given century.


## Author's remarks:


### What it is

This program is a Jean-Pierre Luminet RPG. You are
[Jean-Pierre Luminet](https://en.wikipedia.org/wiki/Jean-Pierre_Luminet)
in 1978. You are making the first-ever simulated photograph of a black hole.

First, think through the math for a black hole in Schwarzschild
spacetime. Review those papers carefully. You might need a stiff drink
and/or chocolate while writing down your notes.

``` <!---sh-->
    cp prog.c scribbled.notes
```

Now, take your notes and translate the appropriate formulas to a program
that will calculate the light visible to an observer looking towards
the black hole.

``` <!---sh-->
    cp prog cardpunch
    ./cardpunch 160 < scribbled.notes > prog.deck
```


Next, run your program on an
[IBM 7040](https://en.wikipedia.org/wiki/IBM_7040)
to calculate observed flux
at points around a black hole. This will take a while.  (Using `160` --
the width -- above will cause this step to take 5-10 minutes.)

``` <!---sh-->
    cp prog ibm7040
    ./ibm7040 < prog.deck > flux.data
```


OK, now make a drawing. Use ink and draw dots more densely in areas that
show larger observed flux. Look at all that white space!

``` <!---sh-->
    cp prog pen
    ./pen < flux.data > paper.pgm
```


Finally, make a print from your paper negative.

``` <!---sh-->
    cp prog darkroom
    ./darkroom < paper.pgm > print.pgm
```

Great job, researcher! C'est magnifique! Vous êtes une vraie singularité!


### Special Usage


#### As a card punch

``` <!---sh-->
    ./prog [width] < prog.c > prog.deck
```

`width` - width of the ultimate image in pixels; defaults to 1200;
output image will be half as tall as it is wide; sizes below 120 are
significantly less recognizable. Large sizes can take many hours. Min
width is 2. Max width should be 1295 (based on calculations).


#### As an india ink pen

``` <!---sh-->
    ./prog [-d] < flux.data > paper.pgm
```

`-d` - the presence of any value here (doesn't have to be `-d`) directs
the program to create a direct image of the data without stippling;
default is to use stippling


#### Combining all steps

To create a print of a given width:

``` <!---sh-->
    ./prog [width] < prog.c | ./prog | ./prog | ./prog > print.pgm
```

To create a smooth rendering of a given width:

``` <!---sh-->
    ./prog [width] < prog.c | ./prog | ./prog -d > render.pgm
```


### How it works

This program has several steps, each expecting a different kind of input
and generating a different type of output.

The first step takes in a program (encoded as whitespace) and outputs
a Fortran program as a deck of punch cards.

The second step takes in a punch card deck, processes its Fortran program,
writing any output from the program to stdout. For the program embedded
in `prog.c`, the output is a list of values of observed flux for a grid
around a black hole.

The third step takes in flux data and writes out a corresponding image
as if you were drawing it by stippling on paper with ink.

The final step takes the paper negative image from the previous step
and creates a positive "print" of it.

These are designed to approximately [follow the
steps](https://arxiv.org/abs/1902.11196) Luminet used to create his
simulated photograph of a black hole.

The final "print" output image, at a suitably
large resolution, will closely match Fig 11 in
[Luminet's 1979 paper](https://www.researchgate.net/publication/234464726_Image_of_a_spherical_black_hole_with_thin_accretion_disk),
initially published in 1978.


### Fortran processor

This program includes a processor (interpreter) for a subset of
ANSI [FORTRAN 66](https://wg5-fortran.org/ARCHIVE/Fortran66.pdf)
(a formalization of FORTRAN IV). Something like this would have been
available on the IBM 7040 that Luminet used in 1978. The author lovingly
calls this subset FORTRAN III.5.

The subset was chosen to run the embedded program that computes flux
around a black hole. It can also run other programs -- they must be
provided as a deck of punch cards. Several programs have been included
for demonstration purposes, including a pre-obfuscation version of the
flux program. Tools have been provided to convert to/from decks and to
interpret (using the punch card meaning, i.e., annotate with text) decks.

Supported features:
- `REAL`, `COMPLEX`, and `LOGICAL` types
- Variables and assignment statements (only the first 3 characters of variable names are significant)
- Arithmetic operators: binary `+`,  `-`,  `*`,  `/`,  `**` (integer divide is not supported), and unary `-` (unary `+` is not supported)
- Arithmetic -> Logical operators: `.LT.`, `.LE.`, `.GT.`, `.GE.`, `.EQ.`, `.NE.`
- Logical operators: `.AND.`, `.OR.`, `.NOT.`
- Operator precedence is as expected
- A standard library of *several* functions: `ABS(x)`, `ALOG(x)`, `AMOD(x,y)`, `SIN(x)`, `COS(x)`, `CMPLX(r,i)`, `REAL(c)`, `AIMAG(c)`, `CABS(c)` (This is a selection of intrinsic and external functions from the specification.)
- `GOTO` with a single numeric label
- `ASSIGN` `TO`
- Logical `IF`
- `DO` loops with optional step, and support for extended range loops (`GOTO` out of a loop and then back into it)
- `WRITE` statements (file argument is ignored, will always write to `stdout`)
- `FORMAT` statements with support for outputting integers `In`, reals `Fn.m`, spaces `nX`, and Hollerith constants `nHx` (`m` is single-digit only; Hollerith constants do not support space -- use `nX` for this; no repeat counts, no grouping parentheses, no `/`, arguments do not loop if fewer than number of arguments in a corresponding `WRITE`)
- Comments (line starts with `C`)
- `CONTINUE`

Notable FORTRAN 66 features that have been faithfully replicated for your enjoyment:

- The simplicity of ALL CAPS and a full 47 character set!
- Whitespace independence -- use as much or as little as you like
- Fixed-format lines -- column 1: comment marker, 1-5: line number, 6: continuation marker, 7-72: code, 73-80: ignored

`END`, `PROGRAM`, and some other statements are silently ignored.

Missing from FORTRAN III.5: `READ`, `FUNCTION`, `SUBROUTINE`, arrays, `DATA` blocks, `INTEGER` type, etc.

Fortran has a several unique behaviors:

- Unary `-` has an unusual precedence compared with most languages: it is lower precedence than `**`, and `*`, `/`
- The spec says that `**` doesn't support left- or right-association and is not allowed to be chained without parentheses. This processor uses left-association for all operators and allows them to be chained.
- FORTRAN 66 supports implicit variable declaration with a default type based on the first letter of the variable name. Variables in this processor are dynamically-typed and integer is not a supported type.
- Hollerith constants allow for characters to be output with `WRITE`. They have the format `nHx` where `n` is the number of characters to consume/output after `H` and `x` is a series of `n` characters. In this processor, any character in the valid set except space is allowed in Hollerith constants. Spaces can be output using `nX` instead.
- `$` is in the relatively slim character set in FORTRAN 66, but isn't used in code, only as an output character in Hollerith constants.
- There are no reserved keywords in FORTRAN 66 -- variables may be named the same as control structures. The embedded program shows examples of using `IF` as a variable as well as a control structure.
- Whitespace independence allows for very compact obfuscated code, and very unreadable whitespace-heavy code. `D O` or `I F` or `3 .  14  15` are all fine, even split across multiple lines using continuation markers.
- Only the first 6 characters of an identifier are significant. The spec is silent on characters in identifiers after 6, and most processors ignored extra characters. This processor treats only the first 3 characters as significant, so you can think of this as a more flexible version of Fortran in case you have trouble with spelling.
- FORTRAN 66 processors often used an internal 6-bit BCD encoding for code. This Fortran processor uses the IBM "9 code" 6-bit BCD encoding internally.

This processor effectively has dynamic typing. You can reassign variables
to different types and it won't complain. Type declarations are silently
ignored. Expressions also have more flexibility than the spec allows,
and you can mix logical and real types.

FORTRAN III.5 does not support subroutines due to the IOCCC size
constraint. However, a pidgin version of subroutines (effectively a gosub)
can be implemented by using `ASSIGN` `TO` and `GOTO`. There is some use
of this in the example programs.

Original FORTRAN 66 compilers would only report one compile error at a
time, resulting in much lost time fixing bugs. Correspondingly, expect any
errors in your code passed to this processor to cause undefined behavior,
likely a segmentation fault. Only syntactically-correct code is supported.

If a number is too large to `WRITE` with a given format, it will still
print and use more characters. FORTRAN 66 doesn't specify a behavior here,
though other compilers often output `*****` in this case.


#### Limits

- Punch card decks should support at least 4,140 cards (based on calculations), but likely more, depending on how many chads are present on the cards.
- Numbers must be fewer than 32 characters long.

The example programs provided also run with `gfortran` (you must use
`--std=legacy` with `gfortran` to enable FORTRAN 66 support) once
converted to `.f` files.

The `INT` function is provided (as opposed to `AINT`) so `gfortran`
is happy when using `WRITE`/`FORMAT` with `In`. It effectively behaves
the same as `AINT` would in III.5.


### Embedded program

The embedded Fortran program is a ray tracer, calculating observed flux
for a non-rotating black hole surrounded by a thin, optically-thick
accretion disk. The observer has the same viewpoint as Luminet's original
black hole image.

Notably, this ray tracer uses the same underlying math to calculate
the flux seen by the viewer, though it differs in how it calculates the
trajectory (for code size reasons). Specifically, we use ray marching
from the observer and calculate flux if it hits the accretion disk,
whereas Luminet integrated light ray trajectories to compute isoradial
curves, then derived constant flux contours from those.

Our approach also gives up some performance in order to be small. It uses
Euler integration with a small step instead of more advanced integrators
that would allow for larger steps.

If you convert the punch cards for this program to a `.f` file, it runs
as expected using `gfortran` (using `--std=legacy`).

``` <!---sh-->
    ./prog 160 < prog.c | ./convert -d > tracer_160.f
    gfortran --std=legacy -o tracer_160 tracer_160.f
    ./tracer_160 | ./prog -d > render_160x80.pgm
```

`gfortran` wants complex variables declared as such, so that declaration
is the first line of the program. FORTRAN III.5 ignores variable
declarations. To further assuage `gfortran`, variables that need to be
treated as integers use the default type prefixes (`I`-`N`). In our
processor, these variables are `REAL`s but behave in effectively the
same way for this program.

The author observes that FORTRAN 66 is entirely whitespace independent
and early Fortran programs would often avoid using whitespace. So it is
fitting that we have encoded the embedded Fortran program within the
provided C file entirely using whitespace. Doing our part to restore
balance to the world.

There is a commented, non-obfuscated, and non-golfed version of this
program included at `examples/tracer.deck`. This version outputs a PGM
file directly.


### Punch cards

This program uses "punch cards" as input to the Fortran
processor, as you would do in the 1970s with FORTRAN 66. It
uses the IBM "H code" encoding used by the
[IBM 029 Card Punch](https://twobithistory.org/2018/06/23/ibm-029-card-punch.html)
for Fortran. Cards are 12 punches per column, 80 columns
wide. See Appendix B of the
[IBM 7040 Operating System Reference](https://www.bitsavers.org/pdf/ibm/7040/C28-6335-2_7040_MAP.pdf)
for "9 Code" and "H Code" character set mappings.

The punch card file format orders cards sequentially. Just like the
physical objects, the first line on each card is left blank so you can
write on it if you'd like. In fact, just like the originals, you can write
(single-byte characters) anywhere on the cards except on the edges and
where the holes are.

Annotating cards was called "interpreting" them. An interpreter tool is
included. Apologies if the name of the tool causes any confusion. :&rpar;

Our printed punch cards have a border that makes each card 15 characters
tall and 86 characters wide (the first 4 characters of each line are
skipped as are the final 2), with a blank line between cards. The parser
expects certain parts of this format to be consistent, so modify the
layout of the cards at your own risk.

Here is an example interpreted card:

```
       .---------------------------------------------------------------------------------.
      /       PI = 3.1415927                                                             |
     /         ▌    ▌                                                                    |
    |         ▌                                                                          |
    |                                                                                    |
    |                ▌ ▌                                                                 |
    |                     ▌                                                              |
    |            ▌ ▌▌                                                                    |
    |                 ▌                                                                  |
    |                   ▌                                                                |
    |                                                                                    |
    |         ▌            ▌                                                             |
    |            ▌  ▌                                                                    |
    |          ▌         ▌                                                               |
    '------------------------------------------------------------------------------------'
```


### Tools

A few tools are provided to enable working with code, punch cards,
and image outputs. AI coding agents were used to help make these tools
along with others the author used when creating this entry. You can
build these with `make tools`.


#### Convert a `.deck` file to a `.f` file

``` <!---sh-->
    ./convert -d < code.deck > code.f
```


#### Convert a `.f` file to a `.deck` file

``` <!---sh-->
    ./convert -f [-t] < code.f > code.deck
```

`-t` - Add text to the top of each punch card with the source text.


#### Annotate punch cards in a `.deck` file with the source text

We use the punch card meaning of "interpret" here.

``` <!---sh-->
    ./interpret < code.deck > annotated.deck
```


#### Render a contour image of flux data

Fig 10 of Luminet's 1979 paper shows several contours of fixed level
flux. You can recreate this image using the flux data intermediate format
by running the following.

``` <!---sh-->
    ./contour < flux.data > contour.pgm
```


### Obfuscation

Obfuscation is accomplished in several ways.


#### C code

Unusual encoding formats make tracing data through the program
difficult. The program is multifunctional, processing four different input
file formats. The program is difficult to read because of its layout, and
yet its layout is important when passing the source in as the first step.

Many standard tricks are also used, including some just to reduce the size
of the program enough to get all the functionality and data stuffed in.

Most variables have multiple uses, sometimes at different parts of
iteration through a single loop.

Lots of obscure bit twiddling and shifting is used for each kind of
input data.

Magic numbers are used in the operator table in the expression
function. These numbers encode the precedence level (0-6), which operator,
and the number of characters needed to advance past the operator in
the source.

All variable values for the interpreter are stored as complex floats.

Punch cards are drawn using strings that are part of the embedded
whitespace data, making it difficult to identify the relevant code at
first glance.

The punch card drawing strings, the Fortran source code, and the PGM
header all use the same lookup table string. It may also have a hidden
message embedded in it -- somehow...

Punch cards are converted to 6-bit BCD to run the program instead
of converting to ASCII. Typical recognizable ASCII character numbers
are only present in a few places. This BCD variant "9 code" uses the
`0` value to mean `'0'` instead of `NULL`, so things that look like
end-of-string null tests are not.

Four different types of input are all parsed in a single loop.

Two different image rendering algorithms use the same loop. In one case,
it renders a dynamic density Poisson disk version of the flux data passed
in, using a varying size spiral to remove pixels from being rendered,
and in the other case, it uses the same spiral code to instead render
additive antialiased points.

Clearly, the source file is laid out as a beautifully-rendered image of
an IBM 7040 that is sitting just a tad too close to a black hole. ;&rpar;
(White)space is unfortunately tearing it apart.

The "void star" defines provide a hint as to the purpose of the code
but will likely be misunderstood as the C code meaning. The meaning of
"null geodesic" may be more clear.


#### Embedded program

A Fortran program is embedded in the C file using whitespace. This
embedded whitespace also encodes a set of strings used when printing a
punch card deck.

In the C file, this section begins after parts of the code that care about whitespace.

The whitespace encoding is multi-layered to increase the amount of data
that can be stored. Every set of eight whitespace characters encodes
18 bits (5 whitespace options ** 8 > 2 ** 18), enough for three 6-bit
"9 code" BCD values. Additionally, the length of each run of whitespace
between non-whitespace encodes 2 bits (1-4 length runs = 2 bits). These
two streams are concatenated.

The decoded data is a stream of 6-bit values. The first 38 values are
characters used to draw the punch cards. These require a lookup into
a character set table. Everything after that is decoded from 6-bit BCD
"9 code" to "H code" and printed as chads on punch cards.

To save space, when converting whitespace-encoded Fortran source to punch
cards, certain features are not supported because they aren't needed
for the flux program. Columns 1-6 are skipped unless there is a label,
and only a single character label is supported. Continuation markers and
comments are also not supported. Note, however, that these restrictions
only apply to this embedded program.

The embedded program source has a few obfuscations of its own. It uses
single-character variables except for a couple fun variables like `IF`
used alongside control structures with the same name. `DO9M` is used
alongside a `DO` loop. A space is embedded within a `DO` loop to be
confusing. As a way to be further confusing, complex numbers are used
for some math involving pairs of coordinates.


#### Fortran

Early versions of Fortran can be confusing and have many features that feel like built-in obfuscations.

For example:

``` <!---fortran-->
          DO10I=1,10
          DO10I=1.10
          IF=(0)
            THEN=1
          IF(IF.LT.1)IF=THEN
          G OT O1 23
          PI=4 141 6E - 4 - 1
    C THE NEXT TWO ASSIGNMENTS TO X ARE EQUIVALENT
          X=1 2* *2 . 5
          X=1
         92**2.5
       10 CONT IN UE
```

As a child, the author was very confused by Fortran programs and why
they looked vaguely like incomprehensible BASIC programs.

Early versions of Fortran didn't support quoted strings -- instead using
Hollerith constants, which we also support. With Hollerith constants,
`"HELLO)"` is written as `6HHELLO)`.

Early Fortran implementations supported up to a specific number of
characters to determine an identifier, and it was standard practice
to consume but ignore any identifier characters after the number that
were recognized. On most systems, the first 6 characters of a variable
name were significant, but you could use more than 6. So `BASKETBALL`
and `BASKET` would refer to the same variable. In this implementation,
variable names support up to 3 significant characters, so you can make
confusing variable names easier than ever! (Three was also the number
required to support the standard functions needed for the flux code.)


#### Punch cards

Punch cards are naturally obfuscated and difficult to read.

There are three "zone" rows, 12, 11, and 0, but 0 is also the first of the
increasing digit rows 0-9, but also sometimes 8 is treated like a zone row.

The fixed-format structure for punch cards encoding Fortran is
confusing. Comments must use `C` in the first column. Labels may use
columns 1-5, but must ignore column 6, which may have a digit. Column
6 is the continuation marker and any character other than blank or `0`
means the line continues the previous one. Code starts immediately after
the continuation marker and runs only until column 72, leaving the final
8 columns as user-defined. None of this is intuitive.

This entry may be one of the few IOCCC programming language implementations
where the example source files are presented in such a way that they
don't immediately give away which language it implements.


### Note

In no way is the author attempting to subtly play to the interests of
the judges -- it is very much blatant.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
