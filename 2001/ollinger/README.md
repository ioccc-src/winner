## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2001/ollinger in bugs.html](../../bugs.html#2001_ollinger).



## To use:

``` <!---sh-->
    ./ollinger integer
```


## Try:

``` <!---sh-->
    ./try.sh
```

Try the above command in a large window, say 200 chars wide and 100
high (200x100) with a tiny font.


## Judges' remarks:

Do get lost in the program's line of thought!  :-)


## Author's remarks:

### What's this?

What do you see? On the left, you will see an enumeration of all successive
[primes](https://en.wikipedia.org/wiki/Prime_number) from 2 to the parameter you
gave to the program. On the right part, you can see the sieve used to find these
primes. The big diagonals from right to left are used to erase composed numbers.
When no diagonal crosses a number, then the left cell take value 1 and the
number is prime.

The parallel version of this algorithm works in real time `n`. This C
sequential version is slower as it works in `O(n*log n)`. But you have some
nice picture instead... the cost is a constant number of operation for each
character printed on the screen.


### Why did I write this ?


Let's just quote the [IOCCC FAQ](../../faq.html):

Q: Are there types of entries that are submitted so frequently that the
   judges get tired of them?

A: Yes, there are types of entries that show up over and over again.
   The guidelines say:

```
    We tend to dislike programs that:
    are similar to previous winning entries

    We like variety. However too often we see (please look at the winning
    examples given to be aware of the level of the competition):

    (snip)

    generating small primes (below is the list of all prime related entries)

            1985/august
            1988/applin
            1994/weisberg
            1995/makarios
            1996/dalbec
            2000/bellard

    As you can see, just a list of primes (let alone small primes)
    does not cut it anymore.

    (snip)

    entries that use some complex state machine/table to print something

              1988/isaak
              1988/phillipps

    Unbeaten for 12 years and counting...
```

I think this is enough motivation for trying to submit a program which uses
some complex state machine/table to generate small primes and print them.


### The way it works

This program simply prints the space-time diagram of some particular
cellular automaton. The automaton is a 9-state automaton by [Ivan
Korec](https://sk-m-wikipedia-org.translate.goog/wiki/Ivan_Korec?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en-US&_x_tr_pto=wapp) in 1998.
It is an optimization of an old automaton for recognizing primes designed
by [Fischer](http://richardallenfischer.com) in 1965.

The table of the automaton is encoded into the string `e` and consists of
345 transitions of the kind `ff(left,middle,right)`. This encoding into `e`
is obfuscated to reduce its size, restrict it to characters 32 to 127 and
guarantee a constant time.

The main loop simply iterates this transition function on each cell.

"The rest is silence" (Hamlet, V.2)

Enjoy!


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
