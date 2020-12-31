# Most Irrational

Steinar Hamre
Norway

## Judges' Comments:

### To build:

        make hamre

### To run:

        ./hamre '-1+4/3*(2+1/(3/2*(7/2-7/3+1/6)))/2'

An irrationally coded source presents rational things!

A rational person might want to attempt the irrational task
of supporting a new operator by way of an existing macro
in the source.  And can you determine which macro this is
and understand the purpose of its arguments?

## Selected Author's Comments:

This is a calculator for rational numbers. Believe it or not, that is
a useful tool to have around, and I haven't found a useful version,
much less an obfuscated one.

It is rather feature complete as rational calculators go. The
supported operators are: +, - (binary and unary), *, / and (). Run it
by supplying an expression as the first argument, and the normalized
result will be written to stdout.

        ./hamre '-1+4/3*(2+1/(3/2*(7/2-7/3+1/6)))/2'
        2/3

If you do not supply an argument, the calculator will crash.  Other
arguments are ignored. Supplying more arguments may further limit the
number of nested operators supported.

Remember that 1/0 is not a rational number. You will not get any
answer if you divide by zero.

By default, only 31 nested levels of operators are supported.

The code is well documented, even with an example. In fact this
documentation accounts for 100% of the source.  Personally I find
preprocessing or reindenting the program counterproductive when it
comes to understanding the source. The preprocessed source becomes
rather verbose.

IOCCC entries are often loaded with all kinds of hard-coded numbers. I
have restricted myself to mostly use sensible numbers (<= 7) as
smaller numbers are much easier to remember. Also the macros really
help hiding most of the uses of these numbers away. All macros and
variables are easy-to-remember single character abbreviations, from
some language, meaningful to the purpose(s) of the macro, I hope.
