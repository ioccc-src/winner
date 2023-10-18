# Best use of python

Yusuke Endoh\
<https://github.com/mame/>\
Mastodon: [@mame@ruby.social](https://ruby.social/@mame)

## To build:

```sh
make
```

## To run:

```sh
./prog
```

## Try:

```sh
./prog | tee prog_next.c
make prog_next
./prog_next | tee prog_next.c
make prog_next
./prog_next | tee prog_next.c

make python

make python3
```

NOTE: to interrupt the loop send intr (typically ctrl-C).

## Judges' remarks:

And now for something completely different: A program whose metabolic
processes are a matter of interest only to historians. It has kicked the bucket
and departed to that mysterious country from whose bourne no traveller returns!
This is an EX-tremely obfuscated program!

## Author's remarks:


A high-context work that combines parrots that new hackers like and parrots that
old hackers like. One is an internet meme called [Party
Parrot](https://cultofthepartyparrot.com). The other is a
sketch (comte) called ["Dead
Parrot"](https://en.wikipedia.org/wiki/Dead_Parrot_sketch) from the British
comedy TV show ["Monty Python's Flying Circus"](https://en.wikipedia.org/wiki/Monty_Python%27s_Flying_Circus)
The "_Python_" in the award name refers to Monty Python, **not** the
[programming language Python (the name of the programming language Python is
derived from Monty
Python)](https://en.wikipedia.org/wiki/Python_(programming_language).


The shape of prog.c is "Undead Parrot" based on "dead parrot". The message that
appears in the bottom line of the output source code is the subject of the
dialogue that appears in "Dead Parrot" and explains in various expressions that
the parrot died. Also, the second **__<-_Source_of_Parrots__** line from the bottom
<http://cultofthepartyparrot.com/> has a hidden URL (hidden by the parrot's body).

Although it is a boring Quine story, it is quite difficult to have 10 parrot
pictures and 10 lines of data. Only the outline data of the parrot picture is
saved, and the body is filled in at runtime. These data are probably compressed
with [byte pair encoding](https://en.wikipedia.org/wiki/Byte_pair_encoding).

The parrot ASCII art below is the opening line of the Monty Python show. The judge's
comment ["And now for something completely
different"](https://en.wikipedia.org/wiki/And_Now_for_Something_Completely_Different) is also used in the
opening.

```
                             ___-----__
                          _--          --__
                        _-        _--_     \
                      _-    /\  +-.:.:-+ /\ \
                     /      \/  |.:.:.:| \/  |
                    /           |:.:.:.|     |
                   /            |.:.:.:|      |       ___-----___
                  |              |.:.:|       |      /           \
                  |              |:.:.|       |     <   It's ...  |
                  \               |:.|       |       \           /
                   \               ||        |        ---_____---
                 _--\                       |
               _-    -__                    |
            __-         --___               |
          _-                                |
         /                                   |
        |                                     |
```

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
