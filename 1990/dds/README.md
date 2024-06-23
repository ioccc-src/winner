## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./dds
```


## Try:

Give the following lines as input:

``` <!---basic-->
    OLD LANDER.BAS
    RUN
```

NOTE: this entry is probably one of the only times CAPS LOCK might be worth
having (though still not useful enough to enable :-) ) as all input has to be
UPPER CASE.


## Judges' remarks:

Be sure not to run out of fuel!


## Author's remarks:

This is the DDS-BASIC Interpreter (Version 1.00).

### Immediate commands:

- RUN
- LIST
- NEW
- OLD filename
- BYE
- SAVE filename

### Program commands:

- variable names a to z
- variables initialized to 0 on RUN
- FOR var = exp TO exp
- NEXT variable
- GOSUB exp
- RETURN
- GOTO exp
- IF exp THEN exp
- INPUT variable
- PRINT string
- PRINT exp
- var = exp
- REM any text
- END

### Expressions (ranked by precedence):

- Bracketed expressions
- number (leading 0 for octal, 0x for hex, else decimal), variable
- Unary -
- `*` `/`
- `+` `-`
- `=` `<>`
- `>` `<`
- `<=` `>=`

(`*` and `+` are also used for boolean AND and boolean OR)

Boolean expressions evaluate to 0 for false and 1 for true.

### Editing:

- Line editor using line re-entry.
- A line number with nothing following it, deletes the line.

### Input format:

- Free format positioning of tokens on the line.
- No space is allowed before the line number.
- Exactly one space is needed between the OLD or SAVE command and the filename.
- ALL INPUT MUST BE UPPERCASE.


### Limits:

- Line numbers		1-10000
- Line length		999 characters
- FOR nesting		26
- GOSUB			999 levels
- Program		Dynamically allocated
- Expressions		-32768 - 32767 for 16 bit machines, -2147483648 - 2147483647 for 32 bit machines

### Error checking / error reports:

No error checking is performed.
It might dump core if a syntax or semantic error is encountered.

### Hosting Environment:

ANSI C, traditional K&R C or OSF ANDF ASCII or EBCIDIC character set 48K bytes
memory.

The Speed of DDS-BASIC Interpreter (Version 1.00) relative to Microsoft Advanced
BASIC 3.31 is approximately 60%.

The code size could be further reduced by doing ugly things like not declaring
the return type of functions, not freeing memory, defining define, and joining
lines.  In its present 1536 character form the program is reasonably portable
(it may fail to run in a tagged object architecture) and nicely formatted (it
fits in an `80*25` screen).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
