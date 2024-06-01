## To build:

``` <!---sh-->
    make
```

There is an alternate version that is slightly deobfuscated. See [alternate
code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./zeitak < file
```

where `file` is the file to be checked for nesting errors. For example, you may
try [incorrect.1.quote.c](%%REPO_URL%%/2012/zeitak/incorrect.1.quote.c) and the program itself. You may also run it on
text files that are not code.


## Try:

``` <!---sh-->
    ./try.sh
```

NOTE: the program prints an error and exits on the first nesting error so it
will not detect multiple issues.


## Alternate code:

The alternate code, [zeitak.alt.c](%%REPO_URL%%/2012/zeitak/zeitak.alt.c), is a version that was slightly
deobfuscated by the author. You may find reading it helpful in your attempt to
understand this extremely subtle entry.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

Use `zeitak.alt` as you would `zeitak` above.


## Judges' remarks:

This is an extremely subtle and twisted piece of Gold award winning code!

The judges spent a considerable amount of time analyzing this entry.
At one point we spent
[18
minutes](https://web.archive.org/web/20130925190722/https://twitter.com/ioccc/status/252162898800033792)
just to understand _18 key **characters**_ of this code.

NOTE: if you use vim to view the code, make sure to do:

```
    :set tabstop=4
```

in command mode, before looking at the code, to see the correct layout.


## Author's remarks:

### Nesting Errors Detector


#### What does it do

As you have probably understood by looking at the source\*, this program has
something to do with parenthesis (and equality of opening and closing
parenthesis, if you look close enough). It goes over the file given to it and
checks that every opening `(`, `[`, or `{` has a matching closing one and
vice versa. It also checks that every `"` or `'` is closed.

If an error is detected, an error message will be printed. If the problem
is a superfluous closing bracket, it will even print a few characters
around it's position.

\* Make sure you view the source with 4 spaces tab width.


#### Features

* Ignores parenthesis inside strings or character constants, so no errors
  will be detected in the following line:

``` <!---c-->
    printf(")");
```

* Doesn't get confused by the [1984/anonymous](../../1984/anonymous/index.html) entry!


#### Mis-Features

* Escapes (e.g. `\"`) are ignored, so the following line will produce
  an error:

``` <!---c-->
    printf("\"");
```

#### Obfuscation

[IOCCC entries](../../years.html) already contain entries without digits, control-flow
keywords and certain operators in their source. This entry has an
even more limited source, that is:

* Without any digits.
* Without any character constants.
* Without using functions from headers other than `stdio`.
* Without any control-flow keywords (not even the `?:` operator).
* Without any arithmetic or logic operators!

So, what's left? Parenthesis, and lots of them, as looking at the source will
reveal immediately. The main obfuscation is building the whole algorithm using
only function calls, typecasts, array lookups and pointer operators.


#### Additional obfuscations include:

* Extensive reuse of identifiers: Macros share names with variables, inner
  curly braces scopes contain variables with names identical to those in the
  outer scopes and some of the variables have different uses in different
  parts of the program. Even the large array has more than one use.
* A complicated data structure with "unused" fields.
* Mostly one-letter identifiers.
* Complex recursion: A function might call itself once, twice, or not at all.


#### Compilation/Portability/Running Notes

* The program requires `char` to be one byte and pointers to be
  at least two bytes long.

* The program was tested on the following platforms:
    - Ubuntu 9.04 32-bit with GCC
    - Windows 7 32-bit with GCC
    - Windows 7 32-bit with OpenWatcom


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
