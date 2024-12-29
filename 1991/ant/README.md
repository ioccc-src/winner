## To build:

``` <!---sh-->
    make all
```

The author provided an unobfuscated version and there is an alternate version
that might feel a bit more familiar to vi(m) users. See [Alternate
code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./ant some_file
```

**NOTE**: the file must already exist and not specifying any arg will make the
program exit without doing anything.


## Try:

``` <!---sh-->
    make hill
    ./ant hill
```

``` <!---sh-->
    make mole
    ./ant mole
```


## Alternate code:

The author provided us with an unobfuscated version,
[ant.alt.c](%%REPO_URL%%/1991/ant/ant.alt.c).

The other alternate version, [ant.alt2.c](%%REPO_URL%%/1991/ant/ant.alt2.c)
changes the commands slightly so that to go to the first column you should enter
`0`, to go to the last column you should enter `$`, to quit you should enter
`q`, to go back a word you should enter `b` and to go forwards a word you should
enter `w`.  Also, and perhaps most useful, rather than having to hit ctrl-L
(form-feed, `\f`) to get back to command mode you can use the usual ESC
(`\x1b`); the author explains why this was not originally done in their remarks
below. These slight modifications will make it slightly less unwieldy for those
familiar with vi(m); the rest was unchanged.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

For the unobfuscated version, use `ant.alt` as you would `ant` above; for the
other one, use `ant.alt2` as you would `ant` above but with the changes in the
input keys described above. See the author's remarks for the remaining commands.


## Judges' remarks:

The author was kind enough to supply a list of references below,
in case you are still confused after read the source!  :-)

**BTW**: you've most likely heard the joke that if you want a pseudo-random string
of characters you can put a user unfamiliar with vi(m) in a vi(m) session (in
insert mode) and ask them to exit. Well in this case you're likely to have this
problem if you ARE a vi(m) user! :-) ... especially if you don't read the
information below. This means if you're reading this in vi(m) you'll have to
exit this like in normal vi(m) and then try the same with `./ant` only to fail. :-)

**NOTE**: to enter form feed you should be able to hit `ctrl-L`. This will allow you
to exit insert mode rather than ESC like in normal vi(m). See the author's
commands section for other commands.


## Author's remarks:

Ant's Editor vIOCCC91

Text files consists of lines of printable text or tab characters.  A line can be
of arbitrary length and is delimited by either a newline or the end of file.
Carriage return is mapped to newline on input and ignored on output.  Tab stops
are every eight columns.  Non-printable characters may have unpredictable
results depending on the implementation of `curses`.


### Commands

```
    h j k l         left,
                    down,
                    up,
                    right
                    cursor movement
    H J K L         word left,
                    page down,
                    page up,
                    word right
    [ ]             beginning and
                    end of line
    t b             top and bottom
                    of file
    i               enter insert
                    mode, form-feed
                    to quit
    x               delete character
                    under the cursor
    W               write buffer to file
    R               refresh the screen
    Q               quit
```


### Exit status

```
    0               success
    2               missing edit
                    filename
```


### About this entry

The `BUF` size should be set at compile time to 32767.  This value was used
because the Sozobon C compiler for the Atari ST has 16 bit ints and a limit on
the size of arrays & structures of 32k.  Also the WatCom C compiler for the PC
also has 16 bits ints.  On machines that have 32 bit ints (most unix boxes), a
larger value for `BUF` could be used.

It is recommend that compact memory model be used on PC class machines.  Small
memory model may work too provided `BUF` is not too large.

The character constants `'\b'`, `'\f'`, `'\n'`, `'\r'`, `'\t'` are used in order
to provide more portable code, since the compiler should handle the translation
of them into the native character set.  Note that `'\f'` (form-feed) was used to
exit insert mode because K&R C had no escape constant for the escape-key.

My goals for this project were to learn and experiment with the Buffer Gap
Scheme [Fin80][net90], write a useful and *portable* program, and meet the
requirements of the IOCCC.  I initially planned to have a mini `curses` built-in
like [John Tromp](../../authors.html#John_Tromp)'s
[1989/tromp](../../1989/tromp/index.html) Tetris entry,
however this was not as portable as using a `curses` library with
`TERMINFO`/`TERMCAP` support.

I plan to post follow-ups such as unobfuscated versions and bugs fixes to
comp.editors.  Reposts of the editor.101, gap.doc, and editor.102 can be found
in the same group every so often.

This entry will display a file with long lines, but has trouble scrolling the
screen with long lines.  Paging up and down should work correctly, however.


### References:

[Fin80] Craig A. Finseth, "Theory and Practice of Text Editors or<br>
        A Cookbook For An EMACS", TM-165, MIT Lab. for Computer<br>
        Science

[KeP81] Kernighan & Plauger, "Software Tools in Pascal",<br>
        Addison-Wesley, 81, chapter 6

[Mil86] Eugene W. Myers & Webb Miller, "Row-replacement Algorithms
        for Screen Editors", TR 86-19, Dept. of Computer Science,<br>
        U. of Arizona

[MyM86] Eugene W. Myers & Webb Miller, "A simple row-replacement<br>
        method", TR 86-28, Dept. of Computer Science, U. of Arizona

[Mil87] Webb Miller, "A Software Tools Sampler", Prentice Hall, 87
        ISBN 0-13-822305-X, chapter 5

[net90] "Editor 101/102" articles from comp.editors


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
