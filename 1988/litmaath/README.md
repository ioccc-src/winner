## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./litmaath some text
```

There is an alternate version provided. See the [Alternate
code](#alternate-code) section below.


## Try:

``` <!---sh-->
    ./litmaath eschew obfuscation
```


## Alternate code:

This alternate code, added to help understand the entry and for fun, is code
that we suggested at the time of the entry publication but which we never put in
a file.


### Alternate build:

``` <!---sh-->
    make alt
```

Use `litmaath.alt` as you would `litmaath` above.


### Alternate try:

``` <!---sh-->
    ./litmaath.alt six was afraid of seven because seven eight nine
```


## Judges' remarks:

Note the unusual structure:


``` <!---c-->
    while (<condition>)
         ;
```

Did you notice that the body is empty?

Furthermore, it's interesting to note that only two variables are
used to achieve everything.

The best one can do to understand how the program works is to give it
two small strings as arguments, and follow the program closely.  One
could make the body of the `while` loop an `fprintf` with interesting
variables like:


``` <!---c-->
    fprintf(stderr,
         "argv=%lo *argv=%lo **argv=%c argv[1]=%lo *argv[1]=%c argc=%d\n",
         (long) argv, (long) *argv, *argv && **argv ? **argv : '@',
         (long) argv[1], argv[1] && *argv[1] ? *argv[1] : '@', argc);
```

... which is what the [alternate code](#alternate-code) is.


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
