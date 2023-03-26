# The Grand Prize 

Sjoerd Mullender

Robbert van Renesse

## To build:

	make all

## To run:

	./mullender

> NOTE: If your machine is not a Vax-11 or pdp-11, this program will
> not execute correctly.  In later years, machine dependent
> code was discouraged.


## Judges' comments:


Without question, this C program is the one of the most obfuscated
C program that has ever been received!  Like all great contest
entries, they result in a change of rules for the following year.
To prevent a flood of similar programs, we requested that programs
be non machine specific.

This program was selected for the 1987 t-shirt collection.

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

## Author's comments:

These comments, found at
[https://lainsystems.com/posts/exploring-mullender-dot-c/](https://lainsystems.com/posts/exploring-mullender-dot-c/),
were provided by Sjoerd Mullender years later. We thank the author of the
article for the quote!

I have never known a lot about the VAX assembly, so we used the C compiler to
create the VAX code. We didn't write it ourselves from scratch as we did with
the PDP code. This is the reason why the VAX code is more complex, including the
extra data after the PDP code.

Robbert and I were students at the VU (Free University in Amsterdam) at the time
(mathematics with CS as our major since there was no CS curriculum when we
started). We had an assignment to create a pair of programs for the computer
networks course. The programs were supposed to send data reliably from one
program to the other over an unreliable channel. This channel was simulated with
a pair of pipes.

We decided for fun to create an obfuscated set of programs, only for the PDP, to
do this, but circumventing the channel. (I.e. cheating, hence the needed
obfuscation.) Our programs worked and we handed them in.

Of course, the teacher had a good laugh and then rejected our submission. (We
knew him well, so we could get away with this.)

Then the IOCCC came along. I don’t remember how we heard about it, but at the
time there was a world-wide messaging network Usenet where we read a bunch of
newsgroups. I’m sure it was announced there and we saw it.

Since we had just recently created these obfuscated programs we decided we could
use the same technique for an obfuscated C program. We upped the ante a bit by
making it “portable”.

To add to the obfuscation, we used different formats for the integers in the
array, some in decimal, some in octal, some in hexadecimal, and when the value
would fit, some as an ASCII character.

The rest is history.

Since this was the first contest, we hadn't seen any old entries, nor had any of
the other contestants. Of course we knew about #define and tricks you could do
with that, but we didn't need that for this program. In fact, we made it as
“standard” as possible. At the time there was this program called “cb” for C
beautifier which would re-indent your program to make the layout look better. Our
program is idempotent under cb.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
