## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./prog text_file output_length context_length random_seed
```


## Try:

When running this, ask yourself why it gets progressively slower when the
context length decreases:

``` <!---sh-->
    ./try.sh
```

```
    Performance depends on the number of same hashes found.
    Too many identical strings if the context length is small.
    -- Author
```


## Judges' remarks:

We were able to [write our own program](%%REPO_URL%%/2020/kurdyukov4/rand.c) performing the same trick using
the (still non-standard, for some reason) library function `memmem()`, but that
way it works too fast regardless of the context length, and it's much less fun.

The author wrote in reply:

<hr style="width:10%;text-align:left;margin-left:0">

Wow, amazing! Very fast, but there is a drawback to randomness.
If some string only appears after half the input, the first instance
of this string will have a 50% chance of occurrence.
Example:

```
    echo "00000000000000000000 01 02 02 02 02 02 02" > test.txt
    ./prog test.txt 1000 2 123
    # more twos in output
    ./rand test.txt 1000 2 123
    # more ones in output
```

```
    But this will happen very rarely on real data.
    -- Author
```

<hr style="width:10%;text-align:left;margin-left:0">


Try using the same random seed and varying the context size.

BTW: what on Middle-earth is `lámatyávë`? It's Quenya, one of the languages of
the Elves in Tolkien's Legendarium. It means sound taste (plural is `lámatyáver`)
and it refers to phonaesthesia - in other words, it refers to the pleasure of
sound and form of words. It's discussed in [Morgoth's
Ring](https://en.wikipedia.org/wiki/Morgoth%27s_Ring), volume X of [History of
Middle-earth &lpar;HoMe&rpar;](https://en.wikipedia.org/wiki/The_History_of_Middle-earth).
Now can you appreciate the award title a bit better?


## Author's remarks:

### Building:

``` <!---sh-->
    cc prog.c -o prog
```

### Usage:

This program generates random text from the provided dictionary using a Markov
chain, outputting to `stdout`.

``` <!---sh-->
    ./prog input.txt 2000 10 12345
```

Parameters are:

1. dictionary filename
    Need at least the size of the book, the more the better (1Mb); you can
    concatenate several books into one file. This should be a text file (not
    `.doc`/`.pdf`). You can feed it with books in `.fb2` format, metadata is
    filtered.  Whitespace characters are also filtered. For languages other than
    English, it's better to use ANSI encoding. You can use UTF, but you need to
    increase the chain length (if one ANSI character is encoded as two UTF bytes,
    then multiply chain length by two).

2. bytes to generate (limited to 1Mb)

3. chain length
    Randomness and performance depend inversely on this parameter and the size
    of the dictionary. If you feel that the bytes are generated too slowly, then you
    need to increase the length of the chain. This length means that any part of
    the output of this size in bytes exists somewhere in the dictionary.

4. random seed

### Example

You can try this with the inputs provided with
[2019/mills](../../2019/mills/index.html) from the IOCCC entries.


``` <!---sh-->
    $ ./prog Shakespeare.txt 2001 10 12345
```

produces:

```
    r sons, wives for them, as the hope I had it. This is the way they be not too ra
    sh a trial of you only. Therefore will not out of door? Nurse: Marry, bachelor,
    Have other some, he is in Rome: but where is Warwick frowns at his. PRINCE EDWAR
    D: Where is the light: But I will watch thy waking, what work he makes Amongst y
    ou? Come, sirs, We shall write to you, fortune and The hazard of much blood. I w
    ould to heaven, respective lenity, And fire-eyed fury be my convoy in the senten
    ced; 'tis too horrible, so bloody on the banks If they were created, Would bring
     them to our presence? FLORIZEL: And those his golden crown, What is six winters
    ? they are but Lewis and Warwick bids you come too late come from the king's fri
    end, and will do't; for, look you, sir, For still thy true servitor: I will rend
     an oak And peg thee in his knotty entrails till Thou hast hazel eyes: what eye
    but such an eye would spy out such a day to-morrow, or next day: He is within th
    e limit of the like, forsworn to love, Send her a story of more woe Than this is
     a merry ballad, but a very pretty one. MOPSA: Thou hast amazed me, My name is E
    lbow: I do lean upon, Now thou art: Thy tears are womanish; thy wild acts denote
     The unreasonably: come, you must: and there, I then do't to them? VOLUMNIA: Now
     the red pestilence hangs in our aim, which is yours. What is't your honour, as
    in war, since then, You have said before: My child is dead; or 'twere not 'long
    of him; but he, like you, lads; about your ears it is Menenius? Second Officer:
    Come, come, young wanton and effeminate boy, Takes on the hungry beach Fillip th
    e stars Shall bitterly begin his wooing that we have in hand are angry And frown
    ing brow to brow, ourselves, Still your own affections are devised, As blanks, b
    enevolences, and I thank thee for it. KING HENRY VI: Master lieutenant comes. Ma
    ster lieutenant comes. Master lieutenant, pray you,-- CORIOLANUS: What's that to
     him? CHRISTOPHER: At Pembroke, Sir James Blunt, And Rice ap Thomas with a virtu
```

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
