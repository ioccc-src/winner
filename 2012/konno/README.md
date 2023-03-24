# Best one liner

    Taketo Konno  
    Tokyo, Japan  
    <inaniwa3@gmail.com>  

# To build:

```sh
make
```

### To run:

```sh
./konno N
```

NOTE: N is an integer from 0 to 255.

### Try:

```sh
./konno 30
```

### Alternate code

An alternate version of this entry, `konno_alt.c`, is provided.
This alternate code is an unobfuscated version of the winning code.

To compile this alternate version:

```sh
make alt
```

Use `konno.alt` as you would `konno` above.

## Judges' comments:

This entry is a good one-liner to analyze completely.

For extra credit, what are the minimal changes to convert it to
64-bit integers so that it could print 32 lines?

## Author's comments:

### Remarks

This program outputs [elementary cellular automaton](http://mathworld.wolfram.com/ElementaryCellularAutomaton.html) patterns.

Try:

```sh
./konno 30
./konno 90
./konno 102
./konno 109
./konno 165
```

There are 256 (from 0 to 255) possible rules.

### Obfuscation

This program uses bit operations. I think

```c
7&O<<!o>>!o+29
```

is an intersting operation. This isn't equal to

```c
7&O>>29
```

operation. What is the operation doing?

### Limitation

This program assumes that the size of int is 4.

## Copyright:

(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
