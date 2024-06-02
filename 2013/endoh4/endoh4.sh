#!/usr/bin/env bash
#
# endoh4.sh - run IOCCC entry 2013/endoh4 without cursor being in the way
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
[[ -z "$CC" ]] && CC="cc"

# let user redefine size. This requires that we clobber so that they can change
# it each time.
[[ -z "$SIZE" ]] && SIZE=70,23

make clobber CC="$CC" SIZE="$SIZE" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

# set it so that when program is terminated through various signals we re-enable
# the cursor
trap "tput cnorm;echo" 0 1 2 3 15

# temporarily disable cursor
tput civis

# run program attempting to feed it a file, if specified
if [[ "$#" -gt 0 ]]; then
    while [[ "$#" -gt 0 ]]; do
	read -r -n 1 -p "Press any key to run: ./endoh4 < $1: "
	echo 1>&2
	./endoh4 < "$1"
	echo 1>&2
	shift 1
    done
else
    # otherwise feed the source code of the program to the program
    read -r -n 1 -p "Press any key to run: ./endoh4 < endoh4.c: "
    echo 1>&2
    ./endoh4 < endoh4.c
    echo 1>&2
fi

# explicitly set cursor back just in case it's not terminated through one of the
# above signals
tput cnorm
