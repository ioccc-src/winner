#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/zeitak
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

# assume no error: set ERROR to 0
ERROR=0

zeitak()
{
    if [[ "$#" != 2 ]]; then
	echo "$0: zeitak() expects two args, got: $#" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to show $1 (space = next page, q = quit): "
    echo 1>&2
    less -rEXFK "$1"
    read -r -n 1 -p "Press any key to test $1 for nesting errors: "
    echo 1>&2
    ./zeitak < "$1"
    EXIT_CODE="$?"
    if [[ "$EXIT_CODE" -ne "$2" ]]; then
	echo "Error: did not get exit code $2: $EXIT_CODE" 1>&2
	ERROR=1
    fi
    echo 1>&2
}

zeitak zeitak.c 3

zeitak anonymous.c 3

zeitak anonymous.alt.c 3

zeitak incorrect.brace.c 10

zeitak incorrect.bracket.c 10

zeitak incorrect.paren.c 10

zeitak incorrect.quote-esc.c 10

zeitak incorrect.3.quotes.c 10

zeitak incorrect.single.quote.c 10

zeitak incorrect.1.quote.c 10

zeitak incorrect.txt 10

zeitak incorrect.java 10

zeitak correct.java 3

exit "$ERROR"
