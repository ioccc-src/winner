# Balanced use of obfuscation - Gold award

Adar Zeitak  
<aa4z2@walla.co.il>  


## Judges' comments:
### To build:

    make zeitak

### To run:

    ./zeitak < file.c

where file.c is the file to be checked for nesting errors. For example, you may
try incorrect.c and the program itself.

### Try:

    ./zeitak < zeitak.c
    ./zeitak < incorrect.c

### Selected Judges Remarks:

This is an extremely subtle and twisted piece of Gold award winning code!

The judges had spent a considerable amount of time analyzing this entry.
At one point we spent
[18 minutes](https://twitter.com/ioccc/status/252162898800033792)
just to understand 18 key characters of this code.

The file zeitak\_deobfucate.c provides a version that has been slightly
deobfuscated.  You may find reading that file helpful in your attempt
to understand this extremely subtle entry.

## Author's comments:
### Nesting Errors Detector

#### What does it do

As you have probably understood by looking at the source\*, this program has
something to do with parenthesis (and equality of opening and closing
parenthesis, if you look close enough). It goes over the file given to it and
checks that every opening (, [, or { has a matching closing one and
vice versa. It also checks that every " or ' is closed.

If an error is detected, an error message will be printed. If the problem
is a superfluous closing bracket, it will even print a few characters
around it's position.

* Make sure you view the source with 4 spaces tab width.

#### Features

* Ignores parenthesis inside strings or character constants, so no errors
  will be detected in the following line:

        printf(")");

*   Doesn't get confused by the 1984/anonymous entry!

#### Mis-Features

*   Escapes (e.g. `\"`) are ignored, so the following line will produce
    an error:

        printf("\"");

#### Obfuscation

IOCCC winners already contain entries without digits, control-flow
keywords and certain operators in their source. This entry has an
even more limited source, that is:

*   Without any digits.
*   Without any character constants.
*   Without using functions from headers other than stdio.
*   Without any control-flow keywords (not even the ?: operator).
*   Without any arithmetic or logic operators!

So, what's left? Parenthesis, and lots of them, as looking at the source will
reveal immediately. The main obfuscation is building the whole algorithm using
only function calls, typecasts, array lookups and pointer operators.

Additional obfuscations include:

*   Extensive reuse of identifiers: Macros share names with variables, inner
    curly braces scopes contain variables with names identical to those in the
    outer scopes and some of the variables have different uses in different
    parts of the program. Even the large array has more than one use.
*   A complicated data structure with "unused" fields.
*   Mostly one-letter identifiers.
*   Complex recursion: A function might call itself once, twice, or not at all.

#### Compilation/Running Notes

*   The program requires `char` to be one byte and pointers to be
    at least two bytes long.

*   The program was tested on the following platforms:

**  Ubuntu 9.04 32-bit with GCC
**  Windows 7 32-bit with GCC
**  Windows 7 32-bit with OpenWatcom

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
