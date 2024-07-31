## To build:

``` <!---sh-->
    make
```


## To use:

The author suggested that after compilation one should look at the generated
files. For instance:

``` <!---sh-->
    less generated1.c
    less generated2.c
    less generated3.c
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Code should be readable in any direction! This tool will help you rotate your
code so you don't have to stare at it sideways or even upside down. Rotating
this program left and recompiling will reveal other tools including a right rotate
and a shift program.

Strange things happen [when the world is upside
down](https://en.wikipedia.org/wiki/Wacky_Wednesday_&lpar;book&rpar;)! It is entirely possible
that this remark is completely misleading.

What exactly does the shift program do?

Like a great sliding puzzle (hint) this entry has six more programs that will
reveal messages and one more tool that can be used to reveal the final message
hidden in the original source.  All of these can be created using combinations
of `./left`, `./right` and `./shift` and the additionally generated programs.


## Author's remarks:

### Tools' usage:

`Nuko` is a text rotator: given some text in `stdin`, `Nuko` will write the
same text to `stdout`, but rotated 90 degrees counterclockwise.

``` <!---sh-->
    cc prog.c -o left
    ./left < input.txt > rotated_counterclockwise.txt
```

Due to static memory allocation, only the first 1K columns by 1K rows
are rotated, the rest are silently ignored.  But fear not, a separate
tool with dynamic memory allocation is included:

``` <!---sh-->
    ./left < prog.c > r1.c
    cc r1.c -o right
    ./right < input.txt > rotated_clockwise.txt
```

For variety, this second tool rotates clockwise instead of
counterclockwise.  Also, it can handle files larger than 1024x1024,
depending on how much memory you have.

Of course we wouldn't stop with just two rotations, if we continue to
rotate counterclockwise once more, we get another program.  This
program outputs a single message to `stdout`, which is the name of the
series that `Nuko` came from.

``` <!---sh-->
    ./left < prog.c | ./left > r2.c
    cc r2.c -o msg0
    ./msg0
```

There is one final rotation, which produces a tool that removes
leading whitespaces:

``` <!---sh-->
    ./left < prog.c | ./left | ./left > r3.c
    cc r3.c -o shift
    ./shift < input.txt > no_leading_space.txt
```

Where this might be useful, besides ruining the formatting of certain
files, is that it completes the set of tools needed to solve the
puzzle that is embedded in [prog.c](%%REPO_URL%%/2018/yang/prog.c).


### Puzzle box:

Notice how the edges of [prog.c](%%REPO_URL%%/2018/yang/prog.c) contain two notches.  By rotating
[prog.c](%%REPO_URL%%/2018/yang/prog.c) and removing leading space, the code would be shifted one space
toward one of those notches (and create a new notch on the other
side).  This shifted code behaves slightly different from the original
program.  For example, here are two more messages that can be
produced:

``` <!---sh-->
    ./shift < prog.c | ./right > msg1.c && gcc msg1.c -o msg1 && ./msg1
    ./shift < prog.c | ./left > msg2.c && gcc msg2.c -o msg2 && ./msg2
```

In total, there are 9 embedded strings that can be produced via a
sequence of rotates and shifts, one of which can be used to extract
the 10th final string from [prog.c](%%REPO_URL%%/2018/yang/prog.c).  The intent is to simulate those
wooden puzzle boxes that can be opened by pushing and shifting various
well-concealed seams.  Thus, finding the correct sequence of rotates
and shifts is left as an exercise to the reader (but if you are really
lazy, just read the [Makefile](%%REPO_URL%%/2018/yang/Makefile).

Source code for all the tools needed to solve this puzzle are embedded
in [prog.c](%%REPO_URL%%/2018/yang/prog.c), all you need is a C compiler.


### Features

- Code compiles when rotated 4 ways.  This required a bit of patience to
achieve.  Code still compiles even with one column of text shifted.  This
required even more patience.

- All rotated and shifted variants compile without warnings.  This involves
various tweaks to satisfy cases where the compiler is overly protective, including
but not limited to the "1125" at line 4 as opposed to "1025", to satisfy
`-Waggresive-loop-optimizations`.

- CRC32 of the code is embedded in the code itself.

- Process for writing [prog.c](%%REPO_URL%%/2018/yang/prog.c) is available in
[obfuscation.html](obfuscation.html).


### Compatibility:

`Nuko` and the rotated tools accept only ASCII files where each
character maps to exactly one byte.  Also, end-of-line sequence is
assumed to be LF only, as opposed to CR-LF.  All control characters
are treated like normal printable characters, so files containing tabs
will look weird after rotation, for example.

`Nuko` has been verified to work with these compiler / OS combinations:

- gcc 4.8.4 on Linux
- gcc 4.9.2 on Linux
- gcc 6.1.0 on JS/Linux
- gcc 6.3.0 on Linux
- gcc 6.4.0 on Cygwin
- clang 3.5.0 on Linux
- clang 3.8.1 on Linux
- clang 5.0.1 on Cygwin
- tcc 0.9.25 on JS/Linux

`Nuko` compiles without warnings with all compilers above, even with
`-Wall -Wextra -pedantic` for gcc and clang.


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program without running the command below.

If you get stuck, come back and run the following command:

``` <!---sh-->
    ./msg9 < prog.c
```

But what combinations will generate `./msg3`, `./msg4`, `./msg5`, `./msg6`,
`./msg7`, `./msg8` and finally `./msg9`?

For more hints try:

``` <!---sh-->
    make details
```

And for the last word, try:

``` <!---sh-->
    make the_last_word
```


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
