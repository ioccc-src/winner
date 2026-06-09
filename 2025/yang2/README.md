Award: Most magical word

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    echo Message | ./prog > output.c; cc output.c; ./a.out
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    echo Message | ./prog.alt > output.c; cc output.c; ./a.out
```


## Judges' remarks:

This is a fine example of [concatenative programming](https://en.wikipedia.org/wiki/Concatenative_programming_language).

Space matters in the output, but why does it also contain that single word?  And what does it all mean?


### A fun challenge

Create an alternative form of [prog.c](%%REPO_URL%%/2025/yang2/prog.c) (i.e., `prog.alt.c`)
that implements the compression algorithm used in the entry as a standalone
program outputting a bitstream, and compare its performance with `gzip -1`.

**UPDATE**: We are in the process of changing how we present fun challenges,
and present potential solutions to those challenges.  Please stay tuned for an update.


## Author's remarks:


### Synopsis

```
    gcc prog.c -o prog
    ./prog < input.txt > output.c

    g++ prog.c -o prog++
    ./prog++ < input.txt > output.c
```

### Details

A skilled mage only needs one magic to defeat most foes, and that's the
ordinary offensive magic, also known as "zoltraak".  Inspired by the
simplicity and versatility of this magic, we have created a language
that contains just "zoltraak".  No operators or operands or other
complications, just zoltraak.  Here is a sample zoltraak program that
outputs 216 `+` characters:

``` <!---zoltraak-->
    zoltraak
    zoltraak

    zoltraak




    zoltraak


    zoltraak

    zoltraak

    zoltraak
    zoltraak









    zoltraak
```

In 27 lines of code (9 lines of zoltraak plus 18 blank lines), we managed
to produce more bytes of output than what we put in.  Not bad!

We still need a way to turn code this into an executable, and writing
all these lines is rather tedious for large programs.  This IOCCC entry
(henceforth called "Fern") solves both problems: simply feed the desired
text through stdin, and Fern will produce C code on stdout.

``` <!---sh-->
    gcc prog.c -o prog
    ./prog < input.txt > output.c

    gcc output.c -o output
    ./output | diff input.txt -
```

Output C code starts with a few lines to define "zoltraak", followed
by a mix of zoltraak and blank lines.  Output is slightly compressed,
such that it's possible to get something smaller than the original input
depending on amount of redundancy present.  Obviously we can achieve a
higher compression ratio if we chose a shorter symbol than "zoltraak".
To use the more compact variant of zoltraak, compile Fern with a C++
compiler:

``` <!---sh-->
    g++ prog.c -o prog++
    ./prog++ < input.txt > output.c
```


#### Output features

All output comes with the same prelude.  All difference in behavior are
due to the zoltraak lines, the prelude is constant for all programs.

``` <!---sh-->
    ./prog < /dev/null > empty.c
    ./prog < input.txt > output.c

    head -`wc -l < empty.c` output.c | diff empty.c -
```

Concatenation of valid zoltraak code produces valid zoltraak code.
The output of the concatenated program will be the concatenated output
of the individual programs.

``` <!---sh-->
    ./prog < input1.txt > output1.c
    ./prog < input2.txt > output2.c
    cat input1.txt input2.txt > combined_input.txt

    cat output1.c output2.c > combined_output.c
    gcc combined_output.c -o combined_output
    ./combined_output | diff combined_input.txt -
```

It's possible to determine which part of the input was most redundant by
compiling and running the output with code coverage enabled.  You might
find the accompanying `annotate_zoltraak.pl` script helpful in annotating
the output code.  This script is compatible with both generated C code
and gcov output.

``` <!---sh-->
    ./prog < input.txt | perl annotate_zoltraak.pl > output.c
    gcc --coverage output.c -o output
    ./output > /dev/null
    gcov output.c
```

#### Encoder features

Encoder and generated output have been verified to work under these environments:

   * gcc/g++ 13.4.0 on Cygwin.
   * gcc/g++ 11.4.0 on Linux.
   * gcc/g++ 10.2.1 on Linux.
   * gcc/g++ 9.3.0 on JSLinux.
   * clang/clang++ 20.1.8 on Cygwin.
   * clang/clang++ 11.0.1-2 on Linux.
   * tcc 0.9.27 on JSLinux.

CRC32 of the source code is embedded in the code itself (4665726e), which spells out `Fern`.

Code layout is based on Fern from "Sousou no Frieren" (Frieren: Beyond Journey's End).

For people who prefer something different, there is also `prog.alt.c`,
which does exactly what it says on the tin.


### Design notes

Designing an one-symbol language and implementing a small driver to make
it acceptable to C compilers is a fun exercise.  This section provides
some rationales behind what we have implemented.  Readers are encouraged
to think about how they might implement their own one-symbol language
before reading further.

We would like to implement a system with these properties:

   * A "prelude" section with all the implementation details to make the whole program acceptable to a C compiler.  The prelude must be constant for all programs.
   * A "code" section containing zero or more occurrences of one symbol.  The code must be sufficiently general to be able to generate arbitrary output.

We will work backwards from how the code is designed, followed by the prelude implementation to make the code executable.


#### Code design

We can think of the code section as one large unary numeral where each
code symbol represents a `1`, and different output is encoded by varying
number of symbols.

```
    '+' = 1111111111111111111111111111111111111111111
```

It's possible to write programs this way, but it would be terribly
inefficient if we wanted to support arbitrary output since the code size
grows exponentially.  Instead, we will assume each symbol represents
varying number of `0` followed by a `1`, where the number of zeroes
is determined by the amount of whitespaces that precede each symbol.
This enables a more efficient binary system where we can just translate
`1` to symbols and `0` to spaces.

```
    '+' = 11010100 (least significant bit first)
```

But this trivial translation doesn't work because we can't encode trailing
zeroes, due to the fact that we can't detect trailing whitespaces.
One fix is to always append an `1` bit after outputting 8 bits of data.

```
    '+' = 11010100 1
```

Because `1` bits translate to symbols, it's more expensive to encode `1`
bits compared to `0` bits.  We can reduce the cost a bit by observing
that bit 5 is often set in most text files (because lowercase letters,
numbers, and common punctuation all have that bit set), so we can reduce
average output size for text data if we XOR all bytes with 0x20.

```
    '+' = 11010000 1
```

There are other per-byte optimizations that we can try, but instead of
going down that route, we implement a compression scheme similar to DEFLATE
(RFC 1951), by adding an instruction that repeats some previous output
sequence.  This instruction is encoded as `length + 0 + distance + 1`:

   * Length is number of bytes to output minus 3.  In other words, we wouldn't use a repeat instruction unless we observe at least 3 repeating bytes.  The trailing `0` following the length makes it possible to differentiate repeat instructions from output instructions.
   * Distance is offset minus 1 to the instruction that generates the desired repeating bytes.  Note that the offset here is measured in instruction units, and line number delta can be computed by multiplying offset by 9.  Part of the reason why we did not use a variable-length encoding scheme for both output and repeat instructions is to simplify encoding of repeat offsets.

We now have enough information to decode the 27-bit sample program near the beginning of this document.

```
    11010000 1 -> output '+' (0x2b ^ 0x20 = 0x0b)
    00101011 0 00000000 1 -> output 216 bytes starting from offset -1.
```

#### Prelude implementation

We would like a fixed prelude that is constant for all programs,
constructed in such a way so that we can append arbitrary number of code
lines and still have the end result being acceptable to a C compiler.
There are a bunch of small puzzles that we need to solve to get the
behavior we wanted:

   * How to arrange the code so that the only symbol that appears after the prelude is `zoltraak`?
   * How to measure the amount of whitespace between each `zoltraak`?
   * How to make sure that concatenation of valid zoltraak code is still valid zoltraak code?  We don't necessarily need this feature, but this is a behavior supported by a lot of compression utilities (gzip, bzip2, lzip, xz, zstd).

It's possible to solve all these by doing `#embed __FILE__` and parse
the zoltraak tokens at run time, but this means handling each `zoltraak`
as data as opposed to translating them to actual C code.  It would also
require a compiler supporting C23 or C++26.  Instead of `#embed`, all
of the above can be solved using basic preprocessor tricks available
since C89.  A prelude that supports just the output instruction (and no
repeat instructions) can be implemented in ~211 bytes.

There are at least two ways to implement the repeat instruction:
a straightforward implementation is to maintain a buffer of recently
printed bytes and copy from there.  A more convoluted implementation is
to jump back to the previous program location where we printed those
bytes, run the instructions until we have printed the desired number
of bytes, then return to the location after the repeat instruction.
Naturally we went with the convoluted implementation, not because it's
easy but because it's hard.  It's hard and costs more code (562 bytes,
whereas the straightforward way could be implemented in ~386 bytes).
But it does come with these features:

   * It's possible to implement the `zoltraak` instruction without any loops.
   * Number of times we execute each output instruction will be roughly equal to number of times that particular substring is referenced, so we can use code coverage tools to determine which parts of the original input was most redundant.
   * Because the redundant strings are addressed using instruction offsets as opposed to byte offsets, it's possible to reference certain substrings that can't otherwise be reached using 8-bit distances.  This results in better compression ratio for some inputs.  For example, it would cost ~35280 bytes to encode "12 days of Christmas" using the buffered method, but just ~13283 bytes to encode the same text using the jump-and-run method.

The jump-and-run method does require solving a few more puzzles:

   * How would the branch and return mechanism work, and how do we generate unique labels to serve as branch targets?
   * How do we branch to instructions with leading zeroes, given that the zero bits would translate to empty spaces?
   * What happens when we encounter more repeat instructions while executing a repeat instruction?
   * What possible runtime errors are enabled by this implementation, and now must be accounted for by the encoder?

Solution to these puzzles is left as an exercise for the reader.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
