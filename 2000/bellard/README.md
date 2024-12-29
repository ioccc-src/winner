## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./bellard
```


## Judges' remarks:

This code is a nice compact example of a Modular Fast Fourier Transform.  While
its output is very specific, the internal FFT has a wide variety of uses.

Can you modify this code to produce primes such as `23523*2^70000-1`,
`48594^65536+1` or `6917!-1`?

**NOTE**: as bigger primes are found as time goes by this program no longer prints
the biggest prime once noted by the author below.


## Author's comments:

This program prints the biggest known prime number (`2^6972593-1`)
in base 10. It requires a few minutes. It uses a Modular Fast
Fourier Transform to compute this number in a reasonable amount
of time (the usual method would take ages !).

The program uses >= 64 bit `long long` type. It should run on any
system with a `gcc` compiler.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
