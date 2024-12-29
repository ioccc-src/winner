## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```

By default that will use `indent(1)` found by the shell `type -P indent` and
`sed(1)` found by the shell `type -P sed` but if you want to change these, say
to try a different beautifier, you can do it like:

``` <!---sh-->
    INDENT=bcpp ./try.sh
```

which would change it to use `bcpp(1)` instead of `indent(1)`. Do similar for
`sed(1)` only use the name `SED`.


## Judges' remarks:

C11 features definitely help this entry to be as concise as it is.

The judges would like to think that they had almost understood how this entry works.

If you win a bet by demonstrating this entry, please let us know.


## Author's remarks:

### Remarks

- Computes the factorial function.
- No loops, no explicit recursion.
- Untyped C without any casts, using a `w` word datatype.
- Varargs not essential, `w(*)(w,w*)` works just as well.
- Conforming to ISO C.
- No warnings when compiled with `-std=c99 -Wall -Wextra -pedantic`.
- Comments in the code explain what this really is about.
- C as a functional programming language: untyped lambda calculus compiled to
executable C functions.
- Untagged closures (just a function pointer followed by some values).
- Recursion implemented through Curry's paradoxical combinator `Y`.
- The readable implementation of `Y` is on lines 29-30:

```
    W_f = \x.f(xx)
    Y = \f.W_f W_f
```

- A mixture of strict and lazy evaluation, with a `_` force function
  (John Tromp notes that if Turing's fixed-point combinator
  `(\xy.y\z.xxyz)(\xy.y\z.xxyz)` had been used,
  all applications could have been strict).
- Uses `Y` to implement factorial on native `int`s.
- 10! seconds = 6 weeks.
- Answers the [ultimate question of life, the universe and
everything](https://hitchhikers.fandom.com/wiki/42).

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
