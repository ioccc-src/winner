# EDAMAME Award

## (Electronic Design Automation - Mechanical Abstract Machine Emulator)

    Michael Birken
    US
    o__1 at hotmail dot com

# To build:

```sh
make
```

### To run:

```sh
./birken < file.tofu
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed a segfault in
macOS with this entry. The problem was a missing `+1` for strlen() with
malloc(). Thank you Cody for your assistance!

### Try:

```sh
./birken < counter.tofu
./birken < adder.tofu
./birken < buffer.tofu
./birken < computer.tofu
```

etc.

## Judges' comments:

What is TUFO?  It's not a veggy friendly food, nor it is Verilog or
VHDL.  It is not even Pascal!

NOTE: On some systems, file(1) claims one of the .tofu files is Pascal
source. :-)

It may not be the most readable hardware description language, but it is
one of the easiest 55 page long manual to learn.  :-)

For a small but non-trivial design, try implementing a
[Linear Feedback Shift Register](http://en.wikipedia.org/wiki/LFSR)

And for those who are still confused:

> <http://en.wikipedia.org/wiki/Edamame>
> <http://en.wikipedia.org/wiki/Tofu>

## Author's comments:

If man is capable of creating tofu hotdogs (simulated meat), then why
not tofu circuitry (simulated circuits)?  This program is my tribute to
the early computer pioneers like Konrad Zuse.  It's an educational tool
designed to introduce students to digital circuit theory using
technology that was considered state of the art in the 1940's!  To
enable you to fully understand the capabilities of this circuit
simulator, I have included a 55 page manual (info.pdf) in the info
portion of the entry submission.

The primary obfuscation is the data structure chosen for parsing the
input file and for executing the simulation.  Oh man...  coding that
data structure gave me such a bad headache.  But, I figure, who needs
more than a pair anyway?  Subtle obfuscations abound.  Bonus points go
out the one who discovers the hidden program within the source.

Note that the shape of the source is a wave, not a waveform.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
