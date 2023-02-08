# Most alphabetic

Marcin Ciura  
Twitter: @mciura  


## Judges' comments:
### To use:

    make

    ./getwords.sh en | grep .. | ./prog aeiouvwxyz

### Try:

    ./getwords.sh en | grep .. | ./prog aeiouhjklmnvwxyz

    ./getwords.sh en | grep .. | ./prog mrjocktvquizphdbagsfewlynx

    ./en.sh

    ./fr.sh

    ./ru.sh

### Selected Judges Remarks:

A few letters, one at a time, with no repeats.
How many different ways can this be done?

While a quick brown fox might jump over the lazy dog,
it has too many repeat letters to allow this entry to repeat.
It is better that Mr Jock, TV quiz PhD, bags few lynx.

Speaking of jumping, can you rewrite the code to
remote all of the goto jumps in this code?

## Author's comments:
### What is this? <a name="wit"></a>

This entry reads from standard input a list of words in any language
written with an alphabet and outputs perfect pangrams composed of these
words. A perfect pangram is a series of words that contains every letter
of the alphabet exactly once.

Example execution:

    $ grep .. /usr/share/dict/words | ./prog abcdefghijklmnopqrstuvwxyz
    qualm fjord wiz pyx vs beg kc nth
    quartz jinx vs fed kc womb glyph
    quid jamb fez vs pyx kc growl nth
    quiz fjord pyx vs bag kc mewl nth
    quiz fjord pyx vs gab kc mewl nth
    quiz fjord pyx vs gem bawl kc nth
    quiz fjord pyx vs meg bawl kc nth
    quiz fjord vex bawl kc gyp ms nth
    quiz jamb flex vs kc gyp word nth
    quiz jamb pyx vs kc flog drew nth
    quiz jamb pyx vs kc frog lewd nth
    quiz jamb pyx vs kc frog weld nth
    quiz jamb pyx vs kc golf drew nth
    quiz jamb pyx vs kc grew fold nth
    quiz jamb pyx vs kc grow nth fled
    quiz jamb pyx vs kc growl fed nth

Rearranging the words into more or less meaningful expressions is the
user's duty.

This entry implements Algorithm X (_Exact cover via dancing links_)
from Section 7.2.2.1 in fascicle 5C of _The Art of Computer
Programming_ by Donald E. Knuth. As of June 2019, you can download an
incomplete draft of the fascicle from [Knuth's
website](https://www-cs-faculty.stanford.edu/~knuth/fasc5c.ps.gz).

### Usage

**`prog LETTERS [N]`**
reads allowed words from standard input and writes perfect pangrams
with at most _N_ words composed of _LETTERS_ to standard output, one
per line. If _N_ is not given, the number of words in the pangrams is
unlimited. The characters in _LETTERS_ must not repeat. The length of
_LETTERS_ must not exceed 97 characters.

The exit status is 0 if no error occurred, 1 if the input word list
is too long, and 2 if the command-line arguments are missing.

### Helper scripts

**`getwords.sh LANGUAGE_CODE`**
outputs a sorted list of unique words in a given language, one per
line. It requires **`aspell`** with a dictionary for _LANGUAGE_CODE_.

**`wrapprog.py LETTERS [N]`**
works similarly to **`prog LETTERS [N]`** except that it merges
anagrams before passing them to **`prog`** and expands them in
**`prog`**'s output. This way, it finishes the job faster than
**`prog`** when there are millions of perfect pangrams. It requires a
UTF-8 locale.

**`de.sh`**, **`en.sh`**, **`fr.sh`**, **`it.sh`**, **`pl.sh`**,
and **`ru.sh`** output German, English, French, Italian, Polish,
and Russian perfect pangrams, respectively. They require a UTF-8
locale.

### Miscellaneous remarks

I dare submit this entry to categories _algorithms_,
_internationalization_ (I have not found active use of **`<wchar.h>`**
among the programs that won IOCCC in the past), and _obscure bugs_ (see
the questions about Linux core dumps below).

To a casual eye, this entry may look similar to
[2005 klausler](https://www.ioccc.org/years.html#2005_klausler).
However, **`prog`** is internationalized and way faster. On my machine,
**`./klausler abcdefghijklmnopqrstuvwxyz`** printed only 3,965 perfect
pangrams until I killed it after 144 hours running, while the
equivalent
**`tr A-Z a-z < /usr/share/dict/words | egrep -v '^[^ais]$' | ./prog abcdefghijklmnopqrstuvwxyz | wc -l`**
finished in 62 minutes, reporting 1,640,569,315 perfect pangrams, and
the example from section [What is this?](#wit) finished in 1.35
seconds. On the other hand, **`prog`** can only output series of words
with nonrepeating characters, unlike **`klausler`**.

In contrast to **`prog.orig.c`**, **`prog.c`** does not call
**`fflush(stdout)`** after outputting each line, thus running faster.
I am grateful to Witold Jarnicki for suggesting this change.
The original **`prog`** finished the example above in 100 minutes
instead of 62 minutes.

If your word list contains meaningless one-letter words, pipe
**`grep .. [FILE]`** through **`prog`** to eliminate the pangrams that
contain them.

According to **`prog`** and **`aspell`**, some languages, e.g. Spanish,
have no perfect pangrams.

Why does **`yes | ./prog y`** hang on Linux? Change **`static int`** to
**`int`** and **`static wchar_t`** to **`wchar_t`**, and recompile
**`prog`**. Why does **`yes | ./prog y`** dump core now? Change the line
**`#define P 9<<23^1`** to **`#define P 9<<23`** and recompile
**`prog`**. Why does **`yes | ./prog y`** exit gracefully?

Answer: Nf bs Whar 2019, guhf znavsrfg ohtf va **`tyvop`** 2.22--2.29:
[1](https://sourceware.org/bugzilla/show_bug.cgi?id=20568) naq
[2](https://sourceware.org/bugzilla/show_bug.cgi?id=20632).

The source code uses **`goto`** three times. While it could easily get
by without **`goto M`** and **`goto H`**, I challenge the adherents of
structured programming to refactor **`goto T`**, which jumps back into a
nested **`if`** block.

With the supplied **`Makefile`**, both **`gcc`** and **`clang`** compile
**`prog.c`** without warnings in C11 and C99 mode. For a clean
compilation with **`gcc -std=c90`**, add **`-Wno-format`** to
**`CSILENCE`** in **`Makefile`**.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
