## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./dds basic_program
    ./a.out 2>/dev/null
```


## Try:

The author suggests trying:

``` <!---sh-->
    ./dds LANDER.BAS
    ./a.out
```

Notice that a file `a.c` has been generated.  Can you tell how `a.c` was
produced?  How does `a.c` relate to [LANDER.BAS](%%REPO_URL%%/1991/dds/LANDER.BAS)?

What happens if you give the program a C program like itself? Try:

``` <!---sh-->
    ./dds dds.c
```

You'll get errors yes but what does the generated file look like? What about
other types of files?


## Judges' remarks:

This obfuscated program translates BASIC programs into obfuscated
C programs by way of an obfuscated algorithm.


## Author's remarks:

This program is a companion to the [1990/dds](../../1990/dds/index.html)
1990 DDS-BASIC interpreter program.  This compiles BASIC programs into compilable C code
and then compiles it.  The input format is almost identical to the input format
of the DDS-BASIC interpreter.  The program needs an executable C compiler called
`cc` in your path in order to work.


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
- Exactly one space is needed after the `FOR` and `NEXT` tokens.
- ALL INPUT MUST BE UPPERCASE.

### Error checking / error reports:

The compiler silently ignores many errors.
Other errors may produce errors in later phases of the compilation.

### Can you figure out how the compiler works?

#### Hint:

The compiler is NOT written in C, so this is really a meta-obfuscated
program.  The C code is an interpreter for the four register, seven
instruction `COGNIMP$` machine that is contained in the `s` string.
(`COGNIMP$` is named after the symbolic names of the seven instructions it
defines (`Copy`, `Output`, `Goto`, `iNcrement`, `If`, `Match` and `Print`).

The `$` sign is used for labels.  The actual compiler is written in `COGNIMP$`.
Browsing through the `COGNIMP$` code we encourage you to examine the loops for
scanning the expression in the `IF` statement and the way a decision tree is
implemented in order to match the statements.  (Of course the `s` string is
encoded by adding one to every character of it just to confuse you).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
