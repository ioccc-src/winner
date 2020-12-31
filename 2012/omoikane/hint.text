# Most surreptitious

Don Yang  
<omoikane@uguu.org>  
<http://uguu.org/>  


## Judges' comments:
### To build:

    make nyaruko

### To run:

    ./nyaruko [seed.txt] < original.bin > output.c
    bash output.c > key.c
    perl output.c > data.c

    cat key.c data.c > output.c

    gcc output.c -o output
    ./output > regenerated.bin

### Try:

    echo "A quick brown fox jumps over the lazy dog" | ./nyaruko > output.c
    perl output.c > data.c
    gcc -o data data.c
    ./data
    gcc -o output output.c
    ./output


### Selected Judges Remarks:

The judges have nothing to add that has not already been written
about in the spoiler.html.gz file!  :-)

## Author's comments:
Usage
=====
Nyaruko is a binary to text filter.  Given some input on stdin,
Nyaruko will produce C code that reproduces this input on stdout:

    ./nyaruko < original.bin > output.c
    gcc output.c -o output
    ./output > regenerated.bin

Output is encrypted, but both key and data are included in the output.
To separate the key from the data, run these commands:

    bash output.c > key.c
    perl output.c > data.c

The key-less data.c still compiles, but produces a different message
on stdout instead of the original input.  This message is a hint to
why the code is formatted the way it is.

To combine the key and data, concatenate them together in either
order:

    cat key.c data.c > output.c
    cat data.c key.c > output.c

By default, Nyaruko generates a unique random key for every message,
using /dev/urandom as the seed.  If given an extra command line
argument, Nyaruko will seed using that file instead of /dev/urandom:

    ./nyaruko seed.txt < input.bin > output.c

This makes the output key deterministic, allowing the same key to be
shared across different files.  On operating systems that do not have
/dev/urandom, users should always specify this extra seed argument to
avoid deterministic keys.


Features
========
Implementation details that makes Nyaruko more obfuscated than usual
programs:

   * Nyaruko recycles variables and buffers to reduce internal state.
     The variable names are also carefully chosen for mixed-case
     madness.
   * Nyaruko employs some preprocessor magic to share much of the same
     code and state between the encoder and decoder, and to increase
     occurrences of smileys ;)

Output code has these features:

   * Fits nicely under 80 columns, and does not contain any trigraphs.
   * Uses a fairly efficient encoding scheme, better than uuencode for
     files larger than ~13K, and better than base64 for files larger
     than 20K.
   * Encryption with ISAAC, a cryptographically secure pseudorandom
     number generator.
   * Trivial 3 language polyglot.

Code layout is meant to resemble Nyaruko, also known as Nyarlathotep,
the Crawling Chaos.  The most obvious thing to do with chaos is to
make a random number generator, and the most obvious thing to do with
a random number generator is to make one-time-pads for encryption.


Compatibility
=============
Nyaruko has these environment dependencies:

   * Requires ASCII character set.
   * Assumes sizeof(unsigned int) == 4.
   * Best viewed with tab stops set to 8 spaces.

Output code has the same dependencies, with the additional
requirement that the compiler must support arbitrarily long string
literals.  Maximum input size that can be encoded while still
producing standard-compliant output is ~276 bytes for C89, and ~3168
bytes for C99.

Nyaruko has been to verified to work with these compiler/OS
combinations:

   * gcc 4.4.5 on Linux (32bit and 64bit)
   * clang 3.1 on Windows (Cygwin)
   * gcc 4.5.3 on Windows (Cygwin)
   * gcc 4.5.3 on Windows (MingW)
   * gcc 4.3.5 on JSLinux
   * tcc 0.9.25 on JSLinux

Note that on MingW, stdin and stdout are not opened in binary mode by
default, this means Nyaruko may not faithfully encode files on MingW.


Extra files
===========

spoiler.html.gz - Contains full recording of how the code went from
blank state to an obfuscated program, gzipped to fit under 1MB.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
