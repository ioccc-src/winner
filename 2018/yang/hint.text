# Most shifty

Don Yang  
<http://uguu.org/>  


## Judges' comments:
### To use:

    make
    more generated1.c
    more generated2.c
    more generated3.c

### Try:

    make
    ./left < prog.c
    ./right < prog.c
    ./left < prog.c | ./left

    ./shift < prog.c

    ./msg0
    ./msg1
    ./msg2

### Selected Judges Remarks:

Code should be readable in any direction! This tool will help you rotate your
code so you don't have to stare at it sideways or even upside down. Rotating
this program left and recompiling will reveal other tools including a right rotate
and a shift program.

Strange things happen when the world is upside down! It is entirely possible
that this is remark is completely misleading.

What exactly does the shift program do?

Like a great sliding puzzle (hint) this entry has 6 more programs that will
reveal messages and one more tool that can be used to reveal the final
message hidden in the original source.  All of these can be created using
combinations of ./left, ./right and ./shift and the additionally generated
programs.

The final message can be revealed using

    ./msg9 < prog.c

But what combinations will generate ./msg3, ./msg4, ./msg5, ./msg6, ./msg7,
./msg8 and finally ./msg9?

## Author's comments:
# Tools usage

Nuko is a text rotator: given some text in stdin, Nuko will write the
same text to stdout, but rotated 90 degrees counterclockwise.

    gcc prog.c -o left
    ./left < input.txt > rotated_counterclockwise.txt

Due to static memory allocation, only the first 1K columns by 1K rows
are rotated, the rest are silently ignored.  But fear not, a separate
tool with dynamic memory allocation is included:

    ./left < prog.c > r1.c
    gcc r1.c -o right
    ./right < input.txt > rotated_clockwise.txt

For variety, this second tool rotates clockwise instead of
counterclockwise.  Also, it can handle files larger than 1024x1024,
depending on how much memory you got.

Of course we wouldn't stop with just two rotations, if we continue to
rotate counterclockwise once more, we get another program.  This
program outputs a single message to stdout, which is the name of the
series that Nuko came from.

    ./left < prog.c | ./left > r2.c
    gcc r2.c -o msg0
    ./msg0

There is one final rotation, which produces a tool that removes
leading whitespaces:

    ./left < prog.c | ./left | ./left > r3.c
    gcc r3.c -o shift
    ./shift < input.txt > no_leading_space.txt

Where this might be useful, besides ruining the formatting of certain
files, is that it completes the set of tools needed to solve the
puzzle that is embedded in prog.c

# Puzzle box

Notice how the edges of prog.c contain two notches.  By rotating
prog.c and removing leading space, the code would be shifted one space
toward one of those notches (and creating a new notch on the other
side).  This shifted code behaves slightly different from the original
program.  For example, here are two more messages that can be
produced:

    ./shift < prog.c | ./right > msg1.c && gcc msg1.c -o msg1 && ./msg1
    ./shift < prog.c | ./left > msg2.c && gcc msg2.c -o msg2 && ./msg2

In total, there are 9 embedded strings that can be produced via a
sequence of rotates and shifts, one of which can be used to extract
the 10th final string from prog.c.  The intent is to simulate those
wooden puzzle boxes that can be opened by pushing and shifting various
well-concealed seams.  Thus, finding the correct sequence of rotates
and shifts is left as an exercise to the reader (but if you are really
lazy, just read the Makefile).

Source code for all the tools needed to solve this puzzle are embedded
in prog.c, all you need is a C compiler.

# Features

   - Code compiles when rotated 4 ways.  This required a bit of
     patience to achieve.  Code still compiles even with one column of
     text shifted.  This required even more patience.

   - All rotated and shifted variants compiles without warnings.  This
     involves various tweaks to satisfy cases where compiler is overly
     protective, including but not limited to the "1125" at line 4 as
     opposed to "1025", to satisfy -Waggresive-loop-optimizations.

   - CRC32 of the code is embedded in the code itself.

   - Process for writing prog.c is available in spoiler.html

# Compatibility

Nuko and the rotated tools accepts only ASCII files where each
character maps to exactly one byte.  Also, end-of-line sequence is
assumed to be LF only, as opposed to CR-LF.  All control characters
are treated like normal printable characters, so files containing tabs
will look weird after rotation, for example.

Nuko has been verified to work with these compiler / OS combinations:

   - gcc 4.8.4 on Linux
   - gcc 4.9.2 on Linux
   - gcc 6.1.0 on JS/Linux
   - gcc 6.3.0 on Linux
   - gcc 6.4.0 on Cygwin
   - clang 3.5.0 on Linux
   - clang 3.8.1 on Linux
   - clang 5.0.1 on Cygwin
   - tcc 0.9.25 on JS/Linux

Nuko compiles without warnings with all compilers above, even with
"-Wall -Wextra -pedantic" for gcc and clang.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
