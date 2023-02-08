# Most partisan 1-liner

Adrian Cable  
<adrian.cable@gmail.com>  


## Judges' comments:
### To build:

    make cable1

### To run:

    ./cable1 name group1 group2

### Try:

    ./cable1 obama republican democrat
    ./cable1 nixon republican democrat
    ./cable1 bush republican democrat
    ./cable1 kennedy republican democrat
    ./cable1 lincoln republican democrat

### Selected Judges Remarks:

Partisan may be defined as a strong supporter of a cause, party or person.
We need not limit ourselves to the two major political parties in the US today.

Let us consider:

    ./cable1 Cooper Mac PC

Simon works for Apple, so would would expect Mac.  :-)
Landon is a long time Mac user:

    ./cable1 Noll Mac PC

That works too!.  Now Leo brings PCs to the IOCCC judging for cross-platform
testing:

    ./cable1 Broukhis Mac PC

We can test other people.  The late Steve Jobs:

    ./cable1 Jobs Mac PC

That works!  How about Bill?

    ./cable1 Gates Mac PC

A PC guy as expected.  What about that other Steve?

    ./cable1 Ballmer Mac PC

Humm .. maybe there is a hidden reason he is leaving the late Micro$oft? :-)
Why late?  See [this tweet](https://twitter.com/landonnoll/status/401582967123742720).

So how does a one line C source know so much?  Hint: it doesn't.

## Author's comments:
Presidents of the United States of America!
===========================================

Politics is full of memorable one-liners. Without wishing to misunderestimate the taste of the judges, nor prejudge the past, the author hopes you enjoy this contribution to the genre.

This one-line C program accepts as a first command-line argument the last name of any of the last 31 US Presidents (from Franklin Pierce onwards), in lower case, and prints out their political affiliation.

Use "republican" as the 2nd command-line argument, and "democrat" as the 3rd (or equivalent strings of your choice).

Why is this entry obfuscated/interesting?
-----------------------------------------

- The program looks up the name supplied on the command line against a list of Presidents' names, and matches names to political affiliations using a look-up table. But where in the source is the list of names, and where is the look-up table?

Notes
-----

- For Theodore Roosevelt, use: ./cable1 roosevelt republican democrat
- But, for Franklin D Roosevelt, use: ./cable1 fdr republican democrat
- This program needs a little endian CPU to work properly.

Compiler warnings
-----------------

clang warns about a missing type specifier for main, and that implicit function declarations are invalid in C99 (but still accepts them).

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
