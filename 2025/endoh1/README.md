## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC29 - 2025/endoh1 - Most likely to dazzle](https://www.youtube.com/watch?v=69ZIkdzVHLk)


## To build:

``` <!---sh-->
    make all
```


## Try:

``` <!---sh-->
    ./try.sh

    ./timer.sh 15

    ./clock.sh
```


## Alternate code:

The [2025/endoh1/prog.alt.c](%%REPO_URL%%/2025/endoh1/prog.alt.c) is C code "identical" to
[2025/endoh1/prog.c](%%REPO_URL%%/2025/endoh1/prog.c) with the simple addition of trailing
whitespace to make each line of source 42 characters wide.  I.e., this prints nothing:

``` <!---sh-->
    diff -w prog.c prog.alt.c
```


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

To best appreciate this interesting IOCCC winner, it helps to be familiar
with [Nixie tubes](https://en.wikipedia.org/wiki/Nixie_tube).

Look at the [2025/endoh1/prog.c source
code](%%REPO_URL%%/2025/endoh1/prog.c).  What else lies below the
surface of the source code?  That is a significant challenge, even if you
[clang-format](https://commandmasters.com/commands/clang-format-common/)
to view the code.

Running the [2025/endoh1/try.sh shell script](%%REPO_URL%%/2025/endoh1/try.sh)
may give your a hint.  :-)


### A fun challenge

Please checkout the [fun challenge&lpar;s&rpar;](../challenge.html#endoh1) for this winning entry.


## Author's remarks:

This program selectively illuminates specified characters within a text stream.

Assuming you possess a terminal capable of rendering 256 colors, compile and run it as follows:

``` <!---sh-->
    make
    ./prog X < some-file
```

You will observe that every 'X' is now glowing -- not merely highlighted,
but radiating a warm bloom that fades into the surrounding darkness,
much like a heated filament.

You may also specify multiple characters simultaneously, should a single
glowing letter be insufficient for your needs.

Consider as a suitable "some-file", the contents of [2025/endoh1/prog.c](%%REPO_URL%%/2025/endoh1/prog.c):

``` <!---sh-->
    ./prog CIO < prog.c
    ./prog 025 < prog.c
```

This program is heavily inspired by the [Nixie tube](https://en.wikipedia.org/wiki/Nixie_tube).

A real Nixie tube is a glass envelope containing ten wire-mesh cathodes,
each shaped like a digit 0 through 9, all stacked inside a single
tube. When voltage is applied to one cathode, that digit alone glows in
neon orange while the others remain dark.

Naturally, the source code itself is shaped like one. At the top sits a
rounded glass bulb, labeled "IOCCC" with "MMXXV" stamped below it like a
manufacturer's date code. At the bottom, a row of pins extends downward,
ready to be socketed into a circuit board.

And it is not merely decorative -- it actually functions as one. All
ten digit shapes are layered within the same glass tube of C code. Try
feeding the source to itself:

``` <!---sh-->
    ./prog 0 < prog.c
    ./prog 1 < prog.c
    ./prog 2 < prog.c
    ...
    ./prog 9 < prog.c
```

Each digit (0-9) within the code is strategically placed so that,
when illuminated, the glowing characters form the exact shape of the
requested number.

You can even light up all cathodes at once, just as a Nixie tube is
tested before shipping:

``` <!---sh-->
    ./prog 0123456789 < prog.c
```

To achieve this effect, the source code had to be written under severe
typographic constraints. Every numeric literal in the program serves
double duty: it must evaluate to the correct value for the computation,
and it must sit at the precise position required to draw its own shape.


### Caveats

* The maximum width and height of the input text must be strictly less than `9*8+20*24/12*20-2-8*93`. For a perfectly clear explanation of this threshold, please refer to Line 9 of the source code.
* This program makes the bold assumption that you are using ASCII. Do not attempt to run it on an EBCDIC platform, unless you enjoy undefined behavior more than most.
* Speaking of which: behavior is undefined if the input contains anything other than a newline (10) or printable ASCII characters (32-126).


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
