Best Output:

	Ian Collier
	Oxford University
	The Queen's College
	High Street
	OXFORD
	OX1 4AW
	ENGLAND


Judges' comments:

    Make and run.

    The program is more interesting to run on workstations that can
    make use of a Sun raster file.  Others can make use of the -text
    flag for character oriented output.

    Of course, the source (layout) is self-documenting!  :-)

    NOTE: The original winning source imc.orig.c assumed that
	  exit returned a value which cause problems for some
	  systems where exit returned a void.  The file imc.c
	  avoids this problem.


Selected notes from the author:

    Portability

    This program depends upon the ASCII character set, and makes certain
    assumptions about the architecture. It naughtily declares the first
    argument to main as a long, and passes a pointer to long instead of char
    to fwrite, giving a length value of 32 bytes for an array of 8 longs. I
    guess that makes this program OK on most flavours of unix, but not on
    PCs.

    About the program

    This program has several parameters; each of them has a default, so the
    program runs happily without any parameters. If you supply an incorrect
    parameter, an obfuscated error message results! :-) Should you want to
    run the program without knowing what it does, then supplying the single
    letter t as a parameter is a good move. Otherwise, direct the output
    into a file. The resulting file is most useful on Sun OS, where the
    "file" command will tell you what to do with it. For best results with
    the t option, you may want to change the definition of the I macro :-)
    Details appear later, though the formatting of the code is a large clue.

    All the code in this program appears between the ";" and ")" in
    "for(;;)". That isn't because I want to win the best one-liner, but
    merely because it makes the code so much more impenetrable :-) In fact
    running a pretty printer on the code hardly improves it at all. This
    program has the obligatory macros with unmatched parentheses, and the
    cleverly arranged macro names and parameters to spell out "Ian Colliers
    Obfuscated C Code". If you expand macros, bear in mind that the more
    complex ones are best left as macros, because they have well-defined and
    nontrivial (IMHO) functions. These macros help to give the program's
    parameter format its flexibility. The parameters are sorted out in a
    unique way (based on an idea by Pete Bevin) which hides very effectively
    their identities (and I think that using a variable called _ adds a nice
    touch to the illegibility of the code). In this section of the code, the
    data types of the numbers checked against is varied, and just because
    you see a ',' doesn't mean it has anything to do with commas! So I hope
    you will agree that this program is more than a little obfuscated...

    This is a Mandelbrot/Julia drawer. Normally it produces a monochrome
    Sun-format raster file. The version of xloadimage we have is able to
    view such files, and so is Sun's screenload command. [Note: the header
    contains eight 4-byte integers, the byte order in which depends upon the
    machine. On Sun workstations they are stored MSB first].

    The program may be asked to produce text output instead of a raster
    file. Then the characters defined in the I macro will be used to create
    up to 16 different shades of grey. Quite a respectable picture can be
    gained by printing a 130x110 output on a dot matrix 132 column printer
    with the linefeed set to 7 points. Text output also gives a good picture
    when used in an X window with small characters having a square aspect
    ratio.

    The options accepted by the program follow. Each option is a letter; it
    may be preceded with a minus sign (or any character in [!-/]) and may be
    followed by other letters, so for example
          m    -m     mask     *mail
    all mean the same thing. Most options may be followed by one or two
    numbers. These numbers may be separated from each other and from the
    option by a space, or may be joined to each other with a comma, or may
    be appended to the single-letter option, so
          -s100,200    size 100,200    -size123 100 200  s100 200
    all mean the same (note that in "-size123" all characters following the
    initial s are ignored). Numbers need not be specified, as each has a
    default value. In all cases except "j" and "t", and "s" whenever it
    appears before "t", specifying an option without numbers has no effect.
    (specifying "-s -t" has the effect of producing text with the default
    raster size; not a good idea!). The options are:

    -centre x y  (float x,y) Centre the picture at x+iy in the complex
                             plane (default x=0 y=0)
    -factor f    (float f)   Use f pixels per unit of the plane (default
                             f=x/4 where x is the width)
    -julia  x y  (float x,y) Draw a julia set. Use x+iy as the constant
                             to add after squaring (default x=0 y=0)
    -limit  l    (int l)     Use l iterations maximum (default l=128)
    -mask   m    (int m)     Use m as a mask in deciding the colour of each
                             pixel (see below) (default m=1)
    -size   x y  (int x,y)   Produce an x-by-y output (default for raster
                             x=768 y=768; default for text x=63 y=23)
    -text                    Produce text instead of raster.

    The colour of each point is determined by taking the bit-and of the
    number of iterations and the mask. For a raster, the point is black
    (1-bit) if the result is zero, white otherwise. For text, the result of
    the operation determines the grey-ness of the character produced, with a
    blank for zero going up to a star for the maximum value. For a
    four-colour picture, for example, use a mask with two bits set (e.g. 3),
    and for a 16-colour picture use a mask with four bits set (e.g. 15). For
    a picture with coarse detail, use a mask which ends with several zero
    bits (e.g. 8).

    While the program is creating your picture, it displays dots on the
    standard error to indicate its progess (one dot per pixel line).

    Here are a couple of good pictures to draw:

    imc -s 512,512 -f 600000 -l 512 -m 16 -c.00805,.74274 > screen1.ras
    imc -s512,512 -j-.523,-.535 > screen2.ras

Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
