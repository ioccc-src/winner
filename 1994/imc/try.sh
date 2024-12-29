#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1994/imc
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

imc()
{
    if [[ "$#" != 1 ]]; then
	echo "$0: imc() expects 1, arg got: $#" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: ./imc $1: "
    echo 1>&2
    ./imc "$1"
    echo 1>&2

    # Notice how we run the program with the same arg as above. This is because it
    # will not show the same output as it is randomised.
    read -r -n 1 -p "Press any key to run: ./imc $1: "
    echo 1>&2
    ./imc "$1"
    echo 1>&2
}

# clear screen after compilation so that only the entry is shown
clear

imc 3
imc 4
imc 6
imc 13
imc 15
