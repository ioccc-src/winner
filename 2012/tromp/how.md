# Obfuscation

The program implements a so called [Krivine
machine](https://en.wikipedia.org/wiki/Krivine_machine), enhanced with a [basic
input/output system](https://en.wikipedia.org/wiki/BIOS) and a reference
counting [garbage collector](https://en.wikipedia.org/wiki/Waste_collector). The
Krivine machine is a stepwise transformer of a global state consisting of the
current term, the current environment (a list of closures), and a stack of
continuations (see the 3rd reference for details).

The term space holds [lambda
calculus](https://en.wikipedia.org/wiki/Lambda_calculus) terms in the following
format. 0 denotes some form of I/O; the only four occurrences are at:

```
    C=13: recognizes end of a byte
    C=20: recognize output of 0 bit
    C=21: recognize output of 1 bit
    C=end: input list, expanded lazily
```

`1` denotes a variable, with the next entry its [de Bruijn
index](https://en.wikipedia.org/wiki/De_Bruijn_index).

`2` denotes application with the next entry the size of the term being applied.

`3` denotes lambda abstraction.


A closure consists of the following items:

0. pointer to the next closure (as part of an environment), or next record on
free list.
1. reference count.
2. pointer to environment.
3. lambda term (index in term space).

Here's what each variable does:

```
    L   Lambda term space
    m   mode: 0 for bits and 7 for bytes
    b   bits remaining unread in I, -1 on EOF
    D   Desirable temporary
    c   continuation context
    a   active environment pointer
    C   Current term index
    U   Ultimate term pointer
    u   utility entry
    B   Born to be free-list of closures
    I   Input character
    O   Output character
    e   entry of current term
```

Here's what each of the 6 auxiliary functions do:

```
    s   variable lookup in active environment with de Bruijn index u
    S   gets one bit of input, setting b to -1 on EOF or to remaining number of bits in current byte
    k   copy fragment from string literal holding lambda terms xor 46 into current end of term space
    x   expand input, adding 11 (resp. 99) entries to term space for bit (resp. byte) mode
    p   parses BLC-encoded lambda term using S(), stores results in term space and returns length
    d   decrease reference counter, add record to free list on reaching zero
```


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
