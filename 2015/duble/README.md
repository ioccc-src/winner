## To build:

``` <!---sh-->
    make
```

There is an alternate version of this entry, discussed in the author's remarks.
See [Alternate code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2015/duble in bugs.html](../../bugs.html#2015_duble).


## To use:

``` <!---sh-->
    echo Some text | ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```

As the script says if you want to move to the next command at any point
(lorem-ipsum.txt takes a while to print in particular) you may do so by hitting
ctrl-c/sending intr.


## Alternate code:

This alternate code, provided by the author, is discussed in more detail by the
author in the '[prog.c](%%REPO_URL%%/2015/duble/prog.c) vs [prog.alt.c](%%REPO_URL%%/2015/duble/prog.alt.c)' section of their remarks.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `prog.alt` as you would `prog` above.


## Judges' remarks:

Beautiful penmanship! However, your fonts may vary.

How does this entry compress the font it uses? What's the purpose of
`lrand48(3)`?  Why does the program dump core, when it does :) ?


## Author's remarks:

### Introduction

This program **prints text in your terminal with an interesting
hand-writing effect**.

It uses the *Braille patterns* range of the unicode standard: this
allows to consider each terminal character as a tiny 2x4 bitmap.

Turning the Braille code into something visual might be considered
blasphemous. When I was fighting to make this program work, I started
wondering if it was not the reason for its very erratic behaviour.


### [prog.c](%%REPO_URL%%/2015/duble/prog.c) vs [prog.alt.c](%%REPO_URL%%/2015/duble/prog.alt.c)

The file [prog.alt.c](%%REPO_URL%%/2015/duble/prog.alt.c) is the one I submitted.

[Gil Dogon](../../authors.html#Gil_Dogon) noted a few unsafe statements (statements
whose behaviour is undefined in the C standard and, as such, could cause issues
with other compilers or optimization levels). These have been fixed in
[prog.c](%%REPO_URL%%/2015/duble/prog.c).

After this fix, in order to remain rule-2-compliant, a variable name has also
been shortened in this file.


### How to build

If you have `clang`:

``` <!---sh-->
    CC=clang make -e
```

Otherwise (gcc):

``` <!---sh-->
    make
```

(You will get a few warnings in this case.)


### How to use it

You need a terminal configured to handle a *UTF-8* encoding and a font including
*Braille patterns*.

This is the default on most modern GNU/Linux operating systems.

The default terminal application (gnome-terminal) or even a simple xterm should
render things properly.

I tested this on several Debian and Ubuntu systems, 32 and 64bits and no
configuration was needed.

I also tested it on FreeBSD 9.3 32bits (font and encoding configuration was
needed in this case).


#### Basic mode:

``` <!---sh-->
    $ echo 'I am testing this thing.' | ./prog
    [... rendering ...]

    $ ./prog < lorem-ipsum.txt
    [... rendering ...]
```


#### Interactive mode:

``` <!---sh-->
    $ ./prog
    > hello world!!!
    [... rendering ...]
    >
```


### Obfuscation:

This entry is obfuscated in various ways:

*   The structure is hidden by avoiding loops, `if` statements, ternary
conditionals, and jump-related instructions. Instead, recursion is heavily
used.
*   Merging all functions into one added even more recursion. ;)
*   The provided code does not contain the same number of opening and closing
parenthesis.
*   Preprocessing the code inflates it and adds lots of indents. Removing some
of the tricks involved without breaking the program will be challenging.
*   The program 'plays' with standard input & output streams, which causes
unusual side effects.
*   Some variables are re-used for unrelated processes.
*   Crucial data may be hidden in unexpected places (e.g. as the size of a
temporary buffer).
*   Some parts of the code may have no effect (but may have an effect in a
specific context, who knows?), and classical libc functions may not act as
usual.
*   And of course variable names are hard to read (or distracting).

On the other hand, the following may help:

*   The code layout should help to identify which part of the code is
obfuscated. ;)
*   File [codes.txt](codes.txt) shows how each character is drawn. This data is
encoded in macro `O_o` at the top of the source file.


### Limitations:


#### Charset

In order to comply with the size rule, I encoded only a part of the visible ASCII
chars:

```
    a-z, A-Z, '.' ':' ',' ';' '!' and '?'.
```

Uppercase and lowercase chars are rendered the same. The program also
understands space and linefeed (`\n`).  Other chars are simply ignored (most of
the time ;)


#### Stack size

This limitation is due to the heavy use of recursion. After having processed a
large number of characters, the process may exceed the stack size and crash.
(However I did not experience this myself. The top-level recursion might be
removed by the compiler as part of its optimizations.)


#### Line rendering

The program does its best to avoid cutting words at the end of lines, but it
could still happen in case of long words.


### Subtleties and extra features


#### Handling more than text docs?

Given the limited set of characters handled, the program is mostly limited to
simple text documents.

Thus, if you try for example:

``` <!---sh-->
    $ ./prog < prog.c
```

You will not get something that looks like C code. (but you can still try, if
you are curious. :)


#### A 'draft' mode

Defining an environment variable called `DRAFT` will enable the 'draft-mode'.
Try for example:

``` <!---sh-->
    $ echo 'testing the draft mode' | DRAFT=1 ./prog
```

The program will run much faster but the rendering will be less precise.


#### The subtle interactive mode

I saved the best for last: usually, programs that handle an "interactive mode"
have to check whether their standard input is a terminal or not (by using
`isatty()`). Did you notice that this program does not perform any such
detection, but still behaves (or seems to behave) appropriately?

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
