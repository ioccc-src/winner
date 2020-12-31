# Most likely to be awarded

Marcin Ciura <mciura@gmail.com>  
Twitter: @mciura  


## Judges' comments:
### To use:

    make

    ./prog < text

### Try:

    ./prog < Makefile
    ./prog < hint.text

### Selected Judges Remarks:

This text was processed by prog. You may get confused.
We're not really sure: prog.c wasn't commented.
Who has been thoroughly puzzled by prog? Also how obfuscated is prog?
Having been written in C, how large of a vocabulary has it?


## Author's comments:
The Program
===========

"The Elements of Style" by prof. William Strunk, Jr. and E. B. White
is well known for its dislike of the passive voice.  Direct, vigorous,
active constructions were instead recommended by the authors.
The development of this program has been driven by this tenet.

Only passive sentences from the standard input are output.  The offending
part(s) of each sentence will be highlighted.  Several kinds of passive
constructions are recognized:

* Plain passive voice.
  Foo was bazzed by bar.
* Passive voice with "get".
  I got almost quuxed.
* Contractions.
  I'm not really quuxed: foo wasn't bazzed.
* Questions.
  Who has been quuxed?  Was foo indeed bazzed?  How was it bazzed?
* Clause-initial inversion.
  Also bazzed is bar.

Sentences are never broken by periods that follow abbreviations and
initials.  Both regular and irregular past participles are properly
dealt with.  Note that some words are red herrings: even though their
ending is -ed, they are not past participles.

The Big String
==============

Here is the purpose of every byte inside the **`c[]`** string:

* 0-9:  highlighting passive constructions in the output;
* 10-50:  classifying characters - called by **`V(4)`**;
* 52:  outputting the newline character;
* 51-187:  tokenizing text and detecting passive constructions - two
  type A state machines, called by **`V(2)`** and **`V(3)`**;
* 186-2786:  determining word categories (past participles, present
  simple and past simple forms of "to be", other forms of "to be",
  adverbs, wh-words, and other words) and recognizing abbreviations -
  two type B state machines, called by **`V(808)`** and **`V(205)`**.

The State Machines
==================

I heard you don't like state machines so I put a state machine in your
state machine so you can reject this entry while you reject this entry.

Both types of state machines in the program are Mealy machines: we can
think of their transitions as triples (**`transition_label`**,
**`next_state`**, **`output`**).

Type A
------

A state of type A state machine consists of eight transitions whose
representations occupy consecutive bytes.  The byte
**`c[3 + 8*state + transition_label]`** contains
**`(unsigned char)(30 + 5*next_state + output)`**.

The `transition_label` is either one of character classes:

* **`nil`** = 0,
* **`space`** = 1,
* **`new_line`** = 2,
* **`uppercase`** = 3,
* **`lowercase`** = 4,
* **`period`** = 5,
* **`bang_question`** = 6,
* **`punctuation`** = 7,

or one of word classes:

* **`adverb`** = 0,
* **`other`** = 2,
* **`past_participle`** = 3,
* **`to_be`** = 4,
* **`are_were`** = 5,
* **`wh_word`** = 6 (cf. the **`output`** of type B state machines).

The **`output`** is either one of:

* **`end_of_text`** = 0,
* **`sentence_start`** = 1,
* **`sentence_end`** = 2,
* **`token_end`** = 3,
* **`ignore`** = 4,

or one of

* **`passive_construction_start`** = 1,
* **`ignore`** = 2,
* **`passive_construction_end`** = 3.

Type A state machines run continuously.  Their state is kept in
**`k[2]`** and **`k[3]`**.

Below are sample steps of scanning a sequence of characters with
classes **`uppercase`**, **`lowercase`**, **`period`**, **`space`**,
and **`uppercase`**.

* **`state`** = 7, **`transition_label`** = 3 (**`uppercase`**), **`output`** = **`sentence_start`**
* **`state`** = 14, **`transition_label`** = 4 (**`lowercase`**), **`output`** = **`ignore`**
* **`state`** = 15, **`transition_label`** = 5 (**`period`**), **`output`** = **`token_end`**
* **`state`** = 13, **`transition_label`** = 1 (**`space`**), **`output`** = **`token_end`**
* **`state`** = 18, **`transition_label`** = 3 (**`uppercase`**), **`output`** = **`sentence_end`**

And here are sample steps of scanning tokens with classes **`to_be`**,
**`adverb`**, **`past_participle`**.

* **`state`** = 8, **`transition_label`** = 4 (**`to_be`**), **`output`** = **`passive_construction_start`**
* **`state`** = 22, **`transition_label`** = 0 (**`adverb`**), **`output`** = **`ignore`**
* **`state`** = 22, **`transition_label`** = 3 (**`past_participle`**), **`output`** = **`passive_construction_end`**

Type B
------

Type B state machines are built by a variant of the algorithm described
in the paper
*[How to squeeze a lexicon](http://sun.aei.polsl.pl/~mciura/publikacje/lexicon.pdf)*.
Their states are represented as interlaced sparse arrays of transitions.

The **`transition_label`** is one of:

* **`word_start`** = 0,
* **`period_or_apostrophe`** = 1,
* **`a_z_letter`** = 2..27.

The `output` is either one of word classes:

* **`adverb`** = 0,
* **`ignore`** = 1,
* **`other`** = 2,
* **`past_participle`** = 3,
* **`to_be`** = 4,
* **`are_were`** = 5,
* **`wh_word`** = 6,

or

* **`ignore`** = 1,
* **`abbreviation`** = 2.

The byte **`c[186 + (state + transition_label)] = (unsigned char)(2 + transition_label + 28 * output)`**.

The byte **`c[836 + 2*(state + transition_label)] =`**

* **`' '`** when **`next_state / 376 == 0`**,
* **`';'`** when **`next_state / 376 == 1`**.

The byte **`c[837 + 2*(state + transition_label)] =`**

* **`' '`** when **`next_state / 94 % 4 == 0`**,
* **`';'`** when **`next_state / 94 % 4 == 1`**,
* **`'{'`** when **`next_state / 94 % 4 == 2`**,
* **`'}'`** when **`next_state / 94 % 4 == 3`**.

The byte **`c[2136 + (state + transition_label)] = (unsigned char)(32 + next_state % 94)`**.

A type B state machine starts in a given **`state`** with **`output`**
set to **`ignore`**.  It scans a word backwards, converting character by
character to **`transition_label`**.  When it meets **`word_start`**, it
returns, leaving the most recently stored **`output`** in **`v`**.
It also returns when
**`c[186 + (state + transition_label)] != (unsigned char)(2 + transition_label + 28 * output)`**,
i.e. when the **`transition_label`** in the byte mismatches the
**`transition_label`** used to compute the index.  Otherwise, if the
**`output`** in this byte differs from **`ignore`**, the state machine
stores it in **`v`**.  Regardless of the value of the **`output`**,
it also assigns **`next_state`** to **`state`** and proceeds to scan
the previous character.  The state machine that determines the word
class is set up so that it never returns **`ignore`**.

Below are sample steps of scanning the word "chiefly".

* **`state`** = 623, **`transition_label`** = 26 ('y'), **`output`** = **`other`**
* **`state`** = 602, **`transition_label`** = 13 ('l'), **`output`** = **`adverb`**
* **`state`** = 594, **`transition_label`** = 7 ('f'), **`output`** = **`other`**
* **`state`** = 549, **`transition_label`** = 6 ('e'), **`output`** = **`ignore`**
* **`state`** = 543, **`transition_label`** = 10 ('i'), **`output`** = **`adverb`**
* **`state`** = 0, **`transition_label`** = 9 ('h') mismatches the value stored
in the byte.  Return **`adverb`**.

And here are sample steps of scanning the string "i.e.":

* **`state`** = 19, **`transition_label`** = 1 ('.'), **`output`** = **`ignore`**
* **`state`** = 24, **`transition_label`** = 6 ('e'), **`output`** = **`ignore`**
* **`state`** = 3, **`transition_label`** = 1 ('.'), **`output`** = **`ignore`**
* **`state`** = 2, **`transition_label`** = 10 ('i'), **`output`** = **`ignore`**
* **`state`** = 1, **`transition_label`** = 0 ('\0'), **`output`** = **`abbreviation`**.
Return **`abbreviation`**.

Remarks
=======

The judges found a bug in the handling of contractions: **`prog.orig.c`**
outputs "foo wasn'**[t bazzed]**".  I fixed the bug in **`prog.c`**, making
it output "foo **[wasn't bazzed]**" instead, and took the liberty to merge
one statement into a **`for`** loop inside its **`main()`** function.

The program uses a 9,437,187-byte buffer so it probably will not run
on 16-bit and smaller machines without changing the size of array **`C[]`**
and the expression **`9<<20`** inside the call to **`read()`**.

I have tested it on:

* Linux with gcc version 5.4.0 20160609,
* Linux with clang version 3.4-1ubuntu3,
* OS/X with Apple LLVM version 6.0 (clang-600.0.57).

For a clean compile under c89 and c90, add **`-Woverlength-strings`**
to **`CSILENCE`**.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
