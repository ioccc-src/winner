# Worst Abuse of the C Preprocessor:

	Ed Luke
	Mississippi State University
	P.O. Box 6176
	Mississippi State, MS 39762, USA

## To build:

        make all

### To run

	make lush.again 2>&1 | ./lush

	NOTE: This entry requires a non-standard K&R C compiler to compile.

## Judges' comments

    The program uses error messages issued by the C Proproessor to
    generate its message to the world.  One program's error is another 
    program's data!

## Author's comments

    This program is yet another "Hello World." program with a twist.  The
    string Hello World has been encoded in the error messages the compiler
    generates when compiling the source.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
