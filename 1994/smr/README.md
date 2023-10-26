# Worst Abuse of the Rules

Szymon Rusinkiewicz\
Massachusetts Institute of Technology\
305 Memorial Dr., Room 005B\
Cambridge, Ma  02139\
US

## To build:

```sh
make all
```

## To use:

```sh
./smr
```

## Try:

```sh
./smr > smr.out ; diff -s smr.out smr.c
```

## Judges' remarks:

Nearly every year, one or more people would submit what they claimed\
was the world's smallest self reproducing program.  While the sizes
of these submissions varied, a quick glance would reveal that they
were too big, until this entry came along.

While strictly speaking, smr.c is not a valid C program, it is
not an invalid C program either!  Some C compilers will compile
an empty file into a program that does nothing.  But even if your
compiler can't, the build instructions supplied with this entry
will produce an executable file.  On most systems, the stdout
from the executable will exactly match original source.

In the future, the contest rules will specify a minimum size that is one
character larger than this entry, forever eliminating this sort of program from
the contest.  After all, how many variations can one make on this entry? :-)

## Author's remarks:

The world's smallest self-replicating program. Guaranteed.
Produces a listing of itself on stdout.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
