Best Use of Light and Spheres:

    Anders Gavare
    Gibraltargatan 82-156
    SE-412 79 Gothenburg
    Sweden

    http://www.mdstud.chalmers.se/~md1gavan/


Judges' Comments:

    To build:

	make gavare

    To run:

	./gavare > ioccc_ray.ppm

    For users of systems that distinguish between text and binary mode
    (you know who you are), add a library call that specifies binary mode
    for stdout as the first statement of main(),
    or use freopen("ioccc_ray.ppm", "wb", stdout) and do not use redirection.

    A freely distributable command-line version of Microsoft Visual C
    exhibits an optimizer bug when compiling this entry. Disable /Og for
    best results.

    The judges were able to figure out how to control position
    (in all 3 coordinates), size, and color (to some extent) of the balls.


Selected Author's Comments:


    It is possible to write some kinds of programs in C without using reserved
    words.  For very short and trivial programs, it usually isn't very hard to
    write a variant using no reserved words, but with this program I want to
    show that also non-trivial programs can be written this way.  This IOCCC
    entry contains no reserved words (I don't count 'main' as a reserved word,
    although the compiler gives it special meaning) and no preprocessor
    directives.

    The program is a small ray-tracer. The first line of the source code may
    be modified if you want the resulting image to be of some other resolution
    than the predefined. The 'A' value is an anti-alias factor. Setting it to
    1 disables the anti-aliasing feature (this makes the output look bad), but
    setting it too high makes the trace take a lot more time to complete.

    The ppm image can then be viewed using an image viewer of your own choice.
    (Running the ray-tracer may take several minutes, even on fast machines,
    so be patient.)

    I am very much aware about the fact that I'm breaking the guidelines. For
    example, the word 'int' is a reserved word and therefore all variable
    declarations are implicit.  There will no doubt be _lots_ of warnings,
    no matter which compiler is used.  Still, the source code should be word-
    length-independent and endianess-independent.

    <humor>
    Another reason for writing code without using reserved words is that many
    text editors will make all reserved words turn BOLD when printed on
    paper.  Since I care for the global environment, we shouldn't waste any
    more laser toner, or ink, than necessary. Everyone should write C code
    with no  reserved words, and our world will be a better place.
    </humor>

