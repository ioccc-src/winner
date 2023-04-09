# Most Well Rounded:

Diomidis Spinellis  
Imperial College, University of London  
Myrsinis 1  
GR-145 62 Kifissia  
Greece  


## To build:

```sh
make all
```

## To run:

```sh
./dds basic_program
./a.out
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed some segfaults in
this entry as well as making it so `a` (was `a.out`, see below) can be generated
(as in the program did not work, at least with clang). The alternative code,
described below, is what is needed for clang. Reading it might be instructive
even if you have gcc.

The first segfault which was always triggered was due to the code `*q>'
'&&(*q)--;`. This seems odd at first glance but it's pointing to `s` which was
read-only memory as a `char *s`.  It's now a `char s[]`. The second and third
segfaults were caused if a file was not specified (or it the one specified did
not exist or couldn't be opened for some reason) and if the output file could
not be opened for writing.

Thank you Cody for your assistance!

## Try:

With gcc, make and run as follows:
    
	make dds

For example, the author suggests trying:
     
	./dds LANDER.BAS
	./a.out

### Alternative code:

The alternative code, provided by Cody, allows this entry to work successfully
even with clang. He notes that unfortunately it's something of a hack or maybe
even a kludge. This however seems important because it works well and allows for
not messing with the `s` string which is quite complicated. For all Cody knows
even changing the length could break functionality and indeed the length would
have to be longer for this to work with clang.

How does it work? The code, which you will see in `dds.c`, `return system(q-6);`
equates to `return system("cc a.c");` but clang by default, at least in macOS,
has default -Werror and there were some warnings. This means that the
compilation failed with clang. In particular it would fail (at least with
`LANDER.BAS`) due to a return from `main()` without a return value and the use
of functions not yet declared.

Now as noted since the string `s` is complicated and because Cody did not want
to inadvertently mess something up he changed that code to `system("make a");`
and then added the right rule to the Makefile. Thus for the alternative version
you now need both `make` and `cc`. If you use gcc you may change the system()
call to what was given in this description to get a more authentic feel. If you
do this you must then run `./a.out` not `./a`! Thus to use the alternative
version:

```sh
make clobber alt
./dds.alt LANDER.BAS
./a
```

Thank you Cody for your assistance!


## Judges' comments:


Notice that a file `a.c` has been generated.  Can you tell how `a.c` was
produced?  How does `a.c` relate to [LANDER.BAS](LANDER.BAS)?

This obfuscated program translates BASIC programs into obfuscated
C programs by way of an obfuscated algorithm.

NOTE: Due to minor problems with some strict ANSI C compilers, we 
have supplied a more portable ANSI version.


## Author's comments:

This program is a companion to the DDS-BASIC interpreter program that
was submitted to the contest in 1990.  This compiles BASIC programs into
executable commands.  The input format is almost identical to the input
format of the DDS-BASIC interpreter.  The program needs an executable C
compiler called `cc` in your path in order to work.

### Program commands:


- variable names A to Z		
- FOR var = exp TO exp		
- GOSUB exp			
- GOTO exp			
- INPUT variable			
- PRINT exp			
- REM any text			
- variables initialized to 0 on RUN
- NEXT variable
- RETURN
- IF exp THEN exp
- PRINT string
- var = exp
- END

Expressions are the same as the expressions of the C language.
Many system calls and C library calls can be used.

### Input format:

- Free format positioning of tokens on the line.
- No space is allowed before the line number.
- Exactly one space is needed after the FOR and NEXT tokens
- ALL INPUT MUST BE UPPERCASE.

Error checking / error reports:

The compiler silently ignores many errors.
Other errors may produce errors in later phases of the compilation.

### Can you figure out how the compiler works?

Hint:

The compiler is NOT written in C, so this is really a meta-obfuscated
program.  The C code is an interpreter for the four register, seven
instruction COGNIMP$ machine that is contained in the `s` string.
(COGNIMP$ is named after the symbolic names of the seven instructions it
defines (Print Output Goto Match If, iNcrement and Copy).  The `$` sign
is used for labels.)  The actual compiler is written in COGNIMP$.
Browsing through the COGNIMP$ code we encourage you to examine the
loops for scanning the expression in the IF statement and the way a
decision tree is implemented in order to match the statements.  (Of
course the `s` string is encoded by adding one to every character of it just
to confuse you).

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
