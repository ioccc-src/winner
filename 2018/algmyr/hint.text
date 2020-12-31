# Most cacophonic

Anton Älgmyr  
Twitter: @aalgmyr  


## Judges' comments:
### To use:

    make

    cat prog.c | ./prog           # Printing garbage might break your font
    ./prog <file1> <file2> > out.raw
    ./prog -d 2 0 out.raw         # Decode the first (0th) channel out of two

### To try:

    ./prog -h | ./prog -d 1 0

    # Who needs cat?
    ./prog prog.c | ./prog -d 1 0

    # Assuming ALSA
    echo '<<<<<<  /\_/\_/\  _-_-_-_  !!!!!  :.:.:.:  >>>>>> ****** ~~~~~~~' |
        ./prog | aplay -c1 -fFLOAT_LE -r44100

    # Assuming sox
    echo -n ' MENE MENE TEKEL UPHARSIN ' | ./prog | 
        sox -t raw -c 1 -r 44100 -L -e floating-point -b 32 - -n spectrogram -d 10 -X 300

### Selected Judges Remarks:

Be warned, this is not your garden variety text-to-speech program! Earplugs are advised,
or at least a handy and well-tested volume knob.

Pixels are numbered, amplitudes are weighed, frequencies are divided,
and the message can be displayed in fiery letters, but don't be alarmed.

How does decoding of the waveform work? Can you encode an arbitrary text in a sound sample?


## Author's comments:

What is this?
=============
To put it brief, this entry is akin to a sound based cat. It takes characters as input and outputs them into frequency space as audio. The entry also supports decoding the produced waveforms using the `-d` flag. Usage instructions is output if run with the `-h` flag, albeit not in an immediately legible format.

Details
-------
In normal operation, the entry reads characters from one or more sources. If the `-h` flag is given, usage instructions is used as a source. Else if file paths are present as arguments those will be used. Else stdin is used.

If a character is part of the supported subset of ASCII `{10, 32-126}` then that character is output into frequency space of an audio signal (44.1 kHz single precision float, endianness should depend on system endianness) through stdout. Any other character will be interpreted and outputted as a space.

Characters are printed using a (slightly modified) pixel font based on [gohufont](https://github.com/hchargois/gohufont). Pixels are drawn using crosses in frequency space, achieved by simultaneous up and down chirps.

Each input source is designated its own channel in the output (one float per channel per time step in the output) so if you have a surround sound system you could listen to a cacophony of chirpy characters.

Interestingly, with training you might actually be able to tell characters just from hearing. But even without training you can easily read along with the printed characters and have the sound make sense with the look of the characters.

See image spoiler.png for an example spectrogram.

Limitations
-----------
There is no error checking done when opening files, so expect segfaults if you provide the wrong path to a file.

This program is bound to misbehave if int is less than 32 bits.

Flags will only be interpreted correctly if they are the first argument. Reading a file named `-d` or `-h` is fully possible if it is not the first file provided, even though I am not sure why you would want to do that.

Providing invalid/unexpected arguments to the decode flag will result in odd behavior. Some erroneous arguments cause segfaults (negative number of channels, channel id outside valid range). One argument in particular causes an infinite loop printing whitespace.

Techniques
==========

Obfuscation
-----------
A lot of the obfuscations done came naturally from trying to appease the size tool. To name some:

* One character names
* Merging of related (and not so related) arithmetic operations
* Short circuiting for flow control to replace some `if`s
* Some `#defines`, sadly

On the intersection of size and obfuscation is the data encoding, which was quite fun to design.

Some additional obfuscation was done to mathematical formulas. Somewhat known expressions was transformed into equivalent but less recognizable counterparts.

I have tried to avoid intentional red herrings in the code, although fishy statements are plentiful.


Data encoding
-------------
The large string in the beginning of the source file contains font data, encoded in base64 using characters in the range `' '` to `'_'`. The space was chosen as the zero because the data contains a lot of zeroes, and quite helpfully the size tool ignores whitespace even in strings. Without this fact the program would have been too large and the decoding feature would have had to go. Fortunately this hole in the size spec was readily available. :)

Characters in the font (5x8 pixels, 40 bits) is packed into 7 base64 digits (which was a pain to decode in minimal code).

Math
----
Note that even though floats are used for the waveforms, the standard math library is not used at all! Most arithmetic is done purely on integers. The only major exception is generating a table of sine values which are interpolated to give high resolution waveforms. Can you see when the generation is triggered, and how it is done?

A critical issue encountered was that having abrupt starts and ends of signals cause a lot of problems with spectral leakage which makes spectrograms hard to read and audio painful to listen to. To reduce spectral leakage a windowing function was used. Although the one used is quite well known, it is not in a form that should be familiar to anyone. What looks like a polynomial and quacks like a polynomial might not actually be a polynomial, at least not deep inside.

Printing a string
-----------------
The program was written to deal exclusively with file descriptors, so how would one go about printing a char array not from a file descriptor without adding additional logic? Answer: `ungetc` into stdin, one char at a time (to be standards compliant). This is used to print the usage instructions.

Compilation warnings
====================
Compiling using

    gcc -Wall -Wextra -pedantic

gives only `-Wmisleading-indentation` which is sensible considering the source code. While

    clang -Wall -Wextra -pedantic

is a bit more pessimistic and gives `-Wempty-body` (I like loops without bodies), `-Wstring-plus-int` (since apparently some people think string+int is a concatenation) and one of the weirder warnings I have seen from me splitting a negative constant with whitespace. Compiling using

    clang -Wall -Wextra -pedantic -Weverything

produces a few pagefuls of warnings and makes me feel generally bad about myself. :(

Misc
====
The reported size of the source code using the size tool is very intentionally 2018.


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
