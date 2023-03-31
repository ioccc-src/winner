# Strangest abuse of the rules:

	Jari Arkko
	Laboratory of Information Processing Science
	Helsinki University of Technology
	Otakaari 1
	02150 Espoo
	Finland

## To build and run:

    make clobber all

## Judges notes:

On many systems the compiler will not allow you to send the object file to
/dev/tty.  The author suggested:

	cc -c -o /dev/tty jar.1.c

On systems that have symbolic links, we suggest:

	ln -s /dev/tty jar.1.o
	cc -c jar.1.c

As a last resort the scripts provided simply cat the .o file to the terminal.

Abuse of the rules winners usually result in a change of the rules.  Starting in
1990, compiling entries must result an regular file which can be executed.

## Selected notes from the author:

This program is (supposedly) the smallest C program able to print "Hello
world.". The compilation itself produces the desired printout and the program
need not be actually run.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
