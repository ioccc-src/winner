# Most unstable

Edward Giles  


## Judges' comments:
### To use:

    sudo apt install libsdl2-dev  # Linux
    Something else # MacOS
    make
    ./prog

### Try:

    ./prog ioccc.txt
    ./prog prog.c

### Selected Judges Remarks:

Can you explain the behavior of the program when ioccc.txt is given to it as input?

How would the description of the state machine look like when translated from
Polynomish to English?


## Author's comments:
Remarks
=======

This entry graphically displays a simulation of sand falling.
It uses SDL to draw the interface.

The code makes the following assumptions about the underlying system:

* SDL 2 is installed from https://libsdl.org
* "double" is an IEEE 754 floating-point type and sizeof(double)==8
* The compiler supports the C99 standard

In order to simulate the motion of the sand, a cellular automaton is used. The
state transition table is not stored directly. Instead, the program stores the
coefficients of a polynomial that map each state to the correct one. These
coefficients are stored as raw hexadecimal in the V[] array, and they are
reinterpreted as doubles when used. This allows more numeric precision in fewer
characters (base 16 > base 10), and makes the purpose of the array less clear.

The code is laid out graphically as a bucket pouring sand, and it is far easier
to observe this high-level layout than the code's actual function.

The preprocessor is used to both obfuscate the code as a whole and abbreviate
the calls to SDL. Additionally, throughout the code, the variables were named
so that they are short and easily confused with each other.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
