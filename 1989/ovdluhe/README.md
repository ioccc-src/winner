# Most humorous output

Oskar von der Luehe\
Institut fuer Astronomie\
ETH - Zentrum\
8092 Zuerich\
Switzerland

## To build:

```sh
make all
```

To get this to compile with a modern CPP, we had to replace `#D` with `#define`.

## To use:

Run the program this way:

```sh
./ovdluhe < textfile
```

The program stops when it reaches the end of the template buffer\
by chance or is killed.

## Try:

```sh
./ovdluhe < ./ovdluhe.c
./ovdluhe < ./ovdluhe.c

./ovdluhe < README.md
./ovdluhe < README.md
```

## Alternate code:

The author suggested that one varies the definition of `P` from 2 through 10. As
it's a `#define` it's easy to set up. To use try:

```sh
make CFLAGS="-DP=9" clobber alt
```

Use `ovdluhe.alt` as you would `ovdluhe`.


## Judges' remarks:

Run this program using your favorite text file as input.  Files
such as mailboxes, man pages and usenet articles are especially
recommended.  You will get different output each time you run it.



## Author's remarks:

This program implements an "Eddington ape" - it generates
random text from a supplied template.  The template text file
is read through stdin.  The larger the template, the better the
result.  A maximum of `2**12` chars are used. From the template,
the program calculates the statistics of chars that immediately
follow a given string (correlator string) of a certain length
(currently 4 - can be varied by changing the definition for P
accordingly).  A character is randomly chosen, weighted by its
probability to occur after the correlator string.  That
character is printed to stdout and placed at the end of the
correlator string, whose first character is discarded.
Meaningful words are therefore usually preserved, the effect on
sentences can be dramatically random.

You might want to vary the definition of P between 2 and 10 and
observe the result.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
