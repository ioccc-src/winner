## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    echo foo bar | ./dg
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Some C preprocessors got confused about single quotes in certain cases.
In particular, the following source line:

``` <!---c-->
    b12(ase(bco(acp(bi(acp(bcp(acp(bpl(aqu(bqu(A))))))))))))))))))))))))))))))
```

sometimes has to be changed to:

``` <!---c-->
    b12(ase(bco(acp(bi(acp(bcp(acp(bpl('A'))))))))))))))))))))))))))))
```

particularly if the C preprocessor botches single quotes in cpp expansions,
which we have done for the wider audience.


## Author's remarks:

If my preprocessor could hack it, I could write this as one single line rather
than 4, but when I do that I get a complaint "defines nested too deeply".

### Debfuscation:

This is another rot13 job (believe it or not) - the `#define`s are a
novel way of adding tokens: `#define b12(x) 12 x` means that at
some point in the source a `12` is followed by the compressed nested
`#define`s. The `b12` gets the previous compression as an argument, and
prepends the `12`, thus making another step in the recreation of the
source. The `axx()` `#define`s do the same, but add tokens after.

As for the rot13 algorithm, it relies on `index(3)` to find if the
character is in the set `A-Za-z`. `l[]` is an array that gets filled
with:

``` <!---c-->
    "nopqrstuvwxyzzzzabcdefghijklmmmmNOPQRSTUVWXYZZZZABCDEFGHIJKLMMMM"
```

If `index(3)` says the char is in the alphabet, then XOR the offset
with `16` to translate, and output, otherwise pass it unchanged.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
