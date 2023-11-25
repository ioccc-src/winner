## To build:

```sh
make all
```

There are three alt versions which demonstrate a problem that the code documents
(as an obfuscation technique) and what the judges document so you can see what
it looks like. See [alternate code](#alternate-code) below for more details.


## To use:

```sh
./cdupont
```


## Alternate code:

These three versions show what will happen if certain things are done that were
warned against: if you remove a comment and more so an unused `goto` label or if
you beautify it. The [cdupont.alt.c](cdupont.alt.c) is the one with both the
unused `goto` label and comments removed, the [cdupont.alt2.c](cdupont.alt2.c)
is the version that has these things removed and is also beautified and the
[cdupont.alt3.c](cdupont.alt3.c) is just beautified. This required changing the
`s` macro to be `__FILE__` as otherwise it would read in the original code which
doesn't have the modifications.


### Alternate build:


```sh
make alt
```


### Alternate try:


```sh
./cdupont.alt
./cdupont.alt2
./cdupont.alt3
```

Enjoy! :-)


## Judges' remarks:

Why is the following label necessary?

```c
sorryfor_this_unused_but_very_needed_label:
```

Notice that if you C beautify (cb) or pre-process this program, it
will no longer work correctly, if at all.  (go ahead, try it... :-))

NOTE: One should remove the final trailing newline to obtain the
original source file.  This step is not needed to compile
this entry.


## Author's remarks:

The source code holds the letters of the message. Each letter, combined
with another key letter, is used to compute the coordinates of the next
letter and key. Thus, the message is code.  That is why I use silly
comments, most often badly spaced.

The space character sequence between the words is given by a simple
computation in an octal constant (given here as an hex value, of
course).

This way, any message can be mixed into a code, since the keys allow
you to place the meaningful letters wherever you want.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
