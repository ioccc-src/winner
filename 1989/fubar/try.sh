#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1989/fubar
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

fubar()
{
    if [[ "$#" -ne 1 ]]; then
	echo "$0: expected 1 arg, got: $#" 1>&2
    else
	read -r -n 1 -p "Press any key to run: ./fubar.sh $1: "
	echo 1>&2
	./fubar.sh "$1"
    fi

}

for i in $(seq 1 7); do fubar "$i" ; done
