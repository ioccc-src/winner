## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./bas2 < file
    echo text | ./bas2
```


## Try:

``` <!---sh-->
    ./try.sh

    ./try.sh "foo bar" "baz" "IOCCC 1998/bas2" README.md

    ./try.sh try.sh "bas2.c" bas2.orig.c
```


## Judges' remarks:

### Questions to ponder:

Can you determine the relationship between the input and the resulting numeric
output?

The program was not designed to process files with a certain octet value, what
value is that?


### Hint and Extra Credit:

This entry points out a minor flaw in the IOCCC rules that has
been around since 1992.  It processes a certain octet value in
a way that differs from a strict reading of one of the
official IOCCC rules.  What is the rule and what is the octet
value?


## Author's remarks:

The main obfuscation is the way characters are recognized, which is
done by matching the bit patterns.  Minor obfuscations are:

- Useless layout.

- Useless variable names.

- Recursive `main()` instead of 2 loops (over input characters and over bits in
the character).

- `?:` and `||` instead of if statements.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
