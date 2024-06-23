## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./dgibson.sh [datafile]
```

where:

`datafile` is the initial pattern (default is the
[dgibson.data1](%%REPO_URL%%/1993/dgibson/dgibson.data1) file).


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

We have provided the shell script [dgibson.sh](%%REPO_URL%%/1993/dgibson/dgibson.sh) to make it easier
to run this entry.  Run this shell script several times to
see what happens.

There are a number of data files available:

- [dgibson.data1](%%REPO_URL%%/1993/dgibson/dgibson.data1)
- [dgibson.data2](%%REPO_URL%%/1993/dgibson/dgibson.data2)
- [dgibson.data3](%%REPO_URL%%/1993/dgibson/dgibson.data3)
- [dgibson.data4](%%REPO_URL%%/1993/dgibson/dgibson.data4)
- [dgibson.data5](%%REPO_URL%%/1993/dgibson/dgibson.data5)

For [dgibson.data5](%%REPO_URL%%/1993/dgibson/dgibson.data5) you will need a large screen, lots of virtual
memory and lots of time! The [try.sh](%%REPO_URL%%/1993/dgibson/try.sh) script will run
[dgibson.sh](%%REPO_URL%%/1993/dgibson/dgibson.sh) on all the data files.

Good luck trying to use a debugger on this entry!  Life is not
always pretty.


## Author's remarks:

This program plays the [Game of
Life](https://en.wikipedia.org/wiki/Conway's_Game_of_Life).

Life is a cellular automaton invented by J. H. Conway, in which each of
a rectangular grid of cells can be alive or dead, and cells with more
than 3 or less than 2 (out of 8) live neighbours die, and empty cells
with exactly 3 neighbours give birth.

### Some notes

- the "STAT n" information does not have to be present in the initial
configuration
- the initial configuration should not have live cells around the edges
- the grid should be a perfect rectangle.

Further features: the current generation number is preserved, and the
grid automatically resizes itself as the object gets too big or too
small.

When writing this program, my goal was to make each cell in the life
grid expand to the code which calculates the fate of that cell.  In
addition, the resulting program is a single expression, which makes it
necessary to recurse `main()` in two "directions" simultaneously.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
