## To build:

``` <!---sh-->
    make
```

There is an alternate version that should work with Windows. See [Alternate
code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./prog > lena.ppm
```


## Try:

First open [Lenna.png](Lenna.png) in your graphics viewer of choice. Next, after
running the above command (`./prog > lena.ppm`), open `lena.ppm` in your
graphics viewer of choice.  After that try:

``` <!---sh-->
    ./try.sh
```

NOTE: the script uses the tools `pngtopam(1)` (or `pngtopnm(1)` for older
versions) and `pnmscale` come from the netpbm project and `cjpeg(1)` comes from
`libjpeg-turbo`. If you don't have these tools already see [FAQ 3.15 - How do I
compile and install netpbm for entries that require it?](../../faq.html#netpbm) and
[FAQ 3.16 - How do I compile and install libjpeg-turbo for entries that require
it?](../../faq.html#libjpeg).

NOTE: [Lenna.png](Lenna.png) is from
<https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png>.


## Alternate code:

The [prog.alt.c](%%REPO_URL%%/2018/bellard/prog.alt.c) is based on the author's remarks and it should work
for Windows.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `prog.alt` as you would `prog`.


## Judges' remarks:

The file `small.jpg` will be approximately of the same size as the raw image
data in the program. Compare the level of the detail and the artifacts of
`small.jpg` and `lena.ppm`.

Compressing images is just a matter of simple arithmetic and some magic, isn't
it?

We could understand some of the arithmetic but none of the magic.

Deciphering the mechanism used for data encoding to make use of whitespace,
braces and semicolons should be a slightly easier task.


## Author's remarks:

Warning: the program is not protected against invalid input.

This program outputs a 128x128 RGB image file to the standard output using the
portable pixmap file format (PPM). It contains the famous "Lena" image which is
used in many image compression tests.

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

``` <!---sh-->
    ./prog d < lena512.bin > lena512.ppm
    ./prog d < fruits.bin > fruits.ppm
    ./prog d < vintage_cars.bin > vintage_cars.ppm
```

The original images for [fruits][1] and [vintage cars][2] come from
Wikipedia and were resized to a width of 1024 pixels.


The program should be portable on any Unix system. On Windows the line
`_setmode(0, 32768); _setmode(1, 32768);` must be added at the start of
the main() function to avoid unwanted carriage return characters in
the output.

[1]: https://commons.wikimedia.org/wiki/File%3AFruits_oranges%2C_jardin_japonais_2.JPG
[2]: https://commons.wikimedia.org/wiki/File%3ARed_Bull_Jungfrau_Stafette%2C_10th_stage_-_vintage_cars_%282%29.jpg

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
