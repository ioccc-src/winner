## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./dalbec
```


## Try:

``` <!---sh-->
    ./try.sh
```

Why does the output end with 121?


## Judges' remarks:

The output is mis-leading ... why does it also print 2047?

For a hint see
[https://web.archive.org/web/20000510191341/https://www.utm.edu/research/primes/prove2.html](https://web.archive.org/web/20000510191341/https://www.utm.edu/research/primes/prove2.html).


... and then try to understand the source!  :-)

We (the judges) recommend that you take the time needed to understand
how this program works.  The source is small enough to make the effort
reasonable, and complex enough to make it interesting.


## Author's remarks:

This program assumes that your terminal wraps lines automatically.
If this is not the case, you may need to change the space in the
"printf" format string to a newline character.

An extra feature of this program is that it allows you (in most
cases) to estimate the stack space available to programs on your
system.  Simply allow the program to run to completion.  The stack
space is roughly proportional to the last number printed.

(On SunOS/cc, the proportionality constant is about 48 bytes.)

On completion, the program produces a core file that may be used to
refine this estimate.  (Or you could try typing `limit` if you're
running `csh`.) In rare cases the stack space may exceed `24*INT_MAX`
bytes, in which case the program will produce an inaccurate estimate.

This program is obfuscated by:

1. The use of easily-confused variable names.

2. Using the implicit `!=0` in conditional expressions.

3. Substituting expressions such as `!a` for `0` where `a!=0` and `!a` for `1`
where `a==0`.

4. The fact that `main()` is a single expression and so beautifies poorly.

5. The fact that `main()` is used:
    - to compute powers in modular arithmetic.
    - to recursively call itself in the main loop.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
