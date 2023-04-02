# Best game

    Oscar Toledo G.
    Familia Toledo
    Av. Santa Cruz del Monte 9-304
    Ciudad Satelite Edo de Mexico
    CP 53110
    Mexico
    uno@biyubi.com

## To build:

```sh
make
```

## To run:

```sh
./toledo [a ...]
```

## Try:

```sh
./toledo a
./toledo a b
```

## Alternate code:

An alternate version of this entry, `toledo2.c` and `toledo3.c` is provided.

To compile these alternate versions:

```sh
make alt
```

Use `toledo2` or `toledo3` as you would `toledo` above.

## Judges' comments:

Challenge yourself with your ability to look 5, 6 or more moves ahead.
Challenge your knowledge of C operator precedence.  The following the
move analysis via recursion while it executes moves.  All while playing
by the rules of C and Chess within a single function!

## Author's comments:

### What does this program

This is a chess program, it can work in two modes: two-players, and one player
(always white) against the machine. To get the first mode, run the program
without arguments:

```sh
./toledo
```

The other mode is accesible running the program with one argument (5-ply
analysis):

```sh
./toledo a
```

Two arguments for 6-ply analysis:

```sh
./toledo a b
```

And each succesive argument will analyze one ply more. There is no ply limit,
but beyond 7 ply is very slow, try it at your own risk and computing time.

### Entering movements

When is your turn, you can enter your move, by example, as "d2d4" (without the
quotes) and press the Enter key, the computer will check move legality and
will warn you of illegal moves. All legal chess moves are permitted.

One special case is when you are doing promotion, you must enter the move with
an extra letter indicating the desired piece.

By example "f7f8n" (supossing you have a pawn on f7), will promote it to a
knight, substitute 'n' for the desired piece (N/Q/R/B).

Note that the program requires the piece letter, it will not select
automatically a queen, so don't be surprised if it doesn't accept your move.

### Game status

The computer will check for checkmate and stalemate, also after each machine
move, it will show the score of the position, an higher number is better for
the computer, i.e. worst for you.

### Quirks

None.

### Program operation

This is a good example of a chess program reduced to the essential. In order
to get it into the contest limits, I used short but slow and unintelligible
algorithms.

The interface accounts for only a fraction of the code, the core does
multiples functions, it is called recursively to analyze and evaluate each
ply, does alpha-beta cutting, move generation, machine playing, check
detection, illegal move verification and does moves after they are verified.

Also sets an standard on ultra-mini-chess programs, the player and the
computer can do all legal chess moves, other features are:

  * Illegal move verification.
  * Checkmate detection.
  * Stalemate detection.
  * Computer is tough (check 7-ply), even in 5 ply can give a surprise to
amateur players.

### Obsfucation tricks

  * Only one C function, really modular.
  * Extensive use of the trinary and comma operators, save a hard drive today.
  * Extensive use of C operator precedence, all good C programmers remember
it... I cannot.
  * Exchanged operands every place is possible, someday someone will
understand it,
  * Mixed and multifunction expressions on statements, in good old-BASIC
style.
  * Macros used to hide C syntax, check unballanced parenthesis and calls with
empty arguments!
  * Only includes strictly necessary standard headers, the linker takes care,
and compiles faster... but I'm still not seeing the difference.
  * Uses only one string, very easy to I18N ;)

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
