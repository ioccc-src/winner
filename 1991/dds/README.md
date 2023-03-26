# Most Well Rounded:

	Diomidis Spinellis
	Imperial College, University of London
	Myrsinis 1
	GR-145 62 Kifissia
	Greece


## To build:

        make all

### To run

	./dds basic_program
	./a.out

## Judges' comments

Make and run as follows:
    
	make dds

For example, the author suggests trying:
     
	dds LANDER.BAS
	a.out

Notice that a file a.c has been generated.  Can you tell how a.c was
produced?  How does a.c relate to LANDER.BAS?

This obfuscated program translates BASIC programs into obfuscated
C programs by way of an obfuscated algorithm.

NOTE: Due to minor problems with some strict ANSI C compilers, we 
have supplied a more portable ANSI version.


## Author's comments

This program is a companion to the DDS-BASIC interpreter program that
was submitted to the contest in 1990.  This compiles BASIC programs into
executable commands.  The input format is almost identical to the input
format of the DDS-BASIC interpreter.  The program needs an executable C
compiler called `cc' in your path in order to work.

Program commands:

	variable names A to Z		variables initialized to 0 on RUN
	FOR var = exp TO exp		NEXT variable
	GOSUB exp			RETURN
	GOTO exp			IF exp THEN exp
	INPUT variable			PRINT string
	PRINT exp			var = exp
	REM any text			END

Expressions are the same as the expressions of the C language.
Many system calls and C library calls can be used.

Input format:

- Free format positioning of tokens on the line.
- No space is allowed before the line number.
- Exactly one space is needed after the FOR and NEXT tokens
- ALL INPUT MUST BE UPPERCASE.

Error checking / error reports:

The compiler silently ignores many errors.
Other errors may produce errors in later phases of the compilation.

Can you figure out how the compiler works?  Hint:

    The compiler is NOT written in C, so this is really a meta-obfuscated
    program.  The C code is an intepreter for the four register, seven
    instruction COGNIMP$ machine that is contained in the s string.
    (COGNIMP$ is named after the symbolic names of the seven instructions it
    defines (Print Output Goto Match If, iNcrement and Copy).  The $ sign
    is used for labels.)  The actual compiler is written in COGNIMP$.
    Browsing through the COGNIMP$ code we encouriage you to examine the
    loops for scanning the expression in the IF statement and the way a
    decision tree is implemented in order to match the statements.  (Of
    course the 's' string is encoded by adding one to every character of it just
    to confuse you).

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
