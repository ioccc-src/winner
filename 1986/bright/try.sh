#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1986/bright
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


read -r -n 1 -p "Press any key to run: ./bright bright.c (space = next page, q = quit): "
echo 1>&2
./bright bright.c | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./bright bright | tail -n 15: "
echo 1>&2
./bright bright | tail -n 15
