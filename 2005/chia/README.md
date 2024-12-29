## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./chia
```


## Judges' remarks:

Have you had your morning cup of Java?  You might want a
second cup before parsing this entry.  And give your C
pre-processor a triple shot as it tries to handle parameters
for "stringification".


## Author's remarks:

Two things inspired this entry. First, there were the C programs which were
`#define`'d to look like [Pascal][] or [Visual Basic][]: the
[/bin/sh](https://en.wikipedia.org/wiki/Bourne_shell) code from [V7
Unix](https://en.wikipedia.org/wiki/Version_7_Unix) (which reportedly was the
motivation behind this contest!), the [VAL
Linker](http://dunfield.classiccmp.org/dos/val_src.zip) by David Troendle, the
[2000/primenum](../../2000/primenum/index.html) IOCCC entry, ... Looking at these
programs, I thought, "hmm... if it's possible to make C code look like some
weird cross between Pascal, VB, and COBOL, then how about making C code look
like some other language?"

As chance would have it, I was writing some [Java][] code at that time, and one of
my net friends was also working on someone else's Java code. We both hated
Java; indeed, I hated Java so much that I was tired of hating it. Then I
remembered my earlier idea: "Of course! Why not write C code that looks like
Java? And poke fun at Java while I'm at it? All ye behold, as I turn anger
into action! PH34R MII!!!!!!!" And so, this entry was born. :-)

Besides carrying a revolutionary message in the comments, this entry also
draws a spiffy little [Koch snowflake
fractal](https://en.wikipedia.org/wiki/Koch_snowflake) on the screen, with the help of
[ANSI escape sequences](https://en.wikipedia.org/wiki/ANSI_escape_code).

The code requires a preprocessor that can stomach all kinds of nonsense that
are passed as parameters to macros for stringification. GNU
[cpp](https://en.wikipedia.org/wiki/C_preprocessor) handles such
things just fine, but certain broken preprocessors may decide to freak out
when they see macro parameters that don't look like C tokens.

[Pascal]: https://en.wikipedia.org/wiki/Pascal_(programming_language)
[Visual Basic]: https://en.wikipedia.org/wiki/Visual_Basic_(classic)
[Java]: https://en.wikipedia.org/wiki/Java_(programming_language)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
