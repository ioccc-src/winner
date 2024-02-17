#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1992/gson
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

# attempt to find a dictionary file if DICT unset or not a regular readable file
#
if [[ -z "$DICT" || ! -f "$DICT" || ! -r "$DICT" ]]; then
    DICT="/usr/share/dict/words"

    if [[ ! -r "$DICT" ]]; then
	DICT="/usr/share/lib/spell/words"

	if [[ ! -r "$DICT" ]]; then
	    DICT="/usr/ucblib/dict/words"
	    
	    if [[ ! -r "$DICT" ]]; then
		DICT="/dev/null"
	    fi
	fi
    fi
fi

ag()
{
    if [[ "$#" -lt 2 ]]; then
	echo "$0: ag() requires at least two args, given: $#" 1>&2
	return
    fi

    echo "$ ./ag ${@:2} < $1" 1>&2
    read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
    echo 1>&2
    ./ag "${@:2}" < "$1" 2>/dev/null | less -rEXF

    echo 1>&2
}
# safety check that DICT is not empty and is a readable file
#
if [[ -n "$DICT" && -f "$DICT" && -r "$DICT" ]]; then
    ag "$DICT" free software foundation
    ag "$DICT" obfuscated c contest
    ag "$DICT" unix international
    ag "$DICT" george bush
    ag "$DICT" bill clinton
    ag "$DICT" ross perot
    ag "$DICT" paul e tsongas
fi

# now try making our own dictionary with mkdict.sh:
#
rm -f words
cat README.md try.sh Makefile | ./mkdict.sh > words
DICT="words"

read -r -n 1 -p "Press any key to use our own dict from mkdict.sh: "
echo 1>&2
ag "$DICT" free software foundation
ag "$DICT" obfuscated c contest
ag "$DICT" unix international
ag "$DICT" george bush
ag "$DICT" bill clinton
ag "$DICT" ross perot
ag "$DICT" paul e tsongas

