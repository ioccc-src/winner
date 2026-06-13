Award: Best rational emulator

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Enjoy the C64 maze generator!

You may want to try flipping a few bits in the ROM to change the background
color to your favorite one, if you can.


### A fun challenge

Please checkout the [fun challenge&lpar;s&rpar;](../challenge.html#ncw2) for this winning entry.


## Author's remarks:


### The "Rational" Commodore 64 Emulator

This is a Commodore 64 emulator with built in demo program.

Requirements:
- needs POSIX `write(2)`/`usleep(3)`
- a UTF-8 terminal

Works best with:
- a terminal with 24-bit color support
- terminal window set to 40x25

Build and run with:

``` <!---sh-->
    ./try.sh
```

or:

``` <!---sh-->
    make
    ./prog
```


#### Description

Standard emulators are bloated. They waste thousands of lines of code
simulating the MOS 6502 CPU, the VIC-II video chip, and the SID sound
chip. They get bogged down in archaic concepts like "opcodes," "registers,"
"interrupt requests," and "RAM."

I realized that the entire state of a Commodore 64 at any given nanosecond
can be represented as a single integer. Therefore, the transition from
one state to the next is simply a mathematical transformation.

This program is the result of that realization: the world's first
**Rational Instruction Set Architecture (RISA)** C64 emulator.

#### Architecture Highlights

Unlike traditional emulators that rely on complex arrays to simulate memory
or structs to simulate the CPU, this emulator runs on a revolutionary
**Single Register** architecture.

* **Unified Memory:** The accumulator, stack, video RAM, and program counter are all mapped to a single integer, `n`.
* **The "ROM":** The system microcode is compressed into a series of harmonic oscillators, `p[]`. Each pair of numbers represents a "state transition vector" (Numerator/Denominator).
* **The "CPU":**
    1. The CPU injects energy (multiplies state `n` by the numerator).
    2. It checks for resonance (divides by the denominator).
    3. If the result is an integer (harmonic resonance), the system state updates and the pipeline resets.
    4. If the result is fractional (dissonance), the pipeline advances to the next vector.

This eliminates the need for a program counter or flags register. The math *is* the flow control.


#### Technical Limitations & Known Bugs

1. **Audio:** The current implementation focuses on video. Audio could theoretically be added by monitoring the prime factor 29, but it caused buffer under runs on my testing machine.
2. **Speed:** Due to the efficiency of the RISA architecture, the effective clock speed is much higher than that of the C64 so we have inserted `usleep` to make it run at C64 speed.
3. **Entropy:** The C64 SID chip's noise generator is emulated via a deterministic arithmetic chaos algorithm based on the binary digits of Pi. If the output looks the same every time you run it, please restart the universe to get a different value of Pi and try again.
4. **Keyboard:** The keyboard scan routine is currently disabled. The emulator is stuck in "Demo Mode," running the most famous one-liner in history.


#### Warning

**Do not attempt to modify the ROM array `p`.**

Even a single bit flip in the microcode will cause the mathematical
universe of this C64 to collapse, likely resulting in a segmentation
fault or, worse, a syntax error in the fabric of spacetime.


### Spoilers

The following section explains exactly how the C64 emulator works. Reading
the source code *before* decoding this is recommended.

This is not a C64 emulator. It is a **FRACTRAN interpreter**.

The "ROM" array `p[]` is a list of fractions (numerator,
denominator). The main loop implements John Conway's
[FRACTRAN algorithm](https://en.wikipedia.org/wiki/FRACTRAN):

1. Store the initial state in the integer `n`.
2. Iterate through the list of fractions `p[]`.
3. For the first fraction `f` where `n * f` is an integer:
    - Set `n = n * f`.
    - Goto 2

Conway showed FRACTRAN is Turing complete so we can write any program
at all in FRACTRAN if we've got the time and insanity required.

The integers in `p[]` form a hard coded FRACTRAN program that acts as
a state machine. It handles the "boot sequence," prints the banner,
and generates the infinite "10 PRINT" maze.

The FRACTRAN interpreter presented only uses 64 bits for `n`; considerable
effort was expended to make sure we don't overflow it. This makes the
interpreter extremely short. More general FRACTRAN programs will use
arbitrarily large `n` and need multi-precision arithmetic.


#### The "Video" Output

Since FRACTRAN operates on a single integer, we cannot use standard
video memory. Instead, we use **prime mapped IO**.

We only output a character when the FRACTRAN machine hits a specific
state (at the start of the `p[]` list, when `n` is divisible by 2). At
that moment, the bits of the UTF-8 character to be printed are encoded
in the divisibility of `n` by the first 8 odd primes:

- **Bit 0:** Is `n` divisible by 3?
- **Bit 1:** Is `n` divisible by 5?
- **Bit 2:** Is `n` divisible by 7?
- **Bit 3:** Is `n` divisible by 11?
- **Bit 4:** Is `n` divisible by 13?
- **Bit 5:** Is `n` divisible by 17?
- **Bit 6:** Is `n` divisible by 19?
- **Bit 7:** Is `n` divisible by 23?

The program multiplies and divides to ensure `n` has the correct prime
factors to spell out "COMMODORE 64" and the box-drawing characters for
the maze. Everything is encoded as powers of prime numbers (using [Gödel
numbering](https://en.wikipedia.org/wiki/G%C3%B6del_numbering)). This is
done with a state machine using powers of prime numbers both as states
and registers. Factorizing the numbers in `p[]` will reveal some of the
structure of the program.

This is why the strings `COMMODORE`, `READY`, or even `10 PRINT` never
appear anywhere in the C source. They only exist as relationships
between primes.

Yes, that is excessive. This is the IOCCC.


#### The maze

The maze is not truly random (FRACTRAN is deterministic) but is messy
enough that judging by eye you probably won't notice. The random bits
are taken straight from the binary representation of Pi `╱` is 1,
`╲` is 0. It repeats after a while to fit the FRACTRAN program into
64 bits of state and stay under the IOCCC size rules.


#### Why use `usleep`?

FRACTRAN is mathematically elegant, but computationally horrific. However,
since we've limited `n` to 64 bits, modern CPUs are so fast that without
`usleep`, the "emulator" would print the infinite maze very quickly,
flooding the terminal. The sleep command slows it down to a nostalgic,
retro speed.


#### Summary

- Enjoy the nostalgia.
- Marvel that it's not a real emulator.
- Try explaining to your friends that this is actually a number-theory based domain-specific virtual machine for recreating 8-bit art. (If they stop inviting you to parties afterwards, please blame Conway, not the author.)


#### Dedication

Dedicated to the memory of [John Horton Conway](https://en.wikipedia.org/wiki/John_Horton_Conway):
a man who lamented being most famous for [The Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)
but who would surely appreciate being remembered for FRACTRAN -
a language that achieves the perfect arithmetization of computation.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
