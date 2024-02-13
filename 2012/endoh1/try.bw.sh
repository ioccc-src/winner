#!/usr/bin/env bash
#
# try.bw.sh - demonstrate IOCCC entry 2012/endoh1 w/o colour
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

if [[ "$#" -ne 1 ]]; then
    echo "usage: $0 file" 1>&2
    exit 1
fi

read -r -n 1 -p "Press any key to run: ./endoh1 < $1 (ctrl-c/intr to end program): "
./endoh1 < "$1"
