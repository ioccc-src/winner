# Best self documenting program

Hou Qiming  
<hqm03ster@gmail.com>  


## Judges' comments:
### To build:

    make hou

### To run:

    ./hou 'a calculator expression -- see the C Code for details'

### Try:

    ./hou 11/26+222/31

    ./hou 'log((21701-19937)-(23209-21701))/log(2)'

    ./hou 'sin(1.5708)+0.04321+log(sqrt(exp(1*1*1)))+(1+2*3)-0.4-0.6+(4+6)*(2-1+2*3)-tan(0.785398)+2*10/3*6*sqrt(16/2/2)*10+10000-1000'

### Selected Judges Remarks:

This self-documenting scientific calculator compiles clean with no
warnings under the most strict pedantic mode of gcc and clang.

The first example, along with the correct result appears in the
source code. What does it mean?

The calculator obeys the precendence rules and allows parenthesis,

        ./hou '1+2*3'
        ./hou '(1+2)*3'

What exactly does the text formatting do?

What does this evaluate to in C?

        +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+

#### Self documenting source

Comments would almost be redundant.  :-}

#### The ASCII art is valid C code

Not just fancy formatted comment removed by the C Pre-processor

#### The only multi-byte strings are format strings

The code does not contain some simple string-encoded lookup table for calculator operations.

#### Example input and output in the source

The example input and output in the C code is significant.  Can you find out why?

#### The button layout

The button layout in the C code is significant ... not just a nice looking layout.

#### input parsing

The parser is functionally equivalent to a normal arithmetic parser for all valid inputs.
For another fun challenge: try to determine how it parses the command line argument.


## Author's comments:
### Obfuscations

This program is designed to be self-documenting. It doesn't just provide an
example command line. It also provides the expected output and illustrates all
supported functionality using embedded ASCII art.

- A few line numbers are significant and careless beautification will break the program.
- The entire ASCII art is valid code. The preprocessor won't remove any part of it.
- The only strings longer than 1 byte are printf/sscanf format strings, even
  after preprocessing. No string-encoded lookup table is used.
- The example input and its expected output are both algorithmically significant.
- The button layout is also significant.
- The actual syntax being parsed is not the obvious, despite being
  functionally equivalent for all correct inputs.

### Portability

- This program requires "argv" to point to writable memory. It doesn't require
  the actual argv strings to be writable, though.
- This program requires ASCII.
- This program doesn't work with %e style numbers like "1e-4".
- Some seemingly redundant code works to eliminate warnings and evade a gcc bug.

### Spoilers

The parser parses function names, substraction, and division as single-letter
unary operators. A bitmask encoded hash table is used to check no-ops/digits
and another hash function maps the ASCII to a function ordinal, which is then
executed by the button panel.

Both hash functions are found using a separate search program. Another program
is used to find a way to format one hash function as example input such that
it produces something resembling the bitmask hash table as part of its output.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
