## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./akari [ input_file | - ] [ output_file | - ]  [even]
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

`Akari` is an image downsampling utility that accepts 3 input formats:

* [PGM](https://netpbm.sourceforge.net/doc/pgm.html)
([netpbm](https://netpbm.sourceforge.net/doc/) [greyscale
image](https://en.wikipedia.org/wiki/Grayscale).  `Akari` only accepts `PGM`
files with the header: `P5 <width> <height> 255`.  Images with extra comments
_such as the ones produced by [GIMP](https://www.gimp.org) will **not be parsed
properly**_.

* [PPM](https://netpbm.sourceforge.net/doc/ppm.html) (netpbm RGB image).  Only
`PPM` files with the header `P6 <width> <height> 255` are accepted.

* [ASCII art](https://en.wikipedia.org/wiki/ASCII_art) (with [end of
lines](https://en.wikipedia.org/wiki/Newline) in LF bytes only, _**not** CR-LF_!)

Anything that is not parsable as `PGM` or `PPM` will be downsampled as ASCII art.


## Author's remarks:

`Akari` is an image downsampling utility.  She accepts up to 3 arguments:

The first argument is the input image.  If it's `-` or unspecified, `Akari`
will read from `stdin`.

The second argument is the output image.  If it's `-` or unspecified,
`Akari` will write to `stdout`.

The third argument, if specified, causes `Akari` to keep even pixels on even
[scanlines](https://en.wikipedia.org/wiki/Scan_line). By default `Akari` will
keep odd pixels on odd [scanlines](https://en.wikipedia.org/wiki/Scan_line).


### Examples:

``` <!---sh-->
    gcc akari.c -o akari
    ./akari < example.ppm > odd_output.ppm
    ./akari - - even < example.ppm > even_output.ppm
    ./akari example.ppm odd_output.ppm
```

`Akari` accepts 3 input formats:

* [PGM](https://netpbm.sourceforge.net/doc/pgm.html)
([netpbm](https://netpbm.sourceforge.net/doc/) [greyscale
image](https://en.wikipedia.org/wiki/Grayscale).  `Akari` only accepts `PGM`
files with the header: `P5 <width> <height> 255`.  Images with extra comments
such as the ones produced by [GIMP](https://www.gimp.org) will not be parsed
properly.
 [PPM](https://netpbm.sourceforge.net/doc/ppm.html) (netpbm RGB image).  Only
`PPM` files with the header `P6 <width> <height> 255` are accepted.
* ASCII art (with end of lines in LF bytes only, not CR-LF)

This is useful for decoding some curiously interlaced images, such as
the included [example.ppm](example.ppm).

Anything that is not parsable as `PGM` or `PPM` will be downsampled as
ASCII art.  Since the source code is formatted as ASCII art, it's only
natural to try:

``` <!---sh-->
    ./akari akari.c akari2.c
```

`akari2.c` is also a valid C program, and accepts up to 1 argument.
By default, this second program reads text from `stdin` and writes
expanded output to `stdout`.  If the extra argument is specified, the
output text will also pass through a rot13 filter.

``` <!---sh-->
    gcc akari2.c -o akari2
    ./akari2 < input.txt > expanded_output.txt
    ./akari2 rot13 < input.txt > expanded_and_rot13_output.txt
```

You can combine the two programs together to have just a regular rot13
filter:

``` <!---sh-->
    ./akari2 rot13 < input.txt | ./akari > rot13.txt
```

Of course, we wouldn't stop with just 2 programs, you can downsample
the source *again* and get yet another C program:

``` <!---sh-->
    ./akari < akari.c | ./akari > akari3.c
```

We must go deeper:

``` <!---sh-->
    ./akari < akari.c | ./akari | ./akari > akari4.c
```

`akari3.c` and `akari4.c` are still (mostly valid) C programs.
`gcc -Wall` will output a few warnings, but still produce output
executables.  The output executables each print a message to `stdout`.

It takes quite a bit of skill and obfuscation to interleave a
C program 4 levels deep, it's much easier to interleave something like
a `brainf#$%` program in a C program, for example.  For comparison, a
`brainf#$%` program is embedded inside [akari.c](%%REPO_URL%%/2011/akari/akari.c).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
