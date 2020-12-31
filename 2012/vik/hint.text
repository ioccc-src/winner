# Best use of cocoa - Bronze award

Daniel Vik  
<daniel@vik.cc>  
<http://danielvik.com/>  


## Judges' comments:
### To build:

    make vik

This entry requires [Zlib](http://www.zlib.net/).

### To run:

#### Embed text (from file or command line):

    ./vik e base.png filename > encodedimg.png
    # or
    ./vik e base.png SomeRandomText > encodedimg.png

#### Extract the embedded text:

    ./vik d encodedimg.png

#### Embed a PNG into another

    ./vik e base.png source.png > encodedimg.png

#### Extract the embedded PNG:

    ./vik d encodedimg.png > restored.png

### Try:

    ./vik e ioccc.png chocolate.png > chocolate-in-ioccc.png
    ./vik e chocolate.png ioccc.png > ioccc-in-chocolate.png
    ./vik d chocolate-in-ioccc.png > restored-chocolate.png
    ./vik d ioccc-in-chocolate.png > restored-ioccc.png

### Selected Judges Remarks:

References to chocolate had no effect on judging this entry. We
guarantee it.

Can you discern hidden pieces of chocolate in chocolate-in-ioccc.png ?


## Author's comments:
Introduction
------------

This program is a  steganography application for embedding an image or text
into another image as well as extracting  the embedded image  or text back.
The program stores  the embedded  image or text in  the low bits of the RGB
values.

The program supports any 8 bit true color PNG images (RGB, RGBA, grayscale,
and grayscale+alpha). The output image is always 8 bit RGB.  When embedding
one image into another, the width and height needs to be the same.

The program only updates the IDAT and IHDR chunks of the source image.  Any
additional chunks are copied into the resulting image.

### Bonus Extractor:

For some reason the chocolate image seems to have some  special properties.
Apart from  being quite big  and a little bit noisy,  it appears  that when
embedded into  another image and extracted, the bitmap data is also a valid
brain$#@$ program. It is of course possible to get the bitmap data from the
extracted image, and run it through  any of the previous  winning brain$#@$
interpreters, but I thought it would be easier to include an interpreter in
the program  to avoid the hassle:

    ./vik e ioccc.png chocolate.png > encodedimg.png
    ./vik b encodedimg.png

It is of course also possible  to embed a brain$#@$ program  as a text file
(as explained above) and decode it, e.g.:

    ./vik e ioccc.png .+[.+] > encodedimg.png
    ./vik b encodedimg.png


### Obfuscation

I really wanted to keep  the program simple,  so instead of adding multiple
macros or helper methods that can be confusing,  I placed all functionality
in the main function. Main is called recursively and quite extensively, but
it gives  the benefit  that all  invocations of  the function  has the same
parameters, argv and argc.   This really helps readability, as a programmer
doesn’t need to remember several variable or function names.   I also tried
to reduce the number of keywords,  and the program only  has four for-loops
followed by a single return statement.  There is a little bit of use of the
question mark operator,   but this is really  there to keep  the program as
simple as possible.


### Portability

The program is portable to most platforms that  have zlib  available.   The
only system dependency is that the program relies on writing binary data to
stdout.

By default, Microsoft compilers adds carriage returns to new lines,  and to
compile the program on this platform, the following line can be added after
the  variable  declarations  in  the  main  declaration  in  order  to  run
correctly:

    _setmode(_fileno(stdout), 0x8000);


### Limitations

The program doesn’t have many error checks so passing in  invalid arguments
or images of mismatching sizes, or unsupported pixel formats will cause the
program to crash.


### Extendability

Since a lot of care was taken to keep the code simple,  it turned out to be
quite easy to extend functionality. I did include a small brain$#@$ after I
realized that the chocolate image had some interesting properties.

But there  is more functionality  I added that didn’t  fit within  the size
limits and could not remain included.   For example,  I added  a method  to
format source code based on a PNG image.   So the format  of the program is
actually done by the program itself.

And to be honest,   the chocolate  image  did not have  a brain$#@$ program
embedded to begin with.   I added functionality to the  program to  embed a
brain$#@$  into a  PNG image and used it  to create the image provided with
the entry.

I also added a method to analyze PNG images,  to print the size and format,
as well as the scan line filters.

All these features  were quite easy to add,   much thanks to  the (actually
pretty good) design of the code.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
