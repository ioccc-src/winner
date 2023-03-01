# Second place award 

Dave Decot

## To build:

        make all

NOTE: This entry might not compile when using modern compilers.

## Judges' comments:

NOTE: On modern systems this entry requires the option `-traditional-cpp` which
clang does not support. We thank Yusuke Endoh for his patch which allows the
entry to compile under gcc! Please be advised that gcc under macOS is actually
clang so this will not compile with the default gcc under macOS.

Some new (in 1984) compilers disliked line 15 of the source, so we changed it
from:

	for(signal=0;*k * x * __FILE__ *i;) do {

to:

	for(signal=0;*k *x * __FILE__ *i;) do {

This program prints out a string of garbage.

The judges also offer this one comment: understand comments!


Copyright (c) 1984, Landon Curt Noll.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
