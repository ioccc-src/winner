# Most functional

Freek Wiedijk  
<freek@cs.ru.nl>  


## Judges' comments:
### To build:

    make wiedijk

### To run:

    ./prog

### Try:

    gcc -E prog.c | indent | sed '1,/5.*prog/d'

### Selected Judges Remarks:

C11 features definitely help this entry to be as concise as it is.

The judges would like to think that they had almost understood how this entry works.

If you win a bet by demonstrating this entry, please let us know.

## Author's comments:
### Remarks

- computes the factorial function
- no loops, no explicit recursion
- untyped C without any casts, using a `w` word datatype
- varargs not essential, `w(*)(w,w*)` works just as well
- conforming ISO C
- no warnings when compiled with `-std=c99 -Wall -Wextra -pedantic`
- comments in the code explain what this really is about
- C as a functional programming language:
  untyped lambda calculus compiled to executable C functions
- untagged closures (just a function pointer followed by some values)
- recursion implemented through Curry's paradoxical combinator `Y`
- the readable implementation of `Y` is on lines 29-30:

	W_f = \x.f(xx)
	Y = \f.W_f W_f

- a mixture of strict and lazy evaluation, with a `_` force function
  (John Tromp notes that if Turing's fixed-point combinator
  `(\xy.y\z.xxyz)(\xy.y\z.xxyz)` had been used,
  all applications could have been strict)
- uses `Y` to implement factorial on native `int`s
- 10! seconds = 6 weeks
- answers the ultimate question of life, the universe and everything

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
