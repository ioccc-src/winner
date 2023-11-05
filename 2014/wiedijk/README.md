## To build:

```sh
make
```


## To use:

```sh
./prog
```


### Try:

```sh
cc -E prog.c | indent | sed '1,/5.*prog/d'
```


## Judges' remarks:

C11 features definitely help this entry to be as concise as it is.

The judges would like to think that they had almost understood how this entry works.

If you win a bet by demonstrating this entry, please let us know.


## Author's remarks:

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

```
W_f = \x.f(xx)
Y = \f.W_f W_f
```

- a mixture of strict and lazy evaluation, with a `_` force function
  (John Tromp notes that if Turing's fixed-point combinator
  `(\xy.y\z.xxyz)(\xy.y\z.xxyz)` had been used,
  all applications could have been strict)
- uses `Y` to implement factorial on native `int`s
- 10! seconds = 6 weeks
- answers the ultimate question of life, the universe and everything


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
