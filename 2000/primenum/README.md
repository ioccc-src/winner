Best Abuse of CPP:

    Raymond Cheong
    [address subject to change]
    MD, USA


Judges' Comments:

    To build:

	make primenum

    To run:

	./primenum n (where n is an integer)

    Don't read the author comments until you're ready for the spoiler.
    Just stop and read the program; it won't take long.  Once you've figured
    out what it does, run it.  It may surprise you.

    This entry won, not because the obfuscation is impenetrable, but because
    it successfully fooled half of the judges, including me.


Selected Author's Comments:

    Description
    ===========

    For 15 years, IOCCC winners have obfuscated programs using esoteric,
    difficult-to-interpret, confusing algorithms.  This entry finally bucks
    that trend and obfuscates in the most "obvious" way possible: by
    painstakenly describing the algorithm in clear pseudocode.  Even novice
    programmers will recognize that the program should find and print prime
    numbers up to a given number (as specified on the command line).

    But novice programmers especially know that mistakes are often made in
    translating pseudocode to real code, often resulting in programs with
    unexpected and confusing output.  Clearly, the program contains several
    syntax "mistakes" (e.g. LessThanOrEqualTo) and blatant "errors" (e.g.
    Zero).  This program clearly requires "debugging."

    As a result of these "bugs", the program does not primes at all.
    Instead, the program reads input from stdin and returns garbled text on
    stdout.  Fortunately, you can recover the original message simply by
    running the program a second time.  Try:

        ./primenum n < textfile | ./primenum n > textfile2
        diff textfile textfile2

    where n is the same number (modulo 64).  So, the prime number generator
    is actually a simple text encoder/decoder!  Of course, don't forget that
    argument, otherwise the "bugs" in the program will cause it to crash!

    Features
    ========

    - The program attempts to mislead the reader into thinking that it
      generates prime numbers.  It does this by
        o describing a correct algorithm in pseudocode,
        o using partially correct conversion of pseudocode to real code,
        o using suggestive variable names, and
        o using a suggestive program name.
    - The program demonstrates a novel method of abusing the C preprocessor.
    - How the filter algorithm works is left as an exercise to the reader.
    - OK, so running it through the preprocessor strips away the prime
      number front.  But ye be warned: not a11 variab1es1es are identica1 :-)
    - Other features include
        o useless variables
        o useless if
        o a for loop that's used as an if statement
        o dependence on the high bit being 0
    - Try also
      echo THIS MESSAGE IS IN ALL CAPS | primenum 32
