# Best of show

Adrian Cable  
<adrian.cable@gmail.com>  


## Judges' comments:
### To build:

    make cable2

### To run:

    ./cable2 file.bmp [color]

### Try:

Extract example-images.tbz2:

    make data

Here is an OCR example that shows all 94 supported ASCII characters:

    ./cable2 ascii.bmp

Here is an example of colored ASCII:

    ./cable2 multi_color.bmp color

Here is an example using different character sizes and different
positions in the same file:

    ./cable2 mixed_sizes.bmp

How about about hand-written C code:

    ./cable2 hello_world.bmp | gcc -xc -o hello -
    ./hello

Sometimes typeset text will work, if the typeset has characters that
are enough to the supported handwritten shapes.  For example,
Menlo, 160 pt:

    ./cable2 typeset.bmp

And as an added IOCCC bonus: :-)

    ./cable2 bonus.bmp

### Selected Judges Remarks:

We can confirm that this is the first time the IOCCC has been used
to peer-review a new research. We had quite a bit of fun with a sharpie and a
scanner.

## Author's comments:
OCR - Obfuscated Character Recognition of Handwritten Text
==========================================================

This entry takes a BMP image file of hand-drawn (mouse-drawn?) text, specified as the first command-line parameter, and converts it to an ASCII text document. Magic!

BMP files created by most paint programs should work. The author recommends Paint.NET.

Features
--------

- Every printable ASCII character is recognized (94 characters plus space), plus a special bonus character.
- Input images can be any size (limited only by memory), containing any number of lines of text.
- BMP is really a mess of different formats, but the program supports most of them from Windows 3.1 and later.
- Hand-drawn characters in the input image can be variably spaced and positioned and be of any width or height, but the bigger the better for accurate recognition (300 pixels tall or more is recommended). Characters must be drawn with a stroke width of around 9 pixels, and separated from adjacent characters. (In Paint.NET a brush of width 9 works well, with anti-aliasing turned off.)
- You can use any colors you like for the text and background, even different colors for different text characters.
- If "color" is specified as the second command line parameter, the program's output will also be in color, on ANSI/VTxxx terminals.

Why is this entry obfuscated/interesting?
-----------------------------------------

- The source is presented as a beautiful moonlit scene, in which a quick brown fox jumps over a lazy dog. Far too often in software development is aesthetic nuance lost in the name of serious-sounding conventions like "GNU style", but not here.
- Newcomers to C find it hard to learn all those different ways to control flow: for, while, if, do, goto, continue, break and heaven knows what else! So, in this program we only use for, so absolute beginners can get into the code straight away.
- To teach newcomers all the important features of C, we demonstrate the importance of the liberal use of short circuits, sequence points, the ternary operator, using x^y or x-y instead of x!=y, using ~x in place of x!=-1 for conciseness, mixing x[y] and y[x] for variety, educational #define's, and so on.
- main is the most useful function in all of C - so it is a mystery to the author why most programs use it only once. Here we use it over and over for maximum benefit.
- The number 42 is featured in the source to provide an answer to the judges' deeper questions.
- How are character colors converted from RGB in the input image to ANSI escape sequences? Clue: the weird macro P does the interesting part of it, but how?
- The program prints a string when the bonus character is detected. How does it do this? Clue: the string to print is defined in the macro $, but how can a string defined in that way ever get printed?

Other notes
-----------

- The novel character recognition algorithm used has not been previously published and was developed by the author specifically for the contest. Should this entry win the IOCCC, it will be the first time (to the author's knowledge) that the IOCCC has been used for peer review/publication of original research.
- OCR in general is a hard problem. Here, we only recognise one possible form for each character. You can see what the supported character shapes look like by looking at the examples in ascii.bmp. If you copy the shape of the character forms you find in there, recognition accuracy should be very good (95%+). A more "useful" version would extend the character stroke table to support multiple different commonly-used forms for each character.
- Despite being the largest possible IOCCC entry at 4096 bytes, it is also probably the smallest general-purpose OCR program ever written (including the character stroke data), maybe by several orders of magnitude.
- The author used an interesting compression algorithm (suggested by Gareth McCaughan - thank you!) to squeeze the character stroke table (containing around 2000 strokes for the whole ASCII character set) into a string constant of just 472 characters.

Bugs/features
-------------

- The width of input images must be a multiple of 4.
- Input images can be 8-bit grayscale, 24-bit color or 32-bit color only. 8-bit color and 16-bit color are not supported. If you use the "color" command-line feature, do not use a grayscale input file!
- Normal Windows BMP files are stored "upside-down", i.e. the bottom line in the image is written first. Some (old) graphics programs actually write BMP files "top-to-bottom" and the program does not support such files.
- Using antialiased brush strokes to draw your letters is fine, however, antialiasing interferes with color detection in "color" mode.
- Only runs on little endian machines (since the BMP format is little endian, and endianness conversion would make the source too large for IOCCC rule 2).

Compiler warnings
-----------------

clang warns about unused expression results, missing type specifiers, and incompatible pointer conversions - all just a fun consequence of the obfuscations.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
