## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: uses gets() - change to fgets() if possible**

For more detailed information see [2006/birken in bugs.html](../../bugs.html#2006_birken).


## To use:

``` <!---sh-->
    ./birken < file.tofu
```


## Try:

``` <!---sh-->
    ./try.sh
```

etc.


## Judges' remarks:

Q: EDAMAME?

A: Electronic Design Automation - Mechanical Abstract Machine Emulator

What is TOFU?  It's not a veggie friendly food, nor it is
[Verilog](https://en.wikipedia.org/wiki/Verilog) or
[VHDL](https://en.wikipedia.org/wiki/VHDL)  It is not even
[Pascal](https://en.wikipedia.org/wiki/Pascal_&lpar;programming_language&rpar;)!

NOTE: On some systems, `file(1)` claims one of the `.tofu` files is Pascal
source. :-)

It may not be the most readable hardware description language, but it is
one of the easiest 55 page long manuals to learn.  :-)

For a small but non-trivial design, try implementing a
[Linear Feedback Shift Register](http://en.wikipedia.org/wiki/LFSR)

And for those who are still confused, see <http://en.wikipedia.org/wiki/Edamame>
and <http://en.wikipedia.org/wiki/Tofu>.


## Author's remarks:

If man is capable of creating [tofu](http://en.wikipedia.org/wiki/Tofu) [hot
dogs](https://en.wikipedia.org/wiki/Hot_dog) (simulated meat), then why not tofu
[circuitry](https://en.wikipedia.org/wiki/Electronic_circuit) (simulated
circuits)?  This program is my tribute to the early computer pioneers like
[Konrad Zuse](https://en.wikipedia.org/wiki/Konrad_Zuse).  It's an educational
tool designed to introduce students to digital circuit theory using technology
that was considered state of the art in the 1940s!  To enable you to fully
understand the capabilities of this circuit simulator, I have included a 55 page
manual, [info.pdf](info.pdf), in the info portion of the entry submission.

The primary obfuscation is the data structure chosen for parsing the
input file and for executing the simulation.  Oh man...  coding that
data structure gave me such a bad headache.  But, I figure, who needs
more than a pair anyway?  Subtle obfuscations abound.  Bonus points go
out to the one who discovers the hidden program within the source.

Note that the shape of the source is a wave, not a waveform.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
