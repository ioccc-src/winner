# Best One-liner

Yusuke Endoh  
<https://github.com/mame/>  
Twitter: @mametter  

## To build:

        make all

### To run

    ./prog <a number of arguments>

### Try:

    ./prog @ @ @ @ @ @

    ./prog @ @ @ @ @ @ @ @ @ @ @ @

    ./prog $(perl -e 'print "@ " x (2*3*5*7);')

    ./prog $(< Makefile)

### Alternate code

An alternate version of this entry, prog.alt.c, is provided.  This alternate code does not contain improvements suggested by Gil Dogon.

To compile this alternate version:

    make alt

Use `prog.alt` as you would `prog` above.

### Selected Judges Remarks:

For this one liner it is best to avoid prime numbers. The output groups
factors in the x-y dimensions. How many factors can be represented before you
run out of command line argument space? How could you modify the program to
experiment with numbers that have more or larger factors?

## Author's comments:

Visual factorization 1-liner.  Try:

    gcc -o prog prog.c
    ./prog @
    ./prog @ @
    ./prog @ @ @
    ./prog @ @ @ @
    ./prog @ @ @ @ @ @
    ./prog @ @ @ @ @ @ @ @
    ./prog @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @

Inspired by [Animated Factorization Diagrams](http://www.datapointed.net/visualizations/math/factorization/animated-diagrams/).

EDIT: `prog.alt.c` is the original version that I submitted.  Gil Dogon kindly improved it during the review.  Thank you!

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2016, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
