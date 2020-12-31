# Most Compact

Chris Mills  
Twitter: @MisterXopher  


## Judges' comments:
### To use:

    make
    
    ./prog compressed_file.Z

### Try:

    printf '000I\236\f\31H\260\240\301\203' > ioccc.Z
    ./prog ioccc.Z 

    dd bs=1k count=4096 < /dev/urandom > test1
    compress < test1 > test1.Z
    time ./prog test1.Z | cmp - test1

    dd bs=1k count=4096 < /dev/zero > test2
    compress < test2 > test2.Z
    time ./prog test2.Z | cmp - test2

### Selected Judges Remarks:

Without ASCII art, the source code of this entry would have been exactly 256 bytes.
Compared to [1990/jaw](http://ioccc.org/years.html#1990_jaw), it is very impressive,
even taking into account the missing atob functionality. Now we wish for a compress(1)-like compressor
using a similar idea.

Why is the sad smiley on line 12 in that particular place?

## Author's comments:
The Program
===========

This program is in implementation of the unix `zcat(1)` command for printing
compressed files that have been created by the `compress(1)` command.

The adaptive [LZW](https://en.wikipedia.org/wiki/Lempel–Ziv–Welch) compression
employed by `compress` usually requires a fairly large amount of memory to
build the decompression tables (in fact, `compress` has a command-line option
to control the size of the decompression tables, since some of the early
systems to which it was ported (*cough*MS-DOS*cough*) did not have enough
memory to use the full 16-bit codes).  This version has no large static or
dynamic tables.  It is able to decompress 16-bit files using a single function
and a few ints.

To run the program, take an existing compressed file and pass it to the program
on the command line.  On the odd chance you don't have `compress` hanging about
on your system, I've provided compressed copies of this year's IOCCC rules
and guidelines files.  To print them, just do

    ./prog ioccc_guidelines.txt.Z

The Details
-----------

The basic cleverness here comes from realizing that the compressed data is
itself an encoded version of the code dictionary.  When the encoder sees
an input string that is not in its dictionary, it emits the code corresponding
to the longest prefix that is in the dictionary and adds a new entry consisting
of that code followed by the next input character.  This means that when the
decoder wants to know how to decode a code, it just needs to find the spot in
the code-stream where the encoder added that entry to the dictionary.  The
code at that spot is the prefix, and the first character of the following code
is the suffix.  Decoding then just becomes recursion, to follow the chain of
prefixes and suffix characters.

Of course, it's not nearly that simple.  Finding the code in the stream is
complicated by several issues:

 * Codes are at bit offsets within the stream, and must be extracted.
 * As codes are added to the dictionary, the code word size grows, so finding
   the offset to a particular code word is involved.
 * The `compress` encoder reserves a code word that clears the coding tables.
   When this is encountered, the computation of offsets and bit sizes reset.
 * The `compress` decoder is designed to always read a block of eight code
   words at the same time, so that it need only read N bytes to get eight N-bit
   code words.  When the "clear" code is encountered, the entire eight-word
   block is flushed (since the decoder didn't know the word size would change).
   The program needs to account for this extra flushing.
 * The end of the stream is not explicitly marked; the encoder just pads out
   the output to the next byte.  The decoder must notice this to know when
   to stop.
 * The output stream contains a header that must be skipped.

Managing all the details involved added a lovely additional layer of
obfuscation to the otherwise elegant recursive decoder.  Still, the code
manages it in a remarkably small amount of code.

Limitations
-----------

The decoder doesn't look at the header.  If you supply something that is not
compressed data, it's likely to crash in an interesting manner.

In particular, it doesn't look at the third byte of the header, which encodes
the maximum code word size and whether "block mode" was used when the encoder
was run.  If you use `compress` in its default mode, the maximum word size
will be 16 bits and "block mode" will be enabled.  You are unlikely to find
any files that don't use "block mode", since all versions of `compress` after
2.0 (circa 1984) use it by default and have no documented way to disable it.
Reducing the bit depth is still possibly by using the `-b` flag.  Modern
systems have no problem with the 200 KB or so needed for 16-bit decoder
tables, so the need for reducing the table size has passed, hence this program
always assumes 16-bits...  However, should you find a file that needs a
smaller table, feel free to change the hard-coded 16 in the source into the
appropriate number and recompile.

In the event that you don't supply an argument, or that argument doesn't name
a readable file, the program will just silently exit.  This is a feature.

The program depends on having a little-endian system.  On a big-endian system
you will get a wierd big-endian version of `compress`, which might have come to
pass in an alternate universe where the vax on which `compress` was authored
had been big-endian.  Luckily for us, it wasn't, and neither are most of the
systems you might want to compile this for.


--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2016, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
