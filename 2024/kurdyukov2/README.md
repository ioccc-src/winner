## Award presentation:

Watch the following [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse) YouTube show:

> [IOCCC28 - 2024/kurdyukov2 - Prize in art restoration](https://www.youtube.com/watch?v=dWxRYHTPQPE)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog < input.jpg > output.jpg
    # where the quality of input.jpg is less than 100
```


## Try:

Using your favorite image viewing tool, look at `gradient.png` (the original),
`quality24.jpg`, and `restored.jpg`. The difference is noticeable but subtle.
To see it in detail, observe `diff-histeq.png`.

``` <!---sh-->
    ./try.sh
```


## Alternate code:

If you have the `jpegint.h` include file from the **libjpeg** package,
then you will be able to compile the alternate code.


### Alternate build:

``` <!---sh-->
    make alt
```

**NOTE**: The above requires the `jpegint.h` include file.


### Alternate use:

``` <!---sh-->
    ./prog.alt < input.jpg > output.jpg
    # where the quality of input.jpg is less than 100
```


## Judges' remarks:

We were able to guess the meaning of some magic numbers. Can you?


## Author's remarks:


### JPEG artifact removal

This program removes compression artifacts from JPEG images using values from quantization tables. After completing its work, the program saves the image in a another JPEG file, but as saved with 100% quality (so output file is larger).


### Notes

1. The lost precision of the DCT coefficient values cannot be gotten out of nowhere. It's an attempt to find values within possible ranges (defined by the quantization table), which will allow to produce smoother-looking image.

2. If the image is saved several times with different quantization tables, the artifacts cannot be reduced, since the true range of possible coefficient values isn't known. If you save with one quality (say 50%) and then with 100%, this code will do nothing.

3. Don't expect great results from images saved with extremely low quality (less than 25%). May look blurry.

4. I written the code with respect of bits per sample set by libjpeg includes, but doesn't test on something different than common 8 bits.


### Alternative versions

- `prog.alt.c` uses **libjpeg** internals, which are the inverse of a DCT function that may run faster. Works with many *libjpeg* distributions.

- I reduced the code even more, by a hijacking `main()` with file I/O from the `jpegtran` utility that comes with *libjpeg*. You can see this version in `prog.nomain.c`. As a useful side effect, you can use command line options comes from this tool, like: `./prog -optimize -outfile output.jpg input.jpg`. But for that you must build the program with *libjpeg* sources.


### Extra notes

This is an obfuscated version of [JPEG Quant Smooth](https://github.com/ilyakurdyukov/jpeg-quantsmooth).
The full version is heavily optimized using SIMD/OpenMP and has chroma scaling feature.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
