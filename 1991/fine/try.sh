#!/usr/bin/env bash
#
# try.sh - script to demonstrate IOCCC entry 1991/fine
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi
make CC="$CC" all >/dev/null || exit 1

# clear screen to remove any compiler message to make the entry stand out more
clear

fine()
{
    if [[ "$#" != 1 ]]; then
	echo "$0: expected 1 arg, got $#" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: echo $1 | ./fine: "
    echo 1>&2
    echo -n "$1 <-> "
    echo "$1" | ./fine
    echo 1>&2
}

fine "Green terra"
fine "Vex"
fine "Tang"
fine "Vend onyx"
fine "Cheryl be flashy"
fine "Rail"
fine "Clerk"
fine "Ones"
fine "Fur"
fine "Er"
fine "IV"
fine "NYC"
fine "Fubar"
fine "DQ"
fine "Off"
fine "Ire"
fine "PEP"
fine "The rug gary lenT"
