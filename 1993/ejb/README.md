## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./ejb level
```

where `level` is a value from `-128` to `127`.


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

A negative argument plays the patience puzzle.  An argument
greater than 0 plays the Tower of Hanoi puzzle.  In either case
the absolute value of the argument specifies the size of the
respective puzzle.  Refer to the web pages [hanoi.html](hanoi.html) and
[patience.html](patience.html) for more information on these puzzles.

Of course, you need a different kind of "patience" if you give
the argument 127 to this program and want to see it finish!

We note that this also works under macOS just fine.


## Author's remarks:

### What this program does

#### Output solution to Towers of Hanoi for five rings:

``` <!---sh-->
    ./ejb 5
```

The format of the output for the Towers of Hanoi case is simply a
text description of how to solve the puzzle.

#### Output solution to the Patience puzzle for six rings:

``` <!---sh-->
    ./ejb -6
```


For the patience puzzle, the output is a sequence binary codes representing
successive states of the puzzle.  The rightmost digit represents the first ring.
A `1` means the ring is on the `U`; a `0` means it is off the `U`.  The program
prints the word `"Invalid"` in response to illegal command line parameters.


### Motivation

Most people who have written software for other people have been
asked to count lines of code.  Naturally, this brings up the
controversial question of exactly what defines a line of code.
This program serves to show that counting semicolons will not
always provide a meaningful measure of code size.  This is
especially true in this program where the number of semicolons
itself is ambiguous.  Does it have two or three?  In addition, the
only C keyword this program uses besides type names and
qualifiers is `return`, and the only function defined in the code
is `main()`.  The level of complexity of the program without multiple
semicolons, statements, and functions is achieved by abusing C
operators, especially the comma operator.  Considerable use of `||`,
`&&`, and `?:` helps too.  In addition, `main()` is called recursively.
The NULL pointer that terminates `argv` is used to pass additional
information into `main()`.  Even though the algorithms used by this
code are simple, this program is still hard to follow even when
indented properly.  (It is pretty hard to indent this code
reasonably, however.)

Although this program has only been tested on UNIX systems it will probably run
on just about any machine with an ANSI C compiler.  It does not use the C
preprocessor at all.  The only functions it uses are `atoi(3)`, `malloc(3)`,
`memset(3)`, `printf(3)`, and `puts(3)`.  It does, however, require that the
architecture it runs on have bytes that are at least eight bits long and
pointers that are at least four bytes long.  In addition, it requires an ANSI
compiler since it uses `signed char` and ANSI-style function declarations.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
