# Best One-liner:

	Laurion Burchall
	Brown University
	Unit 4641
	Providence RI 02912-4641
	USA

## To build:

        make all

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this so it would
compile and work with modern compilers. Thank you Cody for your assistance!

NOTE: this entry uses `gets()` so you will likely get a warning on compilation
and/or execution of the program.


## To run:

	./ldb < file

	some_command | ./ldb

NOTE: input lines must be under 232 characters long.

## Try:

	./ldb < /etc/passwd

	printf "The International Obfuscated C Code Contest\n
		Best One-liner\n
		by Laurion Burchall" | ./ldb

## Judges' comments

Trigraphs are natural obfuscators.  Most C-beautifiers become 
C-uglifiers because they don't handle them correctly.

Can you figure out how it prints a given random line from stdin?

## Author's comments

All input lines must be under 232 characters long.  The compiling
platform should be ASCII based.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
