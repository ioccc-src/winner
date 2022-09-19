Best primal ASCII graphics:

    Nicolas Ollinger
    Ecole Normale Superieure de Lyon
    LIP, ENS Lyon
    46, allée d'Italie
    69364 Lyon Cedex 07
    France

    http://www.ens-lyon.fr/~nollinge/


Judges' Comments:

    To build:

    	make ollinger

     Try:

	In a large window, say 200 chars wide and 100 high (200x100)
	with a tiny font, try:

	    ./ollinger 1000 | cut -c -200


     Do get lost in the programs line of thought!  :-)


Selected Author's Comments:

    What's this?
    ------------

    What do you see? On the left, you will see an enumeration of all successive
    primes from 2 to the parameter you gave to the program. On the right part,
    you can see the sieve used to find these primes. The big diagonals from
    right to left are used to erase composed numbers. When no diagonal crosses
    a number, then the left cell take value 1 and the number is prime.

    The parallel version of this algorithm works in real time n. This C
    sequential version is slower as it works in O(n*log n). But you have some
    nice picture instead... the cost is a constant number of operation for each
    character printed on the screen.


    Why do you wrote it?
    --------------------

    Let's just quote the FAQ :

    Q: Are there types of entries that are submitted so frequently that the
       judges get tired of them?

    A: Yes, there are types of entries that show up over and over again.
       The guidelines say:

                We tend to dislike programs that:
                are similar to previous winners

          We like variety. However too often we see (please look at the winning
          examples given to be aware of the level of the competition):

    (snip)

                generating small primes (below is the list of all
                                         prime related winners)
                      1985/august
                      1988/applin
                      1994/weisberg
                      1995/makarios
                      1996/dalbec
                      2000/bellard

                As you can see, just a list of primes (let alone small primes)
                 does not cut it anymore.

    (snip)

                entries that use some complex state machine/table to print
                something

                      1988/isaak
                      1988/phillipps

                Unbeaten for 12 years and counting...

    I think this is enough motivation for trying to submit a program which uses
    some complex state machine/table to generate small primes and print them.


    The way it works
    ----------------

    This program simply prints the space-time diagram of some particular
    cellular automaton. The automaton is a 9-state automaton by Korec in 1998.
    It is an optimization of an old automaton for recognizing primes designed
    by Fischer in 1965.

    The table of the automaton is encoded into the string e and consists of
    345 transitions of the kind f(left,middle,right). This encoding into e
    is obfuscated to reduce its size, restrict it to characters 32 to 127 and
    guarantee a constant time.

    The main loop simply iterates this transition function on each cell.

    "The rest is silence" (Hamlet, V.2)

    Enjoy!
