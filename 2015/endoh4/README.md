# Best One-liner

Yusuke Endoh  
<https://github.com/mame/>  
Mastodon: [@mame@ruby.social](https://ruby.social/@mame)  

## To build:

```sh
make
```

## To run:

```sh
./prog <a number of arguments>
```

## Try:

```sh
./prog @ @ @ @ @ @

./prog @ @ @ @ @ @ @ @ @ @ @ @

./prog $(perl -e 'print "@ " x (2*3*5*7);')

./prog $(< Makefile)
```

## Alternate code:

An alternate version of this entry, `prog.alt.c`, is provided.  
This alternate code does not contain improvements suggested by [Gil
Dogon](/winners.html#Gil_Dogon); it is
the author's original entry.

To compile this alternate version:

```sh
make alt
```

Use `prog.alt` as you would `prog` above.

## Judges' remarks:

For this one liner it is best to avoid prime numbers. The output groups
factors in the x-y dimensions. How many factors can be represented before you
run out of command line argument space? How could you modify the program to
experiment with numbers that have more or larger factors?

## Author's remarks:

Visual factorization 1-liner.  Try:

    gcc -o prog prog.c
    ./prog @
    ./prog @ @
    ./prog @ @ @
    ./prog @ @ @ @
    ./prog @ @ @ @ @ @
    ./prog @ @ @ @ @ @ @ @
    ./prog @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @

Inspired by [Animated Factorization
Diagrams](http://www.datapointed.net/visualizations/math/factorization/animated-diagrams/).

`prog.alt.c` is the original version that I submitted. [Gil
Dogon](/winners.html#Gil_Dogon) kindly improved it during the review.  Thank
you!

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
