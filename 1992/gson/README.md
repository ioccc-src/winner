## To build:

``` <!---sh-->
    make all
```

**NOTE**: we **FORCE DISABLE** the optimiser because having it enabled causes
some invocations to crash in some systems.


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: uses gets() - change to fgets() if possible
```

For more detailed information see [1992/gson in bugs.html](../../bugs.html#1992_gson).


## To use:

``` <!---sh-->
    ./ag word word2 word3 < /path/to/dictionary
```


## Try:

``` <!---sh-->
    ./try.sh
```

This script will determine (or try and determine) where your system dictionary
is located and assuming that it can find one it'll use that. It checks the
following locations though the last one is more ironic:

```
    /usr/share/dict/words
    /usr/share/lib/spell/words
    /usr/ucblib/dict/words
    /dev/null			# <-- for machines with nothing to say
```

Then using the proper dictionary file it does:

``` <!---sh-->
    ./ag free software foundation	< /usr/share/dict/words
    ./ag obfuscated c contest	< /usr/share/dict/words
    ./ag unix international		< /usr/share/dict/words
    ./ag george bush		< /usr/share/dict/words
    ./ag bill clinton		< /usr/share/dict/words
    ./ag ross perot			< /usr/share/dict/words
    ./ag paul e tsongas		< /usr/share/dict/words
```

where `/usr/share/dict/words` is the dictionary file.

Then it uses the [mkdict.sh](%%REPO_URL%%/1992/gson/mkdict.sh) script to create a dictionary file out
of the files [index.html](index.html), [try.sh](%%REPO_URL%%/1992/gson/try.sh) (itself) and
[Makefile](%%REPO_URL%%/1992/gson/Makefile) and it repeats the same commands as above. In the case no
dictionary file can be found in the first step it only runs the commands once
with the created dictionary file.


## Judges' remarks:

Recently some newspapers printed amusing anagrams of one of the
names listed above.  Run this program to find the anagrams they
weren't allowed to print!

The author provided an obfuscated script that can be used to construct
dictionaries which has been put in as [mkdict.sh](%%REPO_URL%%/1992/gson/mkdict.sh). To use try:

``` <!---sh-->
    cat README.md | ./mkdict.sh > words
```

Then try using the program as shown above with the file `words`.


## Author's remarks:

The name of the game:

AG is short for either Anagram Generator or simply AnaGram.  It might also be
construed to mean Alphabet Game, and by pure coincidence it happens to be the
author's initials.


### What it does

AG takes one or more words as arguments, and tries to find anagrams of those
words, i.e. words or sentences containing exactly the same letters.


### How to use it

To run AG, you need a dictionary file consisting of distinct words in the
natural language of your choice, one word on each line.  If your machine doesn't
have one already, you can make your own dictionary by concatenating a few
hundred of your favourite Usenet articles and piping them through the following
obfuscated shell script:

``` <!---sh-->
    #!/bin/sh
    z=a-z];tr [A-Z\] \[$z|sed s/[\^$z[\^$z*/_/g|tr _ \\012|grep ..|sort -u
```

Using articles from alt.folklore.computers is likely to make
a more professional-looking dictionary than rec.arts.erotica.

AG must be run with the dictionary file as standard input.

Because anagrams consisting of just a few words are generally more
meaningful than those consisting of dozens of very short words, the
number of words in the anagrams is limited to 3 by default.  This
limit can be changed using a numeric command line option, as in
`./ag -4 international obfuscated c code contest </usr/dict/words`.

### Bugs and limitations

- There is no error checking.
- Standard input must be seekable, so you can't pipe the dictionary into AG.
- The input sentence and each line in the dictionary may contain at most 32
distinct letters, and each letter may occur at most 15 times.
- Words in the dictionary may be at most 255 bytes long.
- AG cannot handle characters that sign-extend to negative values.
- Although AG works on both 16-bit and 32-bit machines, the size of the problems
it can solve is severely limited on machines that limit the stack size to 64k or
less.


### Obfuscatory notes

As you can see, AG takes advantage of the new '92 whitespace rules' to
achieve a clear, readable, self-documenting layout.  The identifiers
have been chosen in a way appropriate for an alphabet game, and common
sources of bugs such as goto statements and malloc/free have been
eliminated.  As AG also refrains from abusing the preprocessor, it
doesn't really have much to offer in terms of "surface obfuscation".
Instead, it tries to achieve both its speed and its obscurity through a
careful choice of algorithms.  Some of the finer points of those
algorithms are outlined in the spoiler below.


### How it works:

Here follows a description of some of the data structures and
algorithms used by AG.  It is by no means complete, but it may help
you get an idea about the general principles.

<hr style="width:10%;text-align:left;margin-left:0">

Internally, AG represents words and sentences as arrays of 32
4-bit integer elements.  Each element represents the number of
times a letter occurs in the word/sentence.  There are 32 elements
because 32 is a convenient power of two larger than the number of
letters in most western alphabets, and the elements are 4 bits
each because the same letter is unlikely to occur more than 15
times in a practical anagram generation problem.

These `32*4`-bit arrays are actually stored in memory in a
"bit-transposed" format, as arrays of four `long` values.  It is
assumed that a `long` is at least 32 bits.  The first 4-bit letter
count is formed by the least significant (`2^0`) bit in each of the
four `long`s, the next one is formed by the `2^1` bits, etc.

This storage format makes it possible to add or subtract two such
vectors of 32 4-bit values in parallel by simulating a set of 32
binary full adders in software using bitwise logical operations.
E.g., all the LSBs of the result are formed in parallel by taking
the exclusive OR of the LSBs in each summand, and 32 carry bits
are formed in parallel in a similar way using a logical AND.
Thus, 32 independent 4-bit additions can be performed by just four
iterations of a loop containing some 32-bit bitwise logical
operations, but no arithmetic operations other than those implied
by array indexing.

Subtraction works similarly, and in fact AG only implements
subtraction directly, handling addition by means of the identity
`a+b = a-(0-b)`.

In addition to this `32*4`-bit representation, AG also forms a so-called
"signature" that is the bitwise OR of the four `long`s, which is
equivalent to saying that the signature of a word contains a logical 1
in the bit positions corresponding to letters occurring at least once
in that word.

The first thing AG does is to construct a lookup table of 256
`long`s, one for each 8-bit character value.  The entry for a
character will be zero if that character doesn't appear in the
sentence given on the command line, or it will have a single bit
set if the character does appear in the sentence.  By adding
together the bit masks for all the letters in the input sentence
using the transpose addition method described above, AG forms the
`32*4` bit array representation of the input sentence.

The next action performed is reading the dictionary.  Those words that
contain letters not in the input sentence are immediately discarded.
Words containing the right letters but in excessive numbers are
eliminated in a separate check involving the `32*4` bit array.

The remaining words, which will be referred to as "candidate words",
are stored in `32*4`-bit representation, together with their signatures
and offsets into the dictionary file so that the plain-text version of
a word can later be found for printing.  This information is kept in a
local `struct` in the dictionary-reading function, and memory is
allocated for each candidate word simply by making another recursive
call to that function.

Each `struct` so allocated is linked into a fixed-size hash table of
4096 entries indexed by the 12 low bits of the word's signature.
When the dictionary-reading function encounters end-of-file, all the
candidate words have been stored in nested activation records on the
stack, accessible through the hash table.

Generating the anagrams is then done by traversing the hash table and
subtracting the letters of each word in the hash table from the
"current sentence", which initially is the sentence given on the
command line.

The subtraction is performed in parallel on the 4-bit letter counts
as described above, and if all 32 results are zero, an anagram has
been found.  If the result is negative for one or more of the letters
(as indicated by one or more `1`s in a vector of 32 borrow bits
returned by the subtraction routine), the word did not match the
current sentence and is ignored.  Finally, if the result contained
only non-negative letter counts, we have found a partial anagram:
a word containing some, but not all, of the letters in the current
sentence.  In this case we recursively try to find an anagram of the
remaining letters.  The depth of the recursion is limited to the
maximum number of words in the anagram, as specified by the user.

When the deepest recursion level has been reached, an optimization can
be applied: because no further recursion will be done, there is no
need to look for partial anagrams, and therefore AG only needs to
check for words that contain exactly the same letters as the current
sentence.  Those words can be found simply by indexing the hash table
with the signature of the current sentence.

Even when not on the deepest recursion level, AG generally avoids
examining all the entries of the hash table.  The idea is that we are
not interested in hash buckets whose words contain any letters not
in the current sentence; these buckets are exactly those whose index
has a logical one in a bit position where the signature of the current
sentence has a zero.  Put another way, we want to loop through only
those hash bucket indices `i` that contain zeroes in all the bit
positions where the signature `s` of the current sentence contains
a zero; this can be expressed in C as (`i & ~s == 0`).

It is possible to loop through all such numbers in an efficient way by
taking advantage of certain properties of binary arithmetic: by
forcing the bits corresponding to zeroes in `s` to ones, we can make
the carries generated in incrementing `i` propagate straight across
those bits that should remain zero.  For example, the following
program prints all those 16-bit integers that contain zeroes in all
even bit positions:

``` <!---c-->
    main(){int i=0,s=0xAAAA;do{printf("%04x\t",i);}while(i=((i|~s)+1)&s);}
```

AG uses a similar method but works in the opposite direction, finding
the next lower value with zeroes in given bit positions by propagating
borrows across those bits.  Some additional adjustments are made
to the hash table index when initiating a recursive search, using
similar bit-twiddling techniques.

Whenever an anagram has been found, it is printed by traversing a
linked list formed by `struct`s in the activation records of the
recursive invocations of the search function, seeking to the beginning
of the word matched by that invocation, and copying the characters of
the word directly from standard input to standard output.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
