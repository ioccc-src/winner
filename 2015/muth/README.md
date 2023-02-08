# Most Complete Use of CPP

Dominik Muth <muth.ioccc@freenet.de>  


## Judges' comments:
### To use:

    make -B [MACHINE=your_machine.h] [TAPE=your_tape.h] [X=[0|1|2|3|4|5|6|7|8|9]] [V=[0|1|2]] run

### Try:

    make -B V=2 run

    strings prog | grep '(,)'

    make -B MACHINE=machine_times2.h TAPE=tape_five.h V=1 run

    make -B MACHINE=machine_chaos_5_2.h X=5 run

### Selected Judges Remarks:

This is something we were fearing all along: that the C preprocessor is Turing-complete
even without conditionals and recursive file inclusion as some kind of a
[rewriting system](https://en.wikipedia.org/wiki/Rewriting). Now we have the proof!

## Author's comments:
### Preprocessor Turing Engine

#### Features

- Turing machine runs in preprocessor
- universal (unlimited configurable states, symbols, and tape)
- no `#if`s or other conditional directives, only `#define`s
- no recursive `#include`
- single compiler run (no repeated preprocessing)
- no variadic macros
- verbosity levels:
  + `V=0` (default) only prints the final tape
  + `V=1` additionally prints one tilde character per machine step (slow)
  + `V=2` additionally prints details on each machine step (slow; generates large files)
- make target `run` runs `./prog` and filters a little statistics out of the verbose output
- `X` (defaults to 3) sets the maximum number of steps: *M*(`X`) ~ 8<sup>`X`</sup>

#### Limitations

If the machine does not halt after *M*(`X`) steps, you will see unexpanded macros in the output.

#### Compiler warnings

If `V=1` or `V=2` is used, you may see "`warning: string length is greater than the length '4095' ISO C99 compilers are required to support`".

#### Programming

Implementing your own Turing machine is easy. Take a look at the supplied header files for examples.

##### Tape Symbols

Every symbol used (except "`_`") must be explicitly declared using

	#define sym_SYMBOL(sym, _SYMBOL) sym

Example:

    #define sym_1(sym, _1) sym

##### Tape

The initial content of the tape must be defined in the tape header using a triple like:

	#define tape ((((,),...l2), l1), c, (r1, (r2..., (,))))

- `l1`, `l2`, ... are the symbols to the left
- `c` is the symbol at the current position
- `r1`, `r2`, ... are the symbols to the right

The empty pairs "`(,)`" represent the continuations of the tape, filled with underscore symbols ("`_`"). They are expanded on demand.

##### State Machine

All transitions are defined in the machine header using the syntax

	#define CURRENT_SCANNED (WRITE, MOVEMENT, NEXT)

where

- `CURRENT` is the current state
- `SCANNED` is the symbol at the current position
- the whitespace before the parentheses is significant
- `WRITE` is the symbol to be written to the tape
- `MOVEMENT` is "`L`" for left, "`R`" for right, or nothing
- `NEXT` is the next state

There must be a state "`A`" defined, which becomes the initial state of the machine.

To halt the machine, use the keyword "`break`" as in

	#define A_1 (2, break)

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2016, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
