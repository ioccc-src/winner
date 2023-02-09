# EDAMAME Award
# (Electronic Design Automation - Mechanical Abstract Machine Emulator)

Michael Birken
US
o__1 at hotmail dot com

## Judges' comments:

### To build

        make birken

Try:

        ./birken < counter.tofu

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
