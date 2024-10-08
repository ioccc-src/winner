## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2006/stewart in bugs.html](../../bugs.html#2006_stewart).


## To use:

``` <!---sh-->
    ./stewart width_and_height iterations file > file.xbm
    convert file.xbm file.png
```

where `file` is one of:

> altar box box2 box3 build carpet<br>
> circles cross cross2 cross3 crystal<br>
> curve diamonds diamonds2 dragon<br>
> dragon2 dragon3 fern gasket gasket_mod<br>
> gasket_mod2 ioccc maze octagon pentagon<br>
> pentagons rings rings2 spirals spirals2<br>
> spirals3 spirals4 squares stars stars2<br>
> tree tree2 tree3 tree4 triangle

**NOTE**: you cannot specify a different width from height; it's one number.

**NOTE**: `convert(1)` belongs to [ImageMagick](https://imagemagick.org/index.php).


## Try:

``` <!---sh-->
    ./try.sh
```

After running the program on a few files it will ask you if you wish to run it
on the remaining files.

The script will try converting the xbm files created by the program to png
files. If it does it will list those that exist in the directory, at the end of
the script. If you do not have `convert(1)` it will warn you once. In that case
you'll have to open the xbm files in a graphics viewer capable of viewing xbm
images. In any case choose your favourite graphics viewer to look at the images
created.


## Judges' remarks:

Note the interesting choice of using a `#define` in the output.
The selection of input files makes this one endlessly fun to play
with.  Many image viewers will be able to read the results, as will
a reasonably experienced user who can parse formats in their mind.  :-)


## Author's remarks:

### Execution

The program should be run with the following

``` <!---sh-->
    ./stewart <m> <n> <ifs>
```

where:

- `m`
    - The size of the picture (picture will be m X m in size).
- `n`
    - The number of iterations to run (More will make for a clearer picture).

- `ifs`
    - The file to use as input.

The program will spit out an [XBM image](https://en.wikipedia.org/wiki/X_BitMap)
on standard out.  Minimal checking is done on the arguments mainly that there
are 3.  Wrong arguments will cause the program to bomb out.

#### Example:

``` <!---sh-->
    ./stewart 1024 1000000 gasket > gasket.xbm
```

### Compilation/Testing

The program compiles without warning with `gcc -ansi -Wall`.
`lint` also seems to like the code.  This must be a bug in `lint`.

The program was tested on Linux on a x86 and NetBSD on an alpha.
Only gcc was tested for compilers (4.0.3 and 3.3.3).


### Entry originality

In looking through past winning entries, there seem to be only 2 (92 and 94) that
generated fractals.  Both of those were [Julia
fractals](https://en.wikipedia.org/wiki/Julia_set) from the [Mandelbrot
set](https://en.wikipedia.org/wiki/Mandelbrot_set). Those do make for some
pretty pictures.  I figured it would be nice to add some more fractals to the
IOCCC, since one hasn't won since 1994.

Instead of something that has already won I figured I would go with
another kind of fractal, those from the IFS:
[Iterated Function System](https://en.wikipedia.org/wiki/Iterated_function_system).


### Input File

The format of the input file is as follows:

```
    <num ifs> <x min> <y min> <x max> <y max>
    <a> <b> <c> <d> <e> <f> <p>
    <a> <b> <c> <d> <e> <f> <p>
    <a> <b> <c> <d> <e> <f> <p>
    .
    .
    .
```

This file describe an IFS.

One of the most well known would be the [Sierpinski Gasket](%%REPO_URL%%/2006/stewart/gasket):

```
    3 0 0 1 1
    .5 0 0 .5   0    0 .33
    .5 0 0 .5  .5    0 .33
    .5 0 0 .5 .25 .433 .34
```

or the [fern](%%REPO_URL%%/2006/stewart/fern):

```
    4 -5.5 0 5.5 11
    0    0    0  .16   0    0  .01
    .85  .04 -.04  .85   0  1.6  .85
    .2 -.26  .23  .22   0  1.6  .07
    -.15  .28  .26  .24   0  .44  .07
```

etc...

Included in my submission will be a tarball of some IFS files,
including one that attempts (not very well) to mimic the IOCCC logo
(I figure it can't hurt to attempt to suck up, right?).

(**NOTE from Judges**: we extracted the files.)

I would try to explain how to create an IFS file but I am not smart
enough to condense it down to something that is coherent.

Basically the break down is:

`num` is the number of equations in the `IFS`.
`x` (min, max) and `y` (min, max) define the ranges that will be displayed
in the XBM image file.

The `a b c d e f` are used to iterative find points that lie in the IFS
from the algorithm

```
    x = a * prevx + b * prevy + e;
    y = c * prevx + d * prevy + f;
```

The `p` is for the probability that the equation will run.


### Obfuscations

The main obfuscation is using a `void *` as my only variable (aside from
the args for `main()`).  This causes me to do much casting and pointer
arithmetic to get the correct location and completely does away with
any meaning the variables could have.  This also makes the code more
convenient to read in the current form vs preprocessed.  After
preprocessing there will be almost 300 casts in the code and I believe
they are all needed...  (I would double check but my brain is kinda
mushy right now from chasing down a segfault in the code.)

The other main obfuscation being that it generates an `IFS`.  Which isn't
all that common for a program to do.  I mean google only has something
like 66,000 hits for "Iterated function system" so that means it is
obscure, right?


### Some other minor obfuscations

Since I formatted it as a "normal" program I did inject something that
on first glance will looks like a possible bug.  (When you run it through
a C-beautifier this will be removed.)

I decided not to use `rand()` to generate a pseudo-random number.  Instead
I use XOR and bit shifting.

The input file is used to make the program flexible and to allow it to
generate many different `IFS`s.  This has the added bonus of hiding
information about the algorithm.

The use of many magic numbers.  I figured if I get yelled about them in
a review they must be bad, right?


### Silly things

The use of decimal numbers where one would expect hex.  Octal numbers
where one would expect decimal.  Shifts instead of divides.

Using xbm as the output format.  This might confuse someone who doesn't
have an X background.  It happens to be easy but is probably a very bad
choice from a file size standpoint.  1024x1024 image is 641k in size.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
