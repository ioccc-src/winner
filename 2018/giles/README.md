## To build:

This entry requires SDL2 to be installed.  See the
FAQ on "[SDL1 and SDL2](../../faq.html#SDL)"
if you don't have it
installed and don't know how to do so.

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./prog ioccc.txt

    ./prog prog.c

    ./prog sand.txt

    ./prog sand.alt.txt
```

NOTE: these invocations will take quite some time to finish.


## Judges' remarks:

Can you explain the behavior of the program when [ioccc.txt](ioccc.txt) is given
to it as input?

How would the description of the state machine look like when translated from
Polynomish to English?


## Author's remarks:

### Remarks

This entry graphically displays a simulation of sand falling.
It uses SDL to draw the interface.

The code makes the following assumptions about the underlying system:

* SDL2 is installed from [https://libsdl.org](https://libsdl.org) or your
package manager.
* `double` is an IEEE 754 floating-point type and `sizeof(double)==8`.
* The compiler supports the C99 standard.

In order to simulate the motion of the sand, a cellular automaton is used. The
state transition table is not stored directly. Instead, the program stores the
coefficients of a polynomial that map each state to the correct one. These
coefficients are stored as raw hexadecimal in the `V[]` array, and they are
reinterpreted as `double`s when used. This allows more numeric precision in fewer
characters (base 16 > base 10), and makes the purpose of the array less clear.

The code is laid out graphically as a bucket pouring sand, and it is far easier
to observe this high-level layout than the code's actual function.

The preprocessor is used to both obfuscate the code as a whole and abbreviate
the calls to SDL. Additionally, throughout the code, the variables were named
so that they are short and easily confused with each other.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
