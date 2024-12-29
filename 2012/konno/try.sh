#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/konno
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

# let user specify args to run on program too
while [[ "$#" -ge 1 ]]; do
    read -r -n 1 -p "Press any key to run: ./konno $1: "
    echo 1>&2
    ./konno "$1"
    echo 1>&2
    shift 1
done

# use ten random values (in range $((RANDOM % 101)))
i=0
# we do it this way to prevent the annoying shellcheck warning that 'i' appears
# to be unused (as it would be if 'for i in {0..9}; do .. done').
while [[ "$i" -lt 10 ]]; do
    NUM="$((RANDOM % 101))"
    read -r -n 1 -p "Press any key to run: ./konno $NUM: "
    echo 1>&2
    ./konno "$NUM"
    echo 1>&2
    ((i++))
done


konno()
{
    if [[ "$#" -ne 1 ]]; then
	echo "$0: konno() requires 1 arg, given: $#" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: ./konno $1: "
    echo 1>&2
    ./konno "$1"
    echo 1>&2
}
konno 30

konno 90

konno 102

konno 109

konno 165

konno 42 

konno 37 

konno 255 

konno 10000
