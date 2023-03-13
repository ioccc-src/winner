# The most obscure program

Lennart Augustsson
<chalmers!augustss> 

## To build:

        make all

## To run:

	./august

## Try:


	./august | head -n 10

If you have the `primes(6)` tool (sometimes part of BSD Games) you can see
what of the output in the first N (say 15) lines are primes:

	while read -r n ; do primes "$n" $((n + 1)) ; done < <((./august | head -n 15 ))


## Judges' comments:

An interesting use of a recursive call to main.  Compile and execute
without args.  What is the initial value of b, and does it alter the
action of the program?

If you let it, the program will continue to print a numerical sequence
(can you guess in what base it is printed?) until you run out of
memory or until they sell your computer, which ever comes first.

## Author's comments:

No comments were provided by the author.


Copyright (c) 1985, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
