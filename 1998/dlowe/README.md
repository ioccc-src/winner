## To build:

``` <!---sh-->
    make all
```

There is an alternate version available. See [Alternate code](#alternate-code)
below for more details.


## To use:

``` <!---sh-->
    ./dlowe < file > pootfile

    ./dlowe < file
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: missing or dead link - please provide them
```

For more detailed information see [1998/dlowe in bugs.html](../../bugs.html#1998_dlowe).


## Try:

``` <!---sh-->
    ./dlowe < README.md
    ./dlowe < README.md > README.poot.md
```

Why is there different output?

Also try:

``` <!---sh-->
    ./try.sh
```

Did you spot the Easter egg there?


## Alternate code:

The original entry was just a text based pootifier. This alternate version is
that program.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

```
    ./dlowe.alt < file > pootfile
```

What's the difference between this and `dlowe`?


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```

Did you spot the Easter egg there?


## Judges' remarks:

Why could this this entry be considered a utility?  Well because it
is able to convert content-free web pages into useful web pages.

To see why, try using an online version, modified for use as
a CGI program: <https://web.archive.org/web/20001025182142/http://pootpoot.com/poot/pootify?URL=http://www.microsoft.com>

We are sure that you will find that new web page to make a much
more consistent level of quality.  :-)


### Historical remarks:

A CGI script such as:

``` <!---sh-->
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

can be used to pootify web pages. This has been added as
[pootify.cgi.sh](%%REPO_URL%%/1998/dlowe/pootify.cgi.sh) which forbids `file://` based URLs and which
uses `lynx(1)` with the option referred to above. This will not, of course,
render it as html but rather show the modified html. Nevertheless, this has
**NOT** been tested as a CGI script with a webserver to display a pootified web
page.

The [pootify.sh](%%REPO_URL%%/1998/dlowe/pootify.sh) script has also been added which is a modification
to the above script which can be used to render html files locally with the
added bonus that one can use `file://` URLs. If one wants a CGI script they
should use the above one instead. You can use the script
[pootify.sh](%%REPO_URL%%/1998/dlowe/pootify.sh), however, to download and generate html files that you
can look at locally in a browser or pipe through `less(1)`. For instance:

``` <!---sh-->
    ./pootify.sh URL=https://microsoft.com | less

    ./pootify.sh -r URL=https://microsoft.com > ms.html
```

where the first one would show the text as rendered but without links, images
etc. and the second one would write the html to `ms.html` so that you could open
it in a browser.

For an old example of it working as a CGI script see:

``` <!---sh-->
    https://web.archive.org/web/20040326083431/http://www.pootpoot.com/poot/pootify/?URL=http%3A%2F%2Fwww.ioccc.org
```


## Author's remarks:

This program is a text filter, it reads `stdin` and outputs the
"corrected" text to `stdout`.

It is obfuscated in that the code is painful to look at and
its purpose and mode of operation are not terribly obvious.
More importantly, it is a tool for further obfuscation, in that it
can take any text and render it unintelligible.

Suggested uses: add to your `MANROFFSEQ` environment variable for man page
enjoyment; use it to turn the GPL into the `PPL`; see what happens when you
run `perl4` programs after they've been run through it; "encrypt" sensitive
(but unnecessary) documents...


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
