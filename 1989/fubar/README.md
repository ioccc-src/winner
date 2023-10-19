# Best self-modifying program

Jay Vosburgh\
Sequent Computer Systems, Inc\
15450 SW Koll Parkway\
Beaverton, OR\
97006\
US

## To build:

```sh
make all
```

## To run:

```sh
./fubar <number>
```

## Try:

```sh
./fubar 2
```

### INABIAF - it's not a bug it's a feature! :-)

If you use either `fubar` or `ouroboros.c` (it's executable, see below) with a
number < 0 or larger than, say 20, it's very likely that the program will turn
into an infinite loop trying to compile code with syntax errors.

## Judges' remarks:

Run this with a single digit argument (or wait a long time and risk an infinite
loop as described above).

The blank line at the beginning of the source is mandatory.
Do you know why?

NOTE: the file `ouroboros.c` is created by the program itself so this is why it
is not in the repository.

## Author's remarks:

In a nutshell, this is probably the slowest and most
obnoxious factorial program ever written.  Unfortunately,
the name of the C source must be `ouroboros.c`; the name is
hard-coded into the program.

The source is a legal shell script and a legal C program.
The shell script compiles itself, and then executes the
resulting binary, giving the source as input.  The program
works by successively modifying #define lines each pass through.

Both `indent` and `cb` will damage the program, `indent`
much more so.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
