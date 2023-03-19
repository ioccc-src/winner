# Second place award 

Dave Decot

## To build:

        make all

NOTE: [Yusuke Endoh](/winners.html#Yusuke_Endoh) supplied a patch so that this
entry would compile with gcc.

NOTE: this entry requires a compiler that supports `-traditional-cpp`. Note that
clang does not support it and in macOS gcc is actually clang so this will not
compile with the default compiler in macOS.

## To run:

	./decot

## Judges' comments:


Some new (in 1984) compilers disliked line 15 of the source, so we changed it
from:

	for(signal=0;*k * x * __FILE__ *i;) do {

to:

	for(signal=0;*k *x * __FILE__ *i;) do {

This program prints out a string of garbage.

The judges also offer this one comment: understand comments!

## Author's comments:

No comments were provided by the author.


Copyright (c) 1984, Landon Curt Noll.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
