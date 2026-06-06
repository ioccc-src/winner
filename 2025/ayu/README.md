Award: IMO award

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog

    ./prog >(sox --buffer 1024 -t s16 -r 48000 -c 1 - -d 2>/dev/null)
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./prog.alt

    ./prog.alt >(sox --buffer 1024 -t s16 -r 48000 -c 1 - -d 2>/dev/null)
```


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

Some mathematical problem statements are straightforward,
while others are obfuscated.  However in the case of the
[5th problem of the 2024 International Mathematical Olympiad](https://artofproblemsolving.com/wiki/index.php/2024_IMO_Problems/Problem_5),
the statement of the problem can be very obfuscated.

It has been shown that the answer to
[5th problem of the 2024 International Mathematical Olympiad](https://artofproblemsolving.com/wiki/index.php/2024_IMO_Problems/Problem_5)
is **3**.  Using the game as coded in [prog.c](%%REPO_URL%%/2025/ayu/prog.c),
demonstrate the optional strategy so that you always win the game.


### A fun challenge

Generate an alternative version of [prog.c](%%REPO_URL%%/2025/cesmoak/prog.c), named `prog.alt.c`,
that allows for `N` to be defined for values larger than **11**?  I.e., that works with
`-DN=12`, and up to some reasonable limit?

The above fun challenge is **still open**.
See the "[Fun challenge Info](../index.html#fun_challenge_info)" section for details.


## Author's remarks:


This program is a game that can be played in the console. Use `try.sh`
to build and run; the rules are straightforward and you might want to
dive in right away, without extensive reading.


### Rules

The game arena is a cell grid of `N - 1` rows and `N` columns. Some of
the cells are traps; each row or column contains at most one trap. The
player starts from outside the arena, entering on any cell on the first
row, and aims to exit from the last, making moves in four directions
into adjacent cells (L/R/U/D). Each time the player hits a trap, they
are teleported back to the initial position, outside of the arena. The
objective is to successfully exit the arena in as few attempts as possible.

The game is expected to run in an ANSI-compliant terminal
emulator. Movement can be made by arrow keys or `h`/`j`/`k`/`l` keys as in
`vi`. It can be exited by `SIGINT` (Control-C), or the `q` key.


### Features


#### Adversarial play

The distribution of traps is not predetermined. Instead, the computer
plays against the player whenever they make a move, trying to maximize
their number of attempts.


#### Sound

This game supports sound output through a pipe. An example, working with
`sox(1)` is provided in [try.sh](%%REPO_URL%%/2025/ayu/try.sh).


#### Platform support

The core game logic is exposed through functions `R()` (for reset)
and `M()` (for movement/input handling). An interface can be created
by accessing the game state at the array `a` and the round number `o`;
meanwhile, there is also a game loop function `L()` that takes a minimal
set of three environment adapters (character I/O, sound, entropy) and
presents a text-based interface.

The author believes that the core game logic can run correctly on
any platform, agnostic of word size, endianness, and signedness of
`char`. The author has tested the game under ARM64 Linux, x86-64 Linux,
and the ATmega 8-bit MCU (and is eagerly looking to adding more to the
list, especially on various MCUs ^ ^).


#### Fuzzing

There is a fuzzing program that uses LLVM's libFuzzer to test the
algorithm against memory access violations, undefined behaviour, and
overall correctness. Run `make fuzz` to build it, and `./fuzz` to run.

Note that the current algorithm only ensures correct operation at `N =
5` and holds a weaker guarantee at larger values of `N`; namely, if the
player is lucky and clever, they can trick the game into generating less
than `N - 1` traps. This, however, does not affect the gameplay.


#### Tangible form

Also included is an Arduino port. The `arduino/serial_play/` directory
contains an Arduino sketch that exposes a game interface on the serial
port.

The Arduino toolchain (IDE) expects a location-agnostic project path,
so relative includes are not possible. To avoid duplicate files in the
submission, the author adds a `arduino-sketch` Makefile target that
copies the `prog.c` into the sketch directory for building. It will be
removed by `make clobber`.

This sketch also supports sound output through a buzzer, and input
through four direction buttons.

The author also has a working circuit board that integrates these
components and an addressable LED matrix; porting the final bits has not
been done in _prime time_ and left as an exercise for the reader (>-^)
The ECAD project and pictorial demonstration might be too large to be
included in a submission; the author is happily working on open-sourcing
them on their own website!


### Obfuscation techniques


#### Warnings

In author's tests with GCC 15.2.1 and Clang 20.1.8 on ARM64 Linux,
as well as GCC 13.3.0 on x86-64 Linux, the code compiles cleanly
with `-Wall -Wextra -pedantic` with the addition of `-Wno-parentheses
-Wno-char-subscripts`. These two exemptions are due to deliberate choices,
i.e., omitting parentheses as much as possible as an obfuscation technique,
and reducing memory usage as much as possible with built-in C types
(because we will be running on constrained 8-bit platforms!).

Actually that is not quite the case; GCC might complain about two
`-Wsign-compare`'s, but that is actually a deobfuscating hint!


#### Custom operators

The code features several custom operators that extends the C standard:
- The sleepy head operator `-~-`, with variants `=~-`, `-=-`, etc.;
- The fish operator `<o<<` and the fishing hook operator `<~-`;
- The sword operator `++>`;
- The little prince's rose operator `+~(`.


### Final spoiler

This game is actually a faithful replication of the
[IMO 2024 Problem 5](https://artofproblemsolving.com/wiki/index.php/2024_IMO_Problems/Problem_5).
It's a hard problem on the contest, and a great brain-teaser as well. Hope
you have enjoyed it!


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
