## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./schweikh2
```

The program accepts up to 4 parameters:

0. The number of operators in the expression [default: 9]

1. The value of the first operand [default: 1]

2. The (possibly negative) increment to the next operand [default: 1]

3. The goal value or 0/0 [default: 42]


## Try:

``` <!---sh-->
    ./try.sh
```

What happens if you pass only three parameters like the below?

``` <!---sh-->
    ./schweikh2 15 1 0
```

The author also suggests:

``` <!---sh-->
    while :; do grep -v '#' schweikh2.c; done
```

(and we do too) which works with `sh`, `bash`, `ksh` and `zsh` as well. Press
ctrl-c to stop it. Observe how the [try.sh](%%REPO_URL%%/1996/schweikh2/try.sh) script does this once to
make it easier to see what is happening.


## Judges' remarks:

The original program, with only slight obfuscations, may be found
in [hunni.c](%%REPO_URL%%/1996/schweikh2/hunni.c). The perl script, [hunni.pl](%%REPO_URL%%/1996/schweikh2/hunni.pl), obfuscates it
appropriately. Try:

``` <!---sh-->
    less hunni.c

    perl ./hunni.pl < hunni.c
```

NOTE: the [try.sh](%%REPO_URL%%/1996/schweikh2/try.sh) does this if you have
`perl(1)` installed to show how the output is the same as
[schweikh2.c](%%REPO_URL%%/1996/schweikh2/schweikh2.c) itself.

This entry was another crowd pleaser at the IOCCC BOF.


## Author's remarks:

Note: the source must be viewed with tabstop 8. To appreciate the
beauty have your eyes half closed.


### Why I think this program is obfuscated:

C is a free format language. It is therefore a question of style how
variables, operators, declarations, functions and syntactic elements
like braces and parentheses are grouped together. As a rule of thumb,
I put spaces around operators, after opening braces and before closing
braces. I have generalized this rule by putting whitespace after *any*
non-white space character (with the exception of preprocessor directives).
There are no recognizable keywords anymore. There are no recognizable
string literals any more. The `main()` function is invisible. All operators
longer than one character are gone. They have been replaced by macro
calls with quite a number of arguments. The keys are the token pasting
and stringizing macros `e` and `O`. The "arcane rules of token pasting"
[K&R2] are used up to three levels: `H(O,r)R(O,r)` (!) which is needed to make
one 8-character token from 8 characters (`unsigned`). BTW, C has no 9 or
more character reserved words, so a fourth level is only required if
you intend to generate object names from 9 or more components. The final
round even swaps the tokens, so all keywords must be spelled backwards
(sort of, can you spot `printf` in the `P` macro?).

Try to indent the source. The unbalanced parentheses confuse Solaris'
indent to the max (although the result does compile):

Looking at the indented source is even *less* fun, because the nice
diamond pattern has been replaced by something that looks like, uhm,
modem noise.

Lint the source. It's clean. How obfuscated...

What's the exit status? The program exits with `J - 1` where `J` is the
return value from several non-void functions (needed to shut up
lint). The last assignment is `J = printf ("%c", 10);` so the exit
status is 0 unless the last `printf` failed, which is even a *useful*
status. A further obfuscation is the use of `10` instead of `'\n'`.
`'\n'` can not be constructed by token pasting, AFAIK. That's why `schweikh2`
is likely to produce occasional garbage on non-ASCII execution character
set systems.


### What this program does

The program is an expression evaluator for a limited class of expressions. Known
operators are `+` `-` `*` `/`; operands are real numbers (integers or
fractions). The operands are restricted in that they must differ by a constant
value, for example `1 + 2 * 3 / 4 - 5`. For any combination of operators the
expression is evaluated and compared to a goal value. If they compare equal the
expression is printed. If the goal value is specified as `0/0` all expressions
and results are printed. For any fraction, the numerator and denominator are
divided by their greatest common divisor.

The program accepts up to 4 parameters:

1. The number of operators in the expression [default: 9].
2. The value of the first operand [1].
3. The (possibly negative) increment to the next operand [1].
4. The goal value or 0/0 [42].

On ANSI/ISO C conformant systems (where `long` is at least 32 bits)
overflow will occur in the default case (first operand 1, increment 1)
only for more than 11 operators. Because a bit mask is used that needs
twice the number of operands in bits (plus a sentinel value) on those
systems the first parameter must not exceed 15.

If `long` is at least 64 bits overflow will occur for more than 19
operators but you will probably wait quite some time for every of the
`4^19 = 274,877,906,944` combinations to be evaluated... While I'm at it,
on a 50 MHz SPARC, `4^11` expressions are evaluated in about 3 cpu
minutes (`gcc -O3`).

### Sample arguments:

``` <!---sh-->
    ./schweikh2 6
    ./schweikh2 7 0
    ./schweikh2 7 7 0
    ./schweikh2 8 9 -1 -67/21
    ./schweikh2 8 2 2/5 -98/25
    ./schweikh2 2 1/0 1 1/0
```

### Miscellaneous

The diamond pattern can be continued without a break.
For a nice printout try this on your Bourne compatible shell:

``` <!---sh-->
    while :; do grep -v '#' schweikh2.c; done
```


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
