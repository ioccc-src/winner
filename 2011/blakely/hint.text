# Most devolving

Philip Blakely  
Cambridge, UK  
<pmblakely@gmail.com>  


## Judges' comments:
### To build:

    make blakely

### To run:

    # Zoom out and make your terminal window 53 or more lines deep 
    ./blakely < blakely.c | head -300

### Try:

    ./blakely < 3.dat | head -100
    ./blakely - < 3.dat | head -40
    ./blakely < evolve_to_3.dat | head -55
    ./blakely < t0_3.dat

### Selected Judges Remarks:

This program plays Life, computes Pi to 16 digits
if given its own source as input, and allows to check if your garden
is a [Garden of Eden](http://en.wikipedia.org/wiki/Garden_of_Eden_%28cellular_automaton%29), all in one source. 

If you have enough time to spare, put the plan of your garden in a text file, 
and run:

    ./blakely - < garden.txt

## Author's comments:
Remarks
-------

This program uses a well-known algorithm in order to display pi to
fifteen decimal places. The source-layout itself demonstrates the importance of
using the correct amount of whitespace in code and the clear superiority of spaces over tabs.

In order to see the main feature of the code, type:

    ./blakely < blakely.c

and wait for about four seconds before using Ctrl-C (or whatever) to end the program. The
results are best viewed in a terminal window at least 60 characters
high and wide. Alternatively, redirect the output to a separate file
(killing when necessary).

Overview
--------

The program emulates John Conway's ceullular automaton known as "The
Game of Life", using standard input as a starting grid. The layout of
the source-code is such that it evolves to a digital representation of
the first 15 decimal places of pi after 4 time steps. This was setup
using the other feature of the program which can be demonstrated as follows:

    ./blakely - < 3.dat

The program will first display the grid given in 3.dat, and then three
more grids (taking a few minutes to display the last). Waiting for any more grids will
take a substantial amount of time. The final grid has been put into
evolve\_to\_3.dat, and if you type

    ./blakely < evolve_to_3.dat

then the 3 will reappear after three time steps.

As should now be clear, this use of program will attempt to evolve a given setup backwards in
time according to the Life rules. The resulting grid is clearly not
necessarily unique. The program will evolve backwards given *any* single
command line option.

When evolving forwards, the code can only be stopped by killing the
program. In the reverse direction, the code can either be killed, or
will stop if it is unable to find a grid that will evolve to the
current layout correctly. This can be seen with the sample grid
t0_3.dat, which evolves backwards by only two time-steps.

Input file format
-----------

The input files must encode a square grid, where a space is a dead
cell, and any other character (except a newline) is a living cell. Each line must be the same
length, and end with a single newline character \n (ASCII 10), including the last line. When
designing grids, it may help to type full-stops in place of spaces,
and do a global replace afterwards. Any deviation from this format will
cause errors in the output.

Limitations
-----------

This is only an approximation to the original Life, as it takes place
on a finite grid, with borders that are automatically killed off
before each time step. However, when evolving backwards, the resulting
grids will not cause any cells on the boundaries to come alive.
As the display is performed before killing off the borders, some
boundary cells may sometimes appear to be alive, but not be treated as
such for the following time-step, although any living cells on the
right border will never be displayed.

The maximum grid size is currently 99 by 99 (exceeding this will cause a
seg-fault), but changing the two 9802s to MAX\_SIZE*MAX\_SIZE+1 will
solve this, although some reformatting of the
code may have to be done to allow larger numbers.

Compiler warnings/assumptions
-----------------------------

When compiled with the -Wall -pedantic -ansi options of gcc, some
warnings suggesting extra parentheses occur (not necessary for anyone
fully conversant with operator precedence). There is one unused
variable, v, but unnamed function parameters are not permitted in ANSI
C, so naming it is necessary, and gcc no longer warns about its
existence, although earlier versions did.

Since the program calculates ASCII character values for display, an
ASCII based system is required to run it. Also, as mentioned above,
any system that uses anything other than a plain '\n' to end a line will cause
problems when reading in files.

Obfuscations
------------

Given the finely-tuned layout required to evolve into pi, this is one of the
main obfuscations used in the code. However, running the code through the
preprocessor, expanding the defines, and applying GNU's indent, although
making the location of functions and statements clear, by no means makes the
code entirely clear.  Note that expanding out the #defines does not take the
program over the character limit. The main reason for these is to do with the
layout, since there are few places that keywords or tokens of over 2
characters can be fitted, and requiring the first few lines to be #includes
would cause similar problems.

Other obfuscations used are:

- Use of the classic 2[a] syntax to access the third element of the
  array a
- Nested ternary operators, combined with shortcut evaluation being
  required for correct operation
- Use of the comma operator to embed operations inside one another
- Calculation of ASCII codes
- Needlessly recursive functions
- Use of bitwise-operations.
- Storing a variable whose value could easily be found from another
- Use of gotos to emulate a for loop

Algorithm
---------

The forwards evolution of the grid is straightforward.

The reverse evolution is done using a brute-force method. As far as I
know, a brute-force method is the only viable automatic approach for
general grids, although more intelligent algorithms would be possible
given more space.

The program starts with an empty "trial" grid and, starting from the
top-left, tries all possibilities for the neighbours of the current
cell that will cause the cell to evolve to the required state. It then
proceeds to the right and down. Thus, it only ever needs to look at
the cells below and to the right when testing. However, the already
defined cells above and/or to the left of the cell may mean that there
are no possibilities that will give the correct state, in which case
the code backtracks and tries other possibilities on previous
cells. The program knows it has a valid grid if it gets to the last
cell. If it cannot find a valid grid, the program exits.

Since this uses brute-force, it can be very slow. (In fact, the
various obfuscations have, at least for the gcc compiler,
caused a substantial slowdown.)

Program layout
--------------

The "calculation" of pi was chosen purely because algorithms to find
pi are numerous, but the Game of Life is rarely (if ever?) used for
this purpose. Also, separate digits made determining the layout somewhat easier.

Deriving the layout was the most complicated part of the program. As is clear from
the final layout featuring pi, the grid was divided into sixteen squares,
and layouts that would evolve to each of the nine digits required were
found. (This used the three-by-five digit-layout embedded in, at first, a
nine-by-nine grid, then in larger grids, until fifteen-by-fifteen was
reached.) The fifteen-by-fifteen grids give enough blank cells around
them that the digits will not collide when evolving.

However, this did not allow for sufficient characters to fit the code
into. Therefore it was necessary to add some regions that would quickly die off
without expanding to collide with the digits' evolution.
Groups of cells such as singletons, pairs, and larger groups like

    * * * * * * * * * *
     *****************
    * * * * * * * * * *

were useful in this regard.

Other problems were given by keywords which need to be all in one
string, keywords requiring space after them, and
multi-character tokens. Some of these problems were dealt with by
using the #defines and #includes given in the build-script, as there
was no way to have sufficient separate lines in the code to do this
without causing many difficulties. Some rejigging of the grid's layout
as the code was fitted into its format was also done, resorting to
trial-and-improvement in some cases. Occasional use of constructs such
as f -= -3 was made as f += 3 could not be fitted into the required format.
The fact that the borders would be killed off immediately was also helpful.

It should be noted that evolving a full 60-by-60 grid backwards using
this code would probably take us at least up to the heat-death of the
universe.

The command ./blakely - < blakely.c is therefore *not* recommended.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
