# Most notable and best tool

Alex Deckmyn  
<alex.deckmyn@gmail.com>  


## Judges' comments:
### To build:

    make deckmyn

### To run:

    # A shell interpreter with proper backtick interpolation is required
    ./deckmyn "`cat deckmyn.c`" "`cat musicfile.txt`" > sheetmusic.pbm

### Try:

    ./deckmyn "`cat deckmyn.c`" "`cat example_greensleeves`" > greensleeves.pbm

### Selected Judges Remarks:

The C of this entry is definitely sharp. The program cleverly uses its own
source at runtime to define the notes, time signature and accidental bitmaps.

In addition to sheet music, this program is also able, given the right input,
to generate an image of a 10-pin DIP chip (a sound processor?).

Ironically, the way this entry is called from the command line is an abuse of C Shell.
Please use Bourne-family shells to run this entry.

## Author's comments:

Example use
===========

You need the source code and example input (either one of the example files, or manual input as below) ready. And a program capable of showing .pbm bitmap format.

    ./deckmyn "`cat deckmyn.c`" "`cat example_greensleeves`" > greensleeves.pbm
    display greensleeves.pbm

    ./deckmyn "`cat deckmyn.c`" "KF m44c4 c4 g4 g4 :  a4 a4 g2 :; " > short_bass.pbm
    display short_bass.pbm

Description
===========

Every major C competition should have an entry capable of producing C major.
This is a music notation program. It produces bitmaps (.pbm) of music based on ASCII input. A full manual is added as a separate file. Some musical examples are also included.

The program is capable of printing notes, rests, (double) bar lines and accidentals on a single melodic line (multiple staves). No chords, polyphony etc.

The program expects *two command line arguments*. The first is a (very long) string that contains the complete music font. Note that it should *not* be given as a file name! The default music font is encoded in the (whitespace of the) source code deckmyn.c itself. Therefore, the first argument should be "`cat deckmyn.c`".

The second command line argument is the music itself. This is, again, a string, not a file name. All music signs are entered as tokens of exactly 3 characters. The code is very sensitive to bad spacing! So for instance, if you use a file to write the music (e.g. example\_greensleeves), you should keep in mind that newline is also a character! 


Internals
=========

To minimise the memory footprint, this program has *no variable declarations at all*, except for the arguments to main(). The only available memory space is from the command line arguments and count (argv and argc). Parts of argv are cast as integer when values under 0 or beyond 127 are expected.

The "music font" is defined by the source code itself. The first few lines are not part of the font definition, as this memory space will modified by the program. (So as required by the rules, it is only a (memory) copy of the source code that is modified.)

As there is no memory available, output is directly to stdout, byte by byte, from the top left to the bottom right pixel.


LIMITATIONS
===========

The memory locations of argv are used for various purposes. Therefore, the program name (default "deckmyn") must be *at least 4 characters long*, including possibly the path. This, along with the ending '\0', gives minimum 5 bytes of useful memory space. Otherwise, the program may attempt to write outside the string. 

The code is quite sensitive. Errors in the input can lead to strange results. The code does not read beyond the end of the music input, but that is about the only error checking available. Any input that is not according to the rules in the MANUAL, may cause errors. 

The program has no special hardware limitations or requirements, other than 8bit char (signed or unsigned) and two's complement negatives. 

The limitations of using char as counters for e.g. the number of music staves are minor. 127 staves to a page is rather a lot.


Obfuscations
============

The code has no declared variables other than the command line variables. Not even pointers (we all know how messy code can get with too many pointers!). As more than one variable needs values beyond 127, parts of the command line memory are cast as integer using a macro.

- The formatting of the code is in fact necessary, as this is the definition of the music font. It is therefore not an obfuscation.
- The use of only argv/argc as memory locations is a matter of reducing the memory footprint. Again, it is not an obfuscation.
- Calling the only remaining variables, and the two defined macros, c and C, is merely a matter of conforming to the standard WYSIWYG paradigm common in commercial notation programs (What You C is What You Get). So once again it is not an obfuscation. Anyway, it's a C coding contest, right?
- Randomly using the numerical (ASCII) value for characters is compensated for by replacing some numbers by a character representation. On average, therefore, it is not an obfuscation.
- Randomly changing the way the elements of argv are addressed is a matter of maintaining a diversified code base. It is therefore not... Oh allright.
- The actual output of the music is done by one print command including a 800+ character nested conditional expression.
- printf is also used for its return value.


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
