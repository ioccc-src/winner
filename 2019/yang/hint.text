# Most in need of transparency

Don Yang  
<http://uguu.org/>  


## Judges' comments:
### To use:

    make

    ./prog sample_input.txt a b c d

    cat a

    cat b

    cat c

    cat d

    cat a b c d | ./prog

### Try:

    ./prog prog.c a b c d e

    cat a

    cat b

    cat c

    cat d

    cat e

    cat a b c d e | ./prog

    cat a b c d e | ./prog | diff - prog.c

### Selected Judges Remarks:

Do you understand how this program works?
You may have to go over and over the output again.

## Author's comments:
# Summary

Scramble/unscramble to single file:

    ./prog original.txt > scrambled.txt

    ./prog < scrambled.txt > unscrambled.txt

Scramble/unscramble to multiple files:

    ./prog input.txt output1.txt output2.txt ...

    cat output1.txt output2.txt ... | ./prog > unscrambled.txt

Re-scramble:

    ./prog original.txt | ./prog - > scrambled1.txt
    ./prog original.txt | ./prog - | ./prog - > scrambled2.txt
    ./prog original.txt | ./prog - | ./prog - | ... > scrambled3.txt

Scramble slowly:

    ./prog input.txt | ruby prog.c

Input must be in UTF-8 encoding.

# Details

This is a text scrambling utility.  To scramble text, specify input
file name as the first argument:

    ./prog input.txt > output.txt

If original input file was small enough to fit in your terminal, you
can simply use `cat` to unscramble the output text.

    cat output.txt

It might seem like nothing was scrambled, but you can try passing the
output through `strings(1)` and see that most of the original strings
are gone.  What happened is that the original text has been shuffled
with ANSI cursor positioning codes inserted such that characters are
printed in random order.  This effect is more visible if there is a
delay after each character is printed.  For convenience, an utility is
included in the source to output characters slowly:

    ./prog input.txt | ruby prog.c

Scrambling order is deterministic, but you can reshuffle the output by
piping it through the same utility again, by specifying `-` as the
first argument:

    ./prog input.txt | ./prog - | ./prog - | ...

You can also split the input to multiple files, each getting a subset
of the original input characters:

    ./prog input.txt output1.txt output2.txt ...
    cat output1.txt output2.txt ... > unscrambled.txt

You can only unscramble files with `cat` if the input fits in a single
terminal screen.  If you don't know what will be the terminal size of
the recipient, note that `prog.c` will fit in a 80x25 terminal, so a
good guideline is to pick files that have fewer rows and columns than
`prog.c`.

For files that are larger than your terminal window, `cat` will not be
sufficient for unscrambling because any scrolling causes the character
positions to be misaligned.  But fear not, this utility also includes
unscrambling functionality.  If no argument is specified, input will
be read through stdin and unscrambled to stdout:

    ./prog < scrambled.txt > unscrambled.txt

Where this is useful is that if you scramble the input to multiple
files and unscramble each output files individually, those output
files can be printed on transparencies and distributed separately.

    ./prog input.txt output1.txt output2.txt output3.txt
    ./prog < output1.txt > layer1.txt
    ./prog < output2.txt > layer2.txt
    ./prog < output3.txt > layer3.txt

In other words, this is a utility for facilitating
[visual cryptography](https://en.wikipedia.org/wiki/Visual_cryptography).

This utility can also be used just for removing trailing whitespaces
and expanding tabs to 8 spaces.

    ./prog input.txt | ./prog

# Features

## UTF-8 support

A simple text scrambling utility might not have required a screenful
of code, but this particular one natively supports UTF-8.
Specifically: individual UTF-8 byte sequences will not be split into
broken ones, and the utility is aware of full-width versus half-width
differences such that cursor is positioned correctly for most CJK
input.  `sample_input.txt` demonstrates this feature with a mix of
Basic Latin and Japanese characters.

Output cursor positions will most definitely be wrong for inputs
containing combining characters and right-to-left text, but it should
be possible to unscramble those text back to the original using this
same utility, since the utility is self-consistent in how cursor
positions are handled.

## Error handling

If any file can not be opened for reading or writing, an error is
printed to stderr, and the utility will exit with nonzero status.

If there isn't enough memory, the utility will likely crash.

If input contains CR-LF end of line sequences, those CRs are silently
dropped.  In fact, most control codes are silently ignored except line
feeds (preserved) and tabs (expanded to 8 spaces).

## Compatibility

Verified to work and compiles without warnings on these environments:

   * gcc 7.3.0 on Linux
   * gcc 7.4.0 on Cygwin
   * clang 4.0.1-10 on Linux
   * clang 5.0.1 on Cygwin
   * gcc 4.8.4 on Linux

## Full version

I tried really hard to make `prog.c` fit in a 80x25 terminal without
wrapping.  If I were not constrained by space, I would have made an
ASCII art out of it.  `violet.c` is that program, and also comes with
the minor benefit of supporting lines longer than a million columns
depending on `sizeof(int)`.

Violet is named after "Violet Evergarden", the character who is highly
skilled in writing letters.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
