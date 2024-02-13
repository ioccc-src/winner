#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1987/hines
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

show()
{
    if [[ "$#" -ne 1 ]]; then
	echo "$0: expected 1 arg to show(), got: $#" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to show $1 (space = next page, q = quit): "
    echo 1>&2
    less -rEXF "$1"
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./hines $1: "
    echo 1>&2
    ./hines "$1"
    echo 1>&2
}

show hines.c

show goto.c

show goto.txt
