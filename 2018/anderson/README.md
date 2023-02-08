# Most able to divine code gaps

Derek Anderson  


## Judges' comments:
### To use:

    make
    ./prog < textfile

### Try:

    ./prog < prog.c
    ./prog < prog.orig.c
    ./prog < hint.text

### Selected Judges Remarks:

With this entry, you won't need to turn your monitor [upside down](http://en.wikipedia.org/wiki/River_%28typography%29)!

Compare `prog.c` and `prog.orig.c` and find out why we had to modify the entry, and what confused the author
(see the author's remarks). No, it was not the shape of the Roman V that we, or the compiler, didn't like.


## Author's comments:
## Compiling the program

    gcc -Wall -Wextra -Wpedantic -O3 -std=c11 prog.c -o prog

Also works with a standard of c99, but c90/c89 will not compile due to
for loop initial declarations, along with additional warnings about
variable length arrays and lack of a return statement.

## Additional info

This small program, when given text on stdin, will produce a pattern of
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
used compiler gcc 5.4.0, compiled for x86_64-linux-gnu. Enabling or
disabling optimization produces the same results. The author is not
sure who is the culprit, but instead shrugged and moved on with life.
Of course, YMMV with your own environment.

The structure of this program, as you may have deduced, is two for
loops, one nested in the other. There is also a bunch of direct
variable assignment, such as `j=k`. There is some filler fluff, such as
`0-0+0`, but all that sort should be rather easy to spot. It was mostly
added for the purpose of making certain things line up right, and only
secondarily to obfuscate.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
