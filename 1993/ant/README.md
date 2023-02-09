Best Utility:

	Anthony Howe
	Mortice Kern Systems, Inc.
	Unit 1, 14 Weber Street North,
	Waterloo, Ontario, N2J 3G4
	Canada


Judges' comments:

    To use:
	make ant
	./ant 'ERE' [file ...]

    where:
	ERE 	is an extended regular expression
	file	a file to process (default is stdin)
    
    You may also want to try the author's test suite:
	make -f ant.test.mk
    
    See the author's Posix P1003.2-like documentation file ant.txt
    for more information.

    This program demonstrates that Posix doesn't guarantee readability.  :-)


Selected notes from the author:

    Some of the features of my entry are:

       o  "Lengthy" POSIX.2 style specification and manual :) :) 
       o  Useful subset of POSIX.2 Extended Regular Expressions.
       o  Recursive ERE parser/compiler that generates an NFA railroad. 
       o  Lazy NFA to DFA evaluation to improve performance speed.
       o  Code tested on a variety of platforms.
       o  Make driven test script.
       o  Can be compiled with ANSI or K&R C.
       o  Not a toy, but actually useful and usable on systems that use DOS.

Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
