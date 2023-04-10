# Most in need of whitespace

Joshua Karns  
Twitter: @jkarnss  

## To build:

```sh
make
```

## To run:

```sh
./prog < textfile_that_fits_on_the_screen
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) reported that with `-O`
level > 0 this program segfaults (sometimes?). He's not sure why as it worked
fine before on the same systems tested but `-O0` appears to fix the problem in
both macOS and linux. Perhaps this is the problem that the author reported where
it sometimes segfaults but Cody did not try debugging it. Thank you Cody for
your assistance!


## Try:

```sh
./prog < README.md

./prog < prog.c

./prog < maze
```

The last two can be done in a sequence, first showing the respective files at
the terminal, like:

```sh
./demo.sh
```

## Judges' remarks:

If you typically get lost in mazes, watching this program run might -- or might
not, YMMV -- teach you how to find your way in a maze. The algorithm is
well-known but the drawing is amazing!

Before running, make sure that your terminal can accommodate the whole file.
Before running "make test", make it about 120x40 to be safe, ensuring that you
see the @ sign as well as the exclamation mark.

...Oh, and the first M in YMMV stands for "mazing".

A puzzle for the reader: Can you change the program to consider a diagonal
movement as one step?

## Author's remarks:

### The Program:
                                
This program is pretty simple! It performs a breadth first search on the
specified graph. The graph can be any ascii text file  that has an 'at'
character, which is going to be the starting location, and a '!' character
which will be the destination.

The nodes on this graph that are spaces are connected with any directly
adjacent nodes that are also spaces. Nodes that aren't spaces are not 
connected with anything.

### Compiling and Running:

This program usually compiles under both GCC and clang. Build with:

```sh
$(CC) -std=c99 -o tbfs prog.c
```

where $(CC) is cc, gcc, clang, or some other c compiler.

You can then run it with:

```sh
cat <input file> | ./tbfs
```

Examples:

```sh
./tbfs < maze 
./tbfs < prog.c
```

### Issues

- The program must be ran in a terminal that supports ANSI escape codes for
moving the cursor and changing colors.
- Segfaults happen sometimes.
- I don't know what memory management there is, if any.
- The program will not compile by an ANSI C compiler: it uses for loops, and
it uses C++ style comments. It should compile cleanly using a C99 standard.
- Breadth first search is slow (and very slow on certain maps), but my A star
version of this program is too big.
- Lots of extra whitespace may be needed if you want to feed in an arbitrary
file.
- It fails to compile on GCC sometimes (according to a friend of mine, I've
not encountered this myself).
- The program could be obfuscated much further.
- The program contains some unused code and data.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
