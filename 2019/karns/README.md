# Most in need of whitespace

Joshua Karns  
Twitter: @jkarnss  


## Judges' comments:
### To use:

    make

    ./prog < textfile_that_fits_on_the_screen

### Try:

    make test

    ./prog < hint.text

### Selected Judges Remarks:

If you typically get lost in mazes, watching this program run might -- or might not, YMMV --
teach you how to find your way in a maze. The algorithm is well-known but the drawing is amazing!

Before running, make sure that your terminal can accommodate the whole file. Before running "make test",
make it about 120x40 to be safe, ensuring that you see the @ sign as well as the exclamation mark.

...Oh, and the first M in YMMV stands for "mazing".

A puzzle for the reader: Can you change the program to consider a diagonal movement as one step?

## Author's comments:
The Program
-----------
                                
This program is pretty simple! It performs a breadth  first search on the
specified graph. The graph can be any ascii text file  that has an 'at'
character, which is going to be the starting location, and a '!' character
which will be the destination.

The nodes on this graph that are spaces are connected with any directly
adjacent nodes that are also spaces. Nodes that aren't spaces are not 
connected with anything.
                                         

Compiling and Running
---------------------

This program usually compiles under both GCC and clang. Build with:

    $(CC) -std=c99 -o tbfs prog.c

where $(CC) is cc, gcc, clang, or somet other c compiler.

You can then run it with:
    cat <input file> | ./tbfs

Examples:
    ./tbfs < maze 
    ./tbfs < prog.c

Issues
-----------

- The program must be ran in a terminal that supports ANSI escape codes for
moving the cursor and changing colors.
- Segfaults happen sometimes.
- I don't know what memergy management there is, if any.
- Ths program will not compile by an ANSI C compiler: it uses for loops, and
it uses C++ style comments. It should compile cleanly using a C99 standard.
- Breadth first search is slow (and very slow on certain maps), but my A star
version of this program is too big.
- Lots of extra whitespace may be needed if you want to feed in an arbitrary
file.
- It fails to compile on GCC sometimes (according to a friend of mine, I've
not encountered this myself).
- The program could be obfuscated much further.
- The program contains some unused code and data.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
