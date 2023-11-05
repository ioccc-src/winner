## To build:

```sh
make all
```


## To use:

```sh
./dlowe < anyfile > pootfile
```


### Bugs and (Mis)features:

The current status of this entry is:

```
STATUS: missing or dead link - please provide them
```

For more detailed information see [1998 dlowe in bugs.md](/bugs.md#1998-dlowe).


### Try:

```sh
./dlowe < README.md
./dlowe < README.md > README.poot.md

```

Why is there different output?


## Alternate code:

NOTE: The original entry was just a text based pootifier.  To build
that version try:

```sh
make alt
./dlowe.alt < anyfile > pootfile
```

What's the difference between this and `dlowe`?


## Judges' remarks:

Why could this this entry be considered a utility?  Well because it
is able to convert content-free web pages into useful web pages.

To see why, try using an online version, modified for use as
a CGI program: <https://web.archive.org/web/20001025182142/http://pootpoot.com/poot/pootify?URL=http://www.microsoft.com>

We are sure that you will find that new web page to make a much
more consistent level of quality.  :-)

A CGI script such as:


```sh
#!/bin/sh
# pootify - a sample CGI pootifier
#
POOT="/usr/local/bin/dlowe"
LYNX="/usr/local/bin/lynx"
ECHO="/usr/bin/echo"
EXPR="/usr/bin/expr"
${ECHO} "Content-type: text/html"
${ECHO}
if [ -z "${QUERY_STRING}" ]; then
    ${ECHO} "QUERY_STRING not found"
else
    URL=`${EXPR} "$QUERY_STRING" : '[Uu][Rr][Ll]=\(.*\)'`
    if [ -z "${URL}" ]; then
	${ECHO} "No URL given in QUERY_STRING"
    elif [ X`${EXPR} "${URL}" : '[Ff][Ii][Ll][Ee]:'` != X0 ]; then
	${ECHO} "file: based URLs are not allowed"
    else
	${LYNX} -restrictions=all -source "${URL}" | ${POOT}
    fi
fi
```

can be used to pootify web pages.

For further information see:

```sh
https://web.archive.org/web/20040326083431/http://www.pootpoot.com/poot/pootify/?URL=http%3A%2F%2Fwww.ioccc.org
```


## Author's remarks:

This program is a text filter, it reads stdin and outputs the
"corrected" text to stdout.

It is obfuscated in that the code is painful to look at and
its purpose and mode of operation are not terribly obvious.
More importantly, it is a tool for further obfuscation, in that it
can take any text and render it unintelligible.

Suggested uses: add to your `MANROFFSEQ` environment variable for man page
enjoyment; use it to turn the GPL into the `PPL`; see what happens when you
run `perl4` programs after they've been run through it; "encrypt" sensitive
(but unnecessary) documents...


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
