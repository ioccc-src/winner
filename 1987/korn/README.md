## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./korn
```


## Judges' remarks:

The Judges believe that this is the best one line entry ever received.
Compile on a UNIX system, or at least one using a C implementation that
fakes it.  Very few people are able to determine what this program
does by visual inspection.  I suggest that you stop reading this
section right now and see if you are one of the few people who can.

Several points are important to understand this program:

1. What is the symbol `unix` and what is its value in the program?  Clearly
`unix` is not a function, and since `unix` is not declared to be a data type
(such as `int`, `char`, `struct foo`, `enum`, ...) what must `unix` be?

2. What is the value of the symbol `"have"`?  (hint: the value is NOT 4
characters, or `'h'`, or a string)  Consider the fact that:

``` <!---c-->
    char *x;
```

defines a pointer to a `char` (i.e. an address), and that the `=` assigns
things of compatible types.  Since:

``` <!---c-->
    x = "have";
```

is legal C, what type of value is `"have"`?

3. Note that the following expressions yield the same value:

``` <!---c-->
    x[3]        *(x+3)    *(3+x)
```

since addition is commutative.  What can be said about this value?

``` <!---c-->
    3[x]
```

[David
Korn](https://news.slashdot.org/story/01/02/06/2030205/david-korn-tells-all)'s
[/bin/ksh](https://en.wikipedia.org/wiki/KornShell) provides us with a greatly
improved version of the [/bin/sh](https://en.wikipedia.org/wiki/Bourne_shell).
The source for [v7](https://en.wikipedia.org/wiki/Version_7_Unix)'s /bin/sh
greatly inspired this contest.


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
