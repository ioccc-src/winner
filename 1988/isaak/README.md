## To build:

``` <!---sh-->
    make all
```

There is an alternate version, the original, that can't be compiled in modern
systems but can be if you have an old enough compiler. See [Alternate
code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./isaak
```


## Alternate code:

The original version of this code is in
[isaak.alt.c](%%REPO_URL%%/1988/isaak/isaak.alt.c), with a minor fix so that it
will compile. The original entry starts with the line:

``` <!---c-->
    main(){};
```

This works on some systems.  Why?  Note that `#include <stdio.h>` is given on
the last line.  Why is this needed?  Note the unusual calls to `sprintf(3)`.

This version also relied on being able to define `#define` to something else and
using that macro for `#define`. This was fixed, however, so that you can at
least compile it in modern systems.

This version will not likely work on modern systems even though you should be
able to compile it.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `isaak.alt` as you would `isaak` above.


## Judges' remarks:

The program relies heavily on ASCII.  Don't even think of running it on
an EBCDIC machine.


### Historical notes about the original entry

NOTE: If you named the file anything other than `isaak.c`, you had to
change the `#include` on line 6. This limitation has been fixed in
[isaak.c](%%REPO_URL%%/1988/isaak/isaak.c) and
[isaak.alt.c](%%REPO_URL%%/1988/isaak/isaak.alt.c) by using the `__FILE__` macro.

NOTE: The use of null comments to separate macros to construct different tokens
from a single macro (e.g., `"O/**/O"` creates either `++` or `--` by defining
`O` to be `+` or `-`) may cause some strict ANSI C preprocessors to object.

NOTE: Most System V machines were not be able to execute this program correctly
due to the fact that BSD style systems have an `sprintf(3)` that returns a `char
*`.  Due to the above problems, we placed the output of this program in the
file [isaak.output.txt](isaak.output.txt).

Since this was fixed, this file is not strictly necessary, but we keep it for
historical purposes (decoded as it used to be uuencoded). See the
[isaak.orig.c](%%REPO_URL%%/1988/isaak/isaak.orig.c) for the original source.

FYI: We are likely to be more strict about portability in the future.


## Author's remarks:

No remarks were provided by the author.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
