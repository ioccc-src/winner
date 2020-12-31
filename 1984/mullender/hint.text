# The Grand Prize 

Sjoerd Mullender

Robbert van Renesse

## Judges' comments:

Without question, this C program is the most obfuscated C program that
has ever been received!  Like all great contest entries, they result
in a change of rules for the following year.  To prevent a flood of
similar programs, we requested that programs be non machine specific.

This program was selected for the 1987 t-shirt collection.

> NOTE: If your machine is not a Vax-11 or pdp-11, this program will
> not execute correctly.  In later years, machine dependent
> code was discouraged.

The C startup routine (via crt0.o) transfers control to a location
named main.  In this case, main just happens to be in the data area.
The array of shorts, which has been further obfuscated by use of
different data types, just happens to form a meaningful set of PDP-11
and Vax instructions.  The first word is a PDP-11 branch instruction
that branches to the rest of the PDP code.  On the Vax main is called with
the calls instruction which uses the first word of the subroutine as a
mask of registers to be saved.  So on the Vax the first word can be anything.
The real Vax code starts with the second word.  This small program
makes direct calls to the write() Unix system call to produce a
message on the screen.  Can you guess what is printed?  We knew you
couldn't!  :-)

Copyright (c) 1984, Landon Curt Noll.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
