# Best use of bioinformatics

Yusuke Endoh  
<mame@ruby-lang.org>  
<https://github.com/mame/>  


## Judges' comments:
### To build:

    make

### To run:

    ./prog < input > output

### Try:

    echo Hello | ./prog

    echo Hello | ./prog > hello.c
    make hello
    ./hello

### Selected Judges Remarks:

If you look closely at the source, you will see code that appears
to puts C code that includes itself.  How and why?  Perhaps it is
in the DNA code of the code? Perhaps there are 23 reasons? :-)

## Author's comments:
### Remarks

This chromosome program synthesizes a double helix.
The helix can also be compiled as a C program.

Enjoy DNA programming!

### For more information / backgroud reading:

* This program was inspired by Acme::DoubleHelix:
  http://search.cpan.org/~xern/Acme-DoubleHelix-0.01/

* The synthesized helix just includes the original program at the head.
  Do you see how `prog.c` determines whether it was invoked as a standalone program or included as a header file?
  Note that it does not use any gcc extension such as `__INCLUDE_LEVEL__`.

* The synthesized helix of course follows the base-pairing rules for DNA:
  A is bonding only to T, and C is bonding only to G.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
