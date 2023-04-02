# Best One-liner:

Laurion Burchall
Brown University
Unit 4641
Providence RI 02912-4641
USA

## To build:

        make all

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this so it would
compile and work with modern compilers. The problem was that `srand()` returns
void but it was used in a `||` expression. Thus the comma operator was needed.
Cody also changed the entry to use `fgets()` instead of `gets()` to make it
safe for lines greater than 231 in length. Thank you Cody for your assistance!


## To run:

	./ldb < file

	some_command | ./ldb


## Try:

	./ldb < /etc/passwd

	printf "The International Obfuscated C Code Contest\n
		Best One-liner\n
		by Laurion Burchall" | ./ldb

## Judges' comments:

Trigraphs are natural obfuscators.  Most C-beautifiers become C-uglifiers
because they don't handle them correctly.

Can you figure out how it prints a given random line (or if the line is longer
than 231 characters, part of that line) from stdin?

## Author's comments:

All input lines must be under 232 characters long.  The compiling
platform should be ASCII based.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
