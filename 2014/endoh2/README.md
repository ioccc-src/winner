## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./prog < input > output
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

If you look closely at the source, you will see code that appears
to puts C code that includes itself.  How and why?  Perhaps it is
in the DNA code of the code? Perhaps there are 23 reasons? :-)


## Author's remarks:

### Remarks

This chromosome program synthesizes a double helix.
The helix can also be compiled as a C program.

Enjoy DNA programming!


### For more information / background reading:

* This program was inspired by Acme::DoubleHelix:
  <http://search.cpan.org/~xern/Acme-DoubleHelix-0.01/>

* The synthesized helix just includes the original program at the head.
  Do you see how [prog.c](%%REPO_URL%%/2014/endoh2/prog.c) determines whether it was invoked as a
  standalone program or included as a header file? Note that it does not use any
  gcc extension such as `__INCLUDE_LEVEL__`.

* The synthesized helix of course follows the base-pairing rules for DNA:
  A is bonding only to T, and C is bonding only to G.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
