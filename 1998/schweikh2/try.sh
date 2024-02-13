#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC entry 1998/schweikh2
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

i=0
while [[ "$i" -lt 3 ]]; do
    NUM="$((RANDOM % 10))"
    read -r -n 1 -p "Press any key to run: ./yarng $NUM: "
    echo 1>&2
    ./yarng "$NUM"
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./yarng $NUM: "
    echo 1>&2
    ./yarng "$NUM"
    echo 1>&2

    ((i++))
done
