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


## Judges' remarks:

An interesting use of a recursive call to main.  Compile and execute
without args.  What is the initial value of b, and does it alter the
action of the program?

If you let it, the program will continue to print a numerical sequence
(can you guess in what base it is printed?) until you run out of
memory or until they sell your computer, which ever comes first.

## Author's remarks:

No comments were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
