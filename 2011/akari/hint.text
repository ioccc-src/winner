# Best of Show - Most Shrinkable

Don Yang  
<omoikane@uguu.org>  
<http://uguu.org/>  


## Judges' comments:
### To build:

    make akari

### To run:

    ./akari [input_file_or_- [output_file_or_- [even]]]

### Try:

    ./akari < example.ppm > odd_output.ppm
    ./akari - - even < example.ppm > even_output.ppm
    ./akari example.ppm odd_output.ppm

    make akari2.c
    cat akari2.c

    make akari2

    ./akari2 < akari2.c
    ./akari2 rot13 < akari2.c

    make akari3.c
    cat akari3.c

    make akari3

    ./akari3

    make akari4.c
    cat akari4.c

    ./akari4

### Selected Judges Remarks:

Akari is an image downsampling utility that accepts 3 inout formats:

    * PGM (netpbm grayscale image).  Akari only accept PGM files with this
      header: P5 <width> <height> 255.  Images with extra comments such as
      the ones produced by GIMP will not be parsed properly.

    * PPM (netpbm RGB image).  Only PPM files with this header are
      accepted: P6 <width> <height> 255.

    * ASCII art (with end of lines in LF bytes only, not CR-LF)

Anything that is not parseable as PGM or PPM will be downsampled as ASCII art.

## Author's comments:
Akari is an image downsampling utility.  She accepts up to 3 arguments:

First argument is the input image.  If it's "-" or unspecified, Akari
will read from stdin.

Second argument is the output image.  If it's "-" or unspecified,
Akari will write to stdout.

Third argument, if specified, causes Akari to keep even pixels on even
scanlines.  By default Akari will keep odd pixels on odd scanlines.

Examples:

    gcc akari.c -o akari
    ./akari < example.ppm > odd_output.ppm
    ./akari - - even < example.ppm > even_output.ppm
    ./akari example.ppm odd_output.ppm

Akari accepts 3 input formats:
* PGM (netpbm grayscale image).  Akari only accept PGM files with this
  header: P5 <width> <height> 255.  Images with extra comments such as
  the ones produced by GIMP will not be parsed properly.
* PPM (netpbm RGB image).  Only PPM files with this header are
  accepted: P6 <width> <height> 255.
* ASCII art (with end of lines in LF bytes only, not CR-LF)

This is useful for decoding some curiously interlaced images, such as
the included example.ppm

Anything that is not parseable as PGM or PPM will be downsampled as
ASCII art.  Since the source code is formatted as ASCII art, it's only
natural to try:

    ./akari akari.c akari2.c

akari2.c is also a valid C program, and accepts up to 1 argument.
By default, this second program reads text from stdin and writes
expanded output to stdout.  If the extra argument is specified, the
output text will also pass through a rot13 filter.

    gcc akari2.c -o akari2
    ./akari2 < input.txt > expanded_output.txt
    ./akari2 rot13 < input.txt > expanded_and_rot13_output.txt

You can combine the two programs together to have just a regular rot13
filter:

    ./akari2 rot13 < input.txt | ./akari > rot13.txt

Of course, we wouldn't stop with just 2 programs, you can downsample
the source *again* and get yet another C program:

    ./akari < akari.c | ./akari > akari3.c

We must go deeper:

    ./akari < akari.c | ./akari | ./akari > akari4.c

akari3.c and akari4.c are still (mostly valid) C programs.
"gcc -Wall" will output a few warnings, but still produce output
executables.  The output executables each print a message to stdout.

It takes quite a bit of skill and obfuscation to interleave a
C program 4 levels deep, it's much easier to interleave something like
a brainf#$% program in a C program, for example.  For comparison, a
brainf#$% program is embedded inside akari.c

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
