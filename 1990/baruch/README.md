## To build:

``` <!---sh-->
    make all
```

There is an alternate version for those using Turbo-C or MSC. See [alternate
code](#alternate-code) below for details.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [1990/baruch in bugs.html](../../bugs.html#1990_baruch).


## To use:

``` <!---sh-->
    echo 4 | ./baruch
    echo 7 | ./baruch
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

This alternate code is for the [very few](https://en.wikipedia.org/wiki/0)
[users](https://en.wikipedia.org/wiki/Microsoft_Windows)
[here](https://www.ioccc.org) who will need it. Nonetheless if you're using
Turbo-C or MSC, the code is available, based on the authors' remarks except that
the `" #Q"` string was not changed as that showed worse looking output instead
of improved output though admittedly we have no way to test the compilers in
question. YMMV.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `baruch.alt` as you would `baruch`.


## Judges' remarks:

This program reads an integer between 4 and 99 from the `stdin`.

It is advisable to commence with relatively small integers, as the
duration and quantity of output can become substantial as the input
integer increases.

For instance, on a relatively generic computer in 2025, the following
execution times and output quantities were recorded:

```
    | input |               clock |                user |           system |     lines of |
    | value |                time |                time |             time |       output |
    |-------|---------------------|---------------------|------------------|--------------|
    |     4 |              0.001s |              0.001s |           0.001s |           11 |
    |     5 |              0.002s |              0.001s |           0.002s |           61 |
    |     6 |              0.002s |              0.002s |           0.002s |           29 |
    |     7 |              0.003s |              0.002s |           0.002s |          321 |
    |     8 |              0.003s |              0.002s |           0.003s |          829 |
    |     9 |              0.006s |              0.004s |           0.006s |         3521 |
    |    10 |              0.016s |              0.014s |           0.006s |         7965 |
    |    11 |              0.071s |              0.068s |           0.008s |        32161 |
    |    12 |              0.419s |              0.418s |           0.014s |       184601 |
    |    13 |              2.589s |              2.564s |           0.075s |      1031969 |
    |    14 |             16.509s |             16.457s |           0.331s |      5483941 |
    |    15 |          1m 55.913s |          1m 55.173s |           2.397s |     36466945 |
    |    16 |         14m  7.307s |         14m  2.427s |          16.652s |    251132705 |
    |    17 |      1h 49m 37.938s |      1h 48m 59.355s |       2m  2.812s |   1724671873 |
    |    18 |     14h 58m 13.506s |     14h 50m 22.572s |      14m 33.652s |  12655721857 |
    |    19 |  5d  6h  9m 59.983s |  5d  5h 18m 31.147s |   2h  9m 29.490s |  99361156961 |
    |    20 | 46d  9h 23m 23.095s | 46d  3h 31m 11.600s |  17h 58m 55.478s | 819612966565 |
```

**NOTE**: The original program did not have a newline at the end of the file.  We
added a final newline to the file to make unpacking easy.


## Authors' remarks:

The goal of this work was to write a program that solves the classic [n-queens
problem](https://en.wikipedia.org/wiki/Eight_queens_puzzle), with a board size
of up to 99x99, while keeping the program as short as possible.

The program finds all possibilities to place N chess queens on an NxN
[chessboard](https://en.wikipedia.org/wiki/Chessboard) so that no queen is in
range of any other queen (not in the same column row or diagonal).  For each
solution the chess board and the place of the queens is printed to stdout.

This program is about as simple and as readable as possible.  To make things
even more simple we used a very limited subset of C:

- No pre-processor statements
- Only one, harmless, `for` statement
- No `if`s
- No `break`s
- No `case`s
- No functions outside the standard C library
- No `goto`s
- No structures

In short, it contains no C language that might confuse the innocent reader. :-)

This program demonstrates the claim that in C, any program can be written using
a single 'for' statement, as long as it is long enough.

### For PC users:

In order to compile the program under Turbo-C or MSC,  `int ` should be inserted
at the beginning of the program.  For better looking results it is recommended
to replace the `" #Q"` string with `" \261\2"`.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
