Best Utility:

    David Lowe
    Pootpoot
    67-D Manchester Street
    San Francisco, CA 94110
    USA

    http://pootpoot.com/


Judges' Comments:

    To build:

	make dlowe

    To use:

	./dlowe < anyfile > pootfile

    Why is this entry would be considered a utility?  Well because it
    is able to convert content-free web pages into useful web pages.

    To see why, try using an online version, modified for use as
    a CGI program:

	http://pootpoot.com/poot/pootify?URL=http%3A%2F%2Fwww.microsoft.com

    We are sure that you will find that new web page to make a much
    more consistent level of quality.  :-)

    A CGI script such as:

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

    can be used to pootify web pages.

    For further information see:

	http://pootpoot.com/poot/pootify?URL=http%3A%2F%2Fwww.ioccc.org

    NOTE: The original entry was just a text based pootifier.  To build
    that version try:

	make dlowe.orig
	./dlowe.orig < anyfile > pootfile


Selected Author's Comments:

    This program is a text filter, it reads stdin and outputs the
    "corrected" text to stdout.

    It is obfuscated in that the code is painful to look at and
    its purpose and mode of operation are not terribly obvious.
    More importantly, it is a tool for further obfuscation, in that it
    can take any text and render it unintelligible.

    Suggested uses: add to your MANROFFSEQ environment variable for man page
    enjoyment; use it to turn the GPL into the PPL; see what happens when you
    run perl4 programs after they've been run through it; "encrypt" sensitive
    (but unnecessary) documents...
