## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    make check
```

You'll need to have both [Ruby](https://www.ruby-lang.org) and
[ImageMagick](https://imagemagick.org/) installed to run all the automated
checks.

If you do not have both, however, you can still do the below in the [try](#try)
section to enjoy the entry. The [Makefile](%%REPO_URL%%/2013/endoh2/Makefile) `check` rule will check if
you have both and if either is not found it will report it and tell you where to
download one or both before exiting.


## Try:

``` <!---sh-->
    less jpeg.c
```

Next look at `jpeg.jpg` in an image viewer program.


## Judges' remarks:

This is a program which, when fed its own source, generates a program that
almost is its whitespace inverse, which, in its order, generates a JPEG file
(speaking of file size abuse, that is about 16.4 times larger than a PBM file
with the same image, but the source was also abusing the size counting
program...)

Don't pay attention to the OCR ~~behind the ruby curtain~~ --- it's a
straightforward bitmap comparison.


## Author's remarks:

### Highlights

* LZ77-like compression for font and template data
* tiny JPEG encoder
    * Zig-zag space-filling curve
    * Discrete cosine transform
    * JPEG Huffman encoding (cheating)


### Notes

I picked JPEG instead of PNG, GIF, or BMP
because it is the most difficult to generate.
I believe that the JPEG encoder is the world's smallest ever.

Nevertheless, the program was too big to meet the IOCCC's size rule.  So I
created a smaller bootstrap program that generates the main program.  `endoh2.c`
contains fragments of the main program *as a comment* which `iocccsize -i` does
*not* count.  I gratefully thank the judges for deobfuscating the size rule this
year.

I think the program will work on any major platforms and compilers.


### Legal

This program uses (a part of) Proggy Tiny Fonts
which is distributed in MIT License:

```
    Copyright (c) 2004, 2005 Tristan Grimmer

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
```


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
