## To build:

``` <!---sh-->
    make
```

There is an alternate version of this entry. See [Alternate
code](#alternate-code) below for more details.


## To use:

``` <!---sh-->
    ./prog < textfile
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

Compare [prog.c](%%REPO_URL%%/2018/anderson/prog.c) and [prog.alt.c](%%REPO_URL%%/2018/anderson/prog.alt.c) and find out why we had to
modify the entry, and what confused the author (see the author's remarks).  No,
it was not the shape of the Roman V that we, or the compiler, didn't like.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `prog.alt` as you would `prog` above.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```


## Judges' remarks:

With this entry, you won't need to turn your monitor [upside
down](http://en.wikipedia.org/wiki/River_%28typography%29)!


## Author's remarks:

### Compiling the program:

``` <!---sh-->
    cc -Wall -Wextra -Wpedantic -O3 -std=c11 prog.c -o prog
```

Also works with a standard of C99, but C90/C89 will not compile due to
`for` loop initial declarations, along with additional warnings about
variable length arrays and lack of a `return` statement.


### Additional info:

This small program, when given text on `stdin`, will produce a pattern of
squiggly lines. This pattern is deterministic, and it shouldn't be too
difficult to determine from whence they come. There is even a comment
that describes the highlighted phenomena in the source, for those that
require a small nudge. With denser text blocks, such as an essay or
similar prose, the output can be rather pretty, in an chaotic emergence
sort of way. Try using this file, or the source file as inputs.

In its current form, this program can handle lines of length 255; to
adjust this limit, change the variable `a` at the top of the source.
Other adjustments, such as the exact printed characters, are rather
easy, once sufficient reverse engineering has occurred. Improvements
such as proper handling of tabs are left as an exercise to the reader.

In developing this program, the author found a potentially interesting
bug. If the expression `(j=k,j)` (near the middle of the source) is
changed to `(j=k,k)`, the program produces different output. The author
used gcc 5.4.0, compiled for `x86_64-linux-gnu`. Enabling or
disabling optimization produces the same results. The author is not
sure who is the culprit, but instead shrugged and moved on with life.
Of course, YMMV with your own environment.

The structure of this program, as you may have deduced, is two `for`
loops, one nested in the other. There are also a bunch of direct
variable assignments, such as `j=k`. There is some filler fluff, such as
`0-0+0`, but all that sort should be rather easy to spot. It was mostly
added for the purpose of making certain things line up right, and only
secondarily to obfuscate.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
