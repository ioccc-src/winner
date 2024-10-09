## To build:

``` <!---sh-->
    make all
```

**NOTE**: this version is a fixed version for modern C compilers. See the [Alternate
code](#alternate-code) section below for how to use the original and why one
might wish to do so.


## Try:

``` <!---sh-->
    ./westley
```

Also try:

``` <!---sh-->
    ./try.sh
```

to show the code with followed by the result so you can truly see the magic.


## Alternate code:

This version is the original which might not work as you expect nowadays.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

To see if your compiler has the problem described in the Judges' remarks below,
try:

``` <!---sh-->
    ./westley.alt
```

Does it show the same output as `westley`?


## Judges' remarks:

Your compiler must parse

``` <!---c-->
    #define _ -a
    -_
```

as `--a` and not `-(-a)` or some other tokenized form.  Some strictly
conforming ANSI C Preprocessors may object to this: for such
compilers, you can elide the non-standard token-pasting requirement
by changing the `#define` line to:

``` <!---c-->
    #define _ F-->00||F-OO--;
```

This is what the modified code in
[westley.c](%%REPO_URL%%/1988/westley/westley.c) does whereas the alternate code
is the original.

You might enjoy looking at the output of:

``` <!---sh-->
    cc -E westley.alt.c

    cc -E westley.c
```


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
