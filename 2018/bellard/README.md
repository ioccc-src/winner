# Most inflationary

Fabrice Bellard  
<https://bellard.org/>  


## Judges' comments:
### To use:

    make
    ./prog > lena.ppm

### Try:

    eog lena.ppm # On Linux
    preview lena.ppm # On MacOS

    wget http://upload.wikimedia.org/wikipedia/en/2/24/Lenna.png
    pngtopnm < Lenna.png | pnmscale 0.25 | cjpeg -arithmetic -dct float -quality 14 > small.jpg

The file `small.jpg` will be approximately of the same size as the raw image data
in the program. Compare the level of the detail and the artifacts of
`small.jpg` and `lena.ppm`.

### Selected Judges Remarks:

Compressing images is just a matter of simple arithmetic and some magic, isn't it?

We could understand some of the arithmetic but none of the magic.

Deciphering the mechanism used for data encoding to make use
of the whitespaces, braces and semicolons should be a slightly easier task.


## Author's comments:
This program outputs a 128x128 RGB image file to the standard output
using the portable pixmap file format (PPM). It contains the famous
"Lena" image which is used in many image compression tests. 

The uncompressed image is 12 times larger than the source code of the
program which includes the image data and the complete decoder. The
actual image data is 1220 byte long, which gives a compression ratio
of 40. Using a JPEG-like algorithm would not be enough to reach this
level of compression (the Lena image would be barely recognizable). So
the algorithm is based on the latest advances in image compression. It
includes the following features:

- DCT transform with variable block size (4x4, 8x8, 16x16 and 32x32)
- DC and directional predictors
- arithmetic coding
- YCgCo color space.

The image data is encoded to a C string with some tricks to make the
best use of the IOCCC size constraints. The identifiers were shortened
to a single letter to save space. No specific obfuscation was needed
as the algorithms already have a significant complexity.

Although the program was optimized to decompress its built-in image,
it accepts to decompress image files from its standard
input. Examples:
  
    ./prog d < lena512.bin > lena512.ppm
    ./prog d < fruits.bin > fruits.ppm
    ./prog d < vintage_cars.bin > vintage_cars.ppm

The original images for [fruits][1] and [vintage cars][2] come from
Wikipedia and were resized to a width of 1024 pixels. Warning: the
program is not protected against invalid input.

The program should be portable on any Unix system. On Windows the line
"_setmode(0, 32768); _setmode(1, 32768);" must be added at the start of
the main() function to avoid unwanted carriage return characters in
the output.

--------------------------------------------------------------------------------

[1]: https://commons.wikimedia.org/wiki/File%3AFruits_oranges%2C_jardin_japonais_2.JPG
[2]: https://commons.wikimedia.org/wiki/File%3ARed_Bull_Jungfrau_Stafette%2C_10th_stage_-_vintage_cars_%282%29.jpg

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
