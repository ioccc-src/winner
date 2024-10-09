## To build:

``` <!---sh-->
    make
```

This entry requires [Zlib](https://www.zlib.net).

There is an alternate version which might work for Windows. See [Alternate
code](#alternate-code) section below.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2012/vik in bugs.html](../../bugs.html#2012_vik).


## To use:

To embed text (from file or command line):

``` <!---sh-->
    ./vik e base.png filename > encodedimg.png
```

or

``` <!---sh-->
    ./vik e base.png SomeRandomText > encodedimg.png
```

To extract the embedded text:

``` <!---sh-->
    ./vik d encodedimg.png
```

To embed a PNG into another:

``` <!---sh-->
    ./vik e base.png source.png > encodedimg.png
```

To extract the embedded PNG:

``` <!---sh-->
    ./vik d encodedimg.png > restored.png
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

For those few who might use Windows this alternate code might work.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `vik.alt` as you would `vik` above.


## Judges' remarks:

References to chocolate had no effect on judging this entry. We
guarantee it.

Can you discern hidden pieces of chocolate in:

<img src="chocolate.png"
 alt="image of peices of chocolate candy"
 width=300 height=110>


## Author's remarks:

### Introduction

This program is a [steganography](https://en.wikipedia.org/wiki/Steganography)
application for embedding an image or text into another image as well as
extracting the embedded image or text back.  The program stores the embedded
image or text in the low bits of the RGB values.

The program supports any 8 bit true color PNG images (RGB, RGBA, greyscale,
and greyscale+alpha). The output image is always 8 bit RGB. When embedding
one image into another, the width and height needs to be the same.

The program only updates the `IDAT` and `IHDR` chunks of the source image. Any
additional chunks are copied into the resulting image.


### Bonus Extractor:

For some reason the chocolate image seems to have some special properties.
Apart from being quite big and a little bit noisy, it appears that when embedded
into another image and extracted, the bitmap data is also a valid
[brainfuck](https://en.wikipedia.org/wiki/Brainfuck) program. It is of course
possible to get the bitmap data from the extracted image, and run it through any
of the previous winning brainfuck interpreters, but I thought it would be easier
to include an interpreter in the program to avoid the hassle:

``` <!---sh-->
    ./vik e ioccc.png chocolate.png > encodedimg.png
    ./vik b encodedimg.png
```

It is of course also possible to embed a
[brainfuck](https://en.wikipedia.org/wiki/Brainfuck) program as a text file
(as explained above) and decode it, e.g.:

``` <!---sh-->
    ./vik e ioccc.png .+[.+] > encodedimg.png
    ./vik b encodedimg.png
```

### Obfuscation

I really wanted to keep the program simple, so instead of adding multiple macros
or helper methods that can be confusing, I placed all functionality in the
`main()` function. `main()` is called recursively and quite extensively, but it
gives the benefit that all invocations of the function have the same parameters,
`argv` and `argc`. This really helps readability, as a programmer doesn't need
to remember several variable or function names. I also tried to reduce the
number of keywords, and the program only has four `for` loops followed by a single
`return` statement. There is a little bit of use of the ternary (`?:`) operator,
but this is really there to keep the program as simple as possible.


### Portability

The program is portable to most platforms that have [zlib](https://www.zlib.net)
available. The only system dependency is that the program relies on writing
binary data to `stdout`.

By default, Microsoft compilers adds carriage returns to new lines, and to
compile the program on this platform, the following line can be added after
the variable declarations in the main declaration in order to run
correctly:

``` <!---c-->
    _setmode(_fileno(stdout), 0x8000);
```

**NOTE**: this is what the [Alternate code](#alternate-code) does.


### Limitations

The program doesn't have many error checks so passing in invalid arguments
or images of mismatching sizes, or unsupported pixel formats will cause the
program to crash.


### Extendability

Since a lot of care was taken to keep the code simple, it turned out to be
quite easy to extend functionality. I did include a small
[brainfuck](https://en.wikipedia.org/wiki/Brainfuck) after I
realized that the chocolate image had some interesting properties.

But there is more functionality I added that didn't fit within the size
limits and could not remain included. For example, I added a method to
format source code based on a PNG image. So the format of the program is
actually done by the program itself.

And to be honest, the chocolate image did not have a
[brainfuck](https://en.wikipedia.org/wiki/Brainfuck) program
embedded to begin with. I added functionality to the program to embed a
brainfuck into a PNG image and used it to create the image provided with
the entry.

I also added a method to analyze PNG images, to print the size and format,
as well as the scan line filters.

All these features were quite easy to add, much thanks to the (actually
pretty good) design of the code.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
