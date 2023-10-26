# Best one liner

Taketo Konno\
Japan\
<inaniwa3@gmail.com>

## To build:

```sh
make
```

## To run:

```sh
./konno N
```

NOTE: N is an integer from 0 to 255.

## Try:

```sh
./konno 30
```

### Alternate code:

An alternate version of this entry, [konno.alt.c](konno.alt.c), is provided.
This alternate code is an unobfuscated version of the winning code.

To compile this alternate version:

```sh
make alt
```

Use `konno.alt` as you would `konno` above.

## Judges' remarks:

This entry is a good one-liner to analyze completely.

For extra credit, what are the minimal changes to convert it to
64-bit integers so that it could print 32 lines?

## Author's remarks:

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

There are 256 (from 0 through 255) possible rules.

### Obfuscation

This program uses bit operations. I think

```c
7&O<<!o>>!o+29
```

is an interesting operation. This isn't equal to

```c
7&O>>29
```

operation. What is the operation doing?

### Limitation

This program assumes that the size of `int` is 4.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
