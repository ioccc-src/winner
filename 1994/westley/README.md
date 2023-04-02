# Worst Abuse of the C Preprocessor:

Brian Westley (Merlyn LeRoy on Usenet)
Digi International
1906 James Ave.
St. Paul, MN  55105
USA
<http://www.westley.org>

## To build:

```sh
make all
```

NOTE: the purpose of this entry is to escape the dungeon via the compiler line
where you get messages as compiler errors. Depending on the compiler line you
will get different error messages and one compiler line will make you win the
game!

## To run:

```sh
./westley
```

NOTE: your terminal should be set to 80 columns, 8 character tabs, and
wraparound.


## Try:

But for something more interesting try compiling it with
different cc arguments.  For example:

```sh
cc -Describe -Door westley.c
cc -Describe -Drain westley.c
```

## Judges' comments:

Not all compiler errors are bad.

For spoilers see the end of the notes from the author below.

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) converted the spoiler
compiler options to be compiler commands and added a script
[spoiler.sh](spoiler.sh) to automate the spoiler commands provided by the author
to make it easier to see the game in action. Thank you Cody! To use:

```sh
./spoiler.sh
```

## Author's comments:

This program, in accordance with the rules, compiles into a legal
C program without human intervention.  However, it simply compiles
into `main(){}`, which does nothing and exits, so you don't need
to actually compile the program.

This program is a simple adventure game which uses only C preprocessor
error messages (for missing `#include` files) as output.  To begin,
try to compile the program with no options:

```sh
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

```sh
cc -Describe -Door prog.c
```

...and you will get another error message telling you about the door.
(note: some compilers will stop after the first missing include file,
while others will continue to try compiling; the latter will repeat
the opening message each time, as if you are playing an adventure game
with "verbose" turned on).

The goal of the game is to escape the dungeon.

Here is a walk-through for the game, including a few dead-ends:
    
### SPOILER

```sh
cc -Describe -Door westley.c
cc -Describe -Drain westley.c
cc -Describe -Dwarf westley.c
cc -Describe -Debris westley.c # or -Dungeon
cc -Describe -Desk westley.c
cc -Describe -Dime westley.c
cc -Describe -Directory westley.c
cc -Dial -DUNgeon0614 westley.c
cc -Drink -Daiquiri westley.c
cc -Drop -Daiquiri westley.c
cc -Drop -Dwarf -Daiquiri westley.c # or -Drop -Down -Daiquiri
cc -Describe -Document westley.c
cc -Depress -Dotted -Dog westley.c
cc -Depress -Dalmatian westley.c # also accepts "Dalmation" [sic]
cc -Deposit -Dime westley.c
cc -Drop -Donut westley.c
cc -Drop -Donut -Down -Drain westley.c # or -Drop -Dwarf -Donut
# (at this point, you win!)
```

Note that the game has no real state information; you can type these
commands in any order, at any time.  Also note that word order is
unimportant.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
