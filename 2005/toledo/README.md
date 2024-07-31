## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./toledo [a ...]
```


## Try:

``` <!---sh-->
    ./toledo a
    ./toledo a b
```


## Alternate code:

Two alternate versions of this entry, [toledo2.c](%%REPO_URL%%/2005/toledo/toledo2.c) and
[toledo3.c](%%REPO_URL%%/2005/toledo/toledo3.c) are provided.


### Alternate build:

To compile the alternate versions:

``` <!---sh-->
    make alt
```


### Alternate use:

Use Use `toledo2` and `toledo3` as you would `toledo` above.


## Judges' remarks:

Challenge yourself with your ability to look 5, 6 or more moves ahead.
Challenge your knowledge of C operator precedence.  The following is the
move analysis via recursion while it executes moves.  All while playing
by the rules of C and Chess within a single function!

### Historical note:

When this entry was submitted the code was a recursive call to `main()` - that
was it. In 2023 due to problems with `clang` `main()` calls another function,
`pain()`, which calls itself. But it might be said that the Chess is still a
single function.


## Author's remarks:

### What does this program

This is a [chess](https://en.wikipedia.org/wiki/Chess) program, it can work in
two modes: two-players, and one player (always white) against the machine. To
get the first mode, run the program without arguments:

``` <!---sh-->
    ./toledo
```

The other mode is accessible running the program with one argument
(5-[ply](https://en.wikipedia.org/wiki/Ply_&lpar;game_theory&rpar;)
analysis):

``` <!---sh-->
    ./toledo a
```

Two arguments for 6-[ply](https://en.wikipedia.org/wiki/Ply_&lpar;game_theory&rpar;)
analysis:

``` <!---sh-->
    ./toledo a b
```

And each successive argument will analyze one
[ply](https://en.wikipedia.org/wiki/Ply_&lpar;game_theory&rpar;) more. There is no ply
limit, but beyond 7 ply is very slow, try it at your own risk and computing
time.


### Entering movements

When it is your turn, you can enter your move, for example, as `d2d4` and press the
enter key. This will move the pawn at `D2` to `D4`, assuming that a pawn is
there (as it would be in the beginning). The computer will check move legality
and will warn you of illegal moves. All legal chess moves are permitted.

One special case is when you are doing promotion, you must enter the move with
an extra letter indicating the desired piece.

For example `f7f8n` (supposing you have a pawn on `F7`), will promote it to a
knight; substitute `n` for the desired piece (`N`/`Q`/`R`/`B`).

Note that the program requires the piece letter; it will not select
automatically a queen, so don't be surprised if it doesn't accept your move.


### Game status

The computer will check for checkmate and stalemate. Also, after each machine
move, it will show the score of the position: a higher number is better for
the computer, i.e. worse for you.


### Quirks

None.


### Program operation

This is a good example of a chess program reduced to the essential. In order
to get it into the contest limits, I used short but slow and unintelligible
algorithms.

The interface accounts for only a fraction of the code, the core does multiples
functions: it is called recursively to analyze and evaluate each
[ply](https://en.wikipedia.org/wiki/Ply_&lpar;game_theory&rpar;), does [alpha-beta
pruning](https://en.wikipedia.org/wiki/Alpha-beta_pruning), move generation,
machine playing, check detection, illegal move verification and does moves after
they are verified.

It also sets a standard on ultra-mini-chess programs. The player and the
computer can do all legal chess moves.


### Additional features

Other features are:

* Illegal move verification.
* [Checkmate](https://en.wikipedia.org/wiki/Checkmate) detection.
* Stalemate detection.
* Computer is tough (check
7-[ply](https://en.wikipedia.org/wiki/Ply_&lpar;game_theory&rpar;) and even in 5 ply can give a surprise to
amateur players.


### Obfuscation tricks

* Only one very modular C function.
* Extensive use of the ternary and comma operators; save a hard drive today.
* Extensive use of C operator precedence; all good C programmers remember
it... I cannot.
* Exchanged operands every place possible. Someday someone will
understand it.
* Mixed and multifunction expressions on statements, in good old-BASIC
style.
* Macros used to hide C syntax: check unbalanced parenthesis and calls with
empty arguments!
* Only includes strictly necessary standard headers, the linker takes care,
and compiles faster... but I'm still not seeing the difference.
* Uses only one string, very easy to
[i18n](https://en.wikipedia.org/wiki/Internationalization_and_localization) ;)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
