## To build:

``` <!---sh-->
    make alt
```

We recommend that you try the alternate version first as the original entry
requires (for better display) 80 columns and 8 character tabs with wraparound.

The alternate code uses the same logic as the original code except that the original
code used `#include`s of files that do not exist to generate the messages (as
compiler errors) whereas the alternate code uses `printf(3)`. For the original entry
see [Original code](#original-code) below.


## To use:

``` <!---sh-->
    ./westley.alt
```

The purpose of the game is to escape the dungeon. Depending on the compiler line
you will get a different message when you run the program. One compiler line
will make you win the game (escape the dungeon) and others will show something
else.

_This is independent of the previous (if there are any previous) compiler
invocations_ specified. That means with the right compiler invocation you can
'win' the game on the first go.

There are a variety of different `-D` flags you give to `cc` that change the
message you get. You might wish to look at the [source code](%%REPO_URL%%/1994/westley/westley.alt.c) to
get a better idea or see below in the [Try](#try) section for running the game
from start to finish.


## Try:

For something more interesting try compiling it with different `cc -D` arguments
and then run the program each time.  For example:

``` <!---sh-->
    cc -Describe -Door westley.alt.c -o westley.alt && ./westley.alt
    cc -Describe -Drain westley.alt.c -o westley.alt && ./westley.alt
```

To see the game from start to finish, try:

``` <!---sh-->
    ./try.alt.sh
```


## Original code:

The purpose of the game is to escape the dungeon **via the compiler line
where you get _messages as compiler errors_**. Depending on the compiler line you
will get different error messages and one compiler line will make you win the
game!

NOTE: your terminal should be set to 80 columns, 8 character tabs, and
wraparound. The alternate code does not have this limitation and it is for this
reason that we recommend you try it first.


### Original build:

``` <!---sh-->
    make all
```

There are a variety of different `-D` flags you can give to `cc` that change the
message you get. You might wish to look at the [source code](%%REPO_URL%%/1994/westley/westley.c) to get a
better idea or see below in the [Original try](#original-try) section for
running the game from start to finish.


### Original use:

There is no running of this program directly as it is supposed to fail to
compile: the purpose of the game is to escape the dungeon but depending on the
compiler line you will get a different message (**as compiler errors** due to
`#include` files not existing). One compiler line will make you win the game
(escape the dungeon) and others will show something else.

_This is independent of the previous (if there are any previous) compiler
invocations_ specified. That means with the right compiler invocation you can
'win' the game on the first go. But unlike the [alternate code](%%REPO_URL%%/1994/westley/westley.alt.c),
you do not run this program as it will not compile: instead it will be compiler
error messages; there is no running the program.


### Original try:

For something more interesting try compiling it with different `cc -D`
arguments:

``` <!---sh-->
    cc -Describe -Door westley.c
    cc -Describe -Drain westley.c
```

To see the game from start to complete, try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Not all compiler errors are bad.


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


## Author's remarks:

This program, in accordance with the rules, compiles into a legal
C program without human intervention.  However, it simply compiles
into `main(){}`, which does nothing and exits, so you don't need
to actually compile the program.

This program is a simple adventure game which uses only C preprocessor
error messages (for missing `#include` files) as output.  To begin,
try to compile the program with no options:

``` <!---sh-->
    cc westley.c
```

This will fail, producing an error message for a missing `#include`
file as the opening description.  Your terminal should be set for
80 columns, 8 character tabs, and wraparound, as there is no way
to reliably output newlines.  You should see something like this
(text massaged to change wraparound to separate lines):

```
    westley.c
    westley.c(87) : fatal error C1024: cannot open include file '

     You are in a debris-filled
      dungeon; a door bars the
      way, and sludge trickles into
      a floor drain

     '
```

Your compiler error message will vary, but the important part is the
missing include file name, which functions as the game text.

To "do" things, all words must start with `-D`.  For example, to
look at the door, do:

``` <!---sh-->
    cc -Describe -Door prog.c
```

...and you will get another error message telling you about the door.
(note: some compilers will stop after the first missing include file,
while others will continue to try compiling; the latter will repeat
the opening message each time, as if you are playing an adventure game
with "verbose" turned on).

The goal of the game is to escape the dungeon.

Here is a walk-through for the game, including a few dead-ends:


### SPOILER (HOW TO WIN):

``` <!---sh-->
    cc -Describe -Door westley.c
    cc -Describe -Drain westley.c
    cc -Describe -Dwarf westley.c
    cc -Describe -Debris westley.c \
        # or -Dungeon
    cc -Describe -Desk westley.c
    cc -Describe -Dime westley.c
    cc -Describe -Directory westley.c
    cc -Dial -DUNgeon0614 westley.c
    cc -Drink -Daiquiri westley.c
    cc -Drop -Daiquiri westley.c
    cc -Drop -Dwarf -Daiquiri westley.c \
        # or -Drop -Down -Daiquiri
    cc -Describe -Document westley.c
    cc -Depress -Dotted -Dog westley.c
    cc -Depress -Dalmatian westley.c \
        # also accepts "Dalmation" [sic]
    cc -Deposit -Dime westley.c
    cc -Drop -Donut westley.c
    cc -Drop -Donut -Down -Drain \
       westley.c # or -Drop -Dwarf -Donut
    # (at this point, you win!)
```

Note that the game has no real state information; you can type these
commands in any order, at any time.  Also note that word order is
unimportant.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
