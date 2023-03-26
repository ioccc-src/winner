# Second place award 

Dave Decot

## To build:

        make all

[Yusuke Endoh](/winners.html#Yusuke_Endoh) supplied a patch so that this
entry would compile with gcc. Thank you Yusuke!

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

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
