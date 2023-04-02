# Best Utility:

	Anthony Howe
	Mortice Kern Systems, Inc.
	Unit 1, 14 Weber Street North,
	Waterloo, Ontario, N2J 3G4
	Canada

## To build:

        make all

## To run:

	./ant 'ERE' [file ...]

## Try:

You may also want to try the author's test suite:

    make -f ant.test.mk

## Judges' comments:

See the author's Posix P1003.2-like documentation file ant.txt
for more information.

This program demonstrates that Posix doesn't guarantee readability.  :-)

## Author's comments:

Some of the features of my entry are:

-  "Lengthy" POSIX.2 style specification and manual :) :) 
-  Useful subset of POSIX.2 Extended Regular Expressions.
-  Recursive ERE parser/compiler that generates an NFA railroad. 
-  Lazy NFA to DFA evaluation to improve performance speed.
-  Code tested on a variety of platforms.
-  Make driven test script.
-  Can be compiled with ANSI or K&R C.
-  Not a toy, but actually useful and usable on systems that use DOS.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
