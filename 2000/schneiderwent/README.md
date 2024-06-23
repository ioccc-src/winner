## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./schneiderwent
```


## Try:

``` <!---sh-->
    ./schneiderwent schneiderwent.data
    ./schneiderwent
```

What's the difference?

If you have a long while to spare (and you're bored enough that you could watch
paint dry :-) ) you might also try:

``` <!---sh-->
    ./try.sh
```

Alternatively, you can check on it later on, to see all the entry does. Or if
you wish to make it run faster, you can override how long it sleeps per
iterations and how many iterations it runs. For instance to make it sleep only
30 seconds and run only twice:

``` <!---sh-->
    SLEEP=30 ITERATIONS=2 ./try.sh
```


## Judges' remarks:

Very nice play by the rules and portable text obfuscation.
This far surpasses old tricks like adding or subtracting 1
from every character in a C string.

Translating the messages into your language of preference while
keeping the program portable between different encodings
(Chinese, Japanese, Russian - anyone?) may be an entertaining task.


## Author's remarks:

This entry displays the current time to the console, for example:

```
    it's just after ten 'til 6 in the evening
```

FWIW, none of the compilers with which this entry was tested issued
any warnings or errors in compiling the source for this entry.  No
doubt lint will complain about the goto statements.

The [schneiderwent.data](%%REPO_URL%%/2000/schneiderwent/schneiderwent.data) file consists of the values used by
multiple table lookups.  This is simply good program design, separating these
values from the source code allows changing the behavior of the application
without recompiling.

Having learned COBOL at an early age, the `pthread`s of my thought
processes tend to be translated into code in a verbose manner.  Some
of the `#define`s in this entry's code are to mitigate this personal
deficiency.

### Obfuscation

Obfuscation in this entry consists of:

* `printf(3)`ing console messages stored as
[EBCDIC](https://en.wikipedia.org/wiki/EBCDIC) character values - this is not
an attempt at encryption, but rather at cross platform compatibility.
* [ASCII](https://en.wikipedia.org/wiki/ASCII) character values are calculated
from the EBCDIC in a particularly ugly abuse of the `?:` operator.
* Detection of whether to print the ASCII or EBCDIC values is done by taking the
remainder of dividing the character `'J'` by `2` - the ASCII value of the
character is even, the EBCDIC value is odd.
* The messages to be `printf(3)`ed are determined via multiple table lookups and
bit-masked values.
* For minutes, the bit position turned on is multiplied by two to determine the
message to be `printf(3)`ed.
* For hours, the straight bit position is used.
* This entry mostly eschews function calls for the often overlooked
`setjmp(3)`/`longjmp(3)` combination.
* The trigraphs are not there as obfuscation nor are they there to annoy the
judges - it's just the easiest way to get around the absence of square brackets
in a normal 3270 environment.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
