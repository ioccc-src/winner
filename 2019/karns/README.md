## To build:

``` <!---sh-->
    make
```

NOTE: we disable the optimiser because this program has problems with it
enabled.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [2019/karns in bugs.html](../../bugs.html#2019_karns).


## To use:

``` <!---sh-->
    ./prog < textfile_that_fits_on_the_screen
```

You might want to type:

``` <!---sh-->
    reset
```

after running the program to restore the terminal to its previous state.


## Try:

``` <!---sh-->
    ./try.sh
```

If you have more time you might want to try:

``` <!---sh-->
    ./prog < README.md
```


## Judges' remarks:

If you typically get lost in mazes, watching this program run might -- or might
not, YMMV -- teach you how to find your way in a maze. The algorithm is
well-known but the drawing is amazing!

Before running, make sure that your terminal can accommodate the whole file.
Before running `make test`, make it about 120x40 to be safe, ensuring that you
see the `@` sign as well as the exclamation mark.

...Oh, and the first `M` in YMMV stands for "mazing".

A puzzle for the reader: Can you change the program to consider a diagonal
movement as one step?


## Author's remarks:

### The Program:

This program is pretty simple! It performs a [breadth first
search](https://en.wikipedia.org/wiki/Breadth-first_search) on the
specified graph. The graph can be any ASCII text file that has an 'at' (`@`)
character, which is going to be the starting location, and a `!` character
which will be the destination.

The nodes on this graph that are spaces are connected with any directly
adjacent nodes that are also spaces. Nodes that aren't spaces are not
connected with anything.


### Compiling and Running:

This program usually compiles under both GCC and clang. Build with:

``` <!---sh-->
    $(CC) -std=c99 -o tbfs prog.c
```

where `$(CC)` is cc, gcc, clang, or some other C compiler.

You can then run it with:

``` <!---sh-->
    cat <input file> | ./tbfs
```

Examples:

``` <!---sh-->
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

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
