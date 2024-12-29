#!/usr/bin/env bash
#
# try.sh - show IOCCC entry 1992/buzzard.1

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi
make CC="$CC" all >/dev/null || exit 1

# clear screen so only entry is shown
#
clear

read -r -n 1 -p "Press any key to run: ./buzzard.1 0 10: "
echo 1>&2
./buzzard.1 0 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./buzzard.1 56 720: "
echo 1>&2
./buzzard.1 56 720

read -r -n 1 -p "Press any key to run: ./buzzard.1 1 521: "
echo 1>&2
./buzzard.1 1 521
echo 1>&2

read -r -n 1 -p "Press any key to run: ./buzzard.1 '1+1' 111: "
echo 1>&2
./buzzard.1 '1+1' 111
echo 1>&2

read -r -n 1 -p "Press any key to run: ./buzzard.1 '1+1' 11: "
echo 1>&2
./buzzard.1 '1+1' 11
echo 1>&2

read -r -n 1 -p "Press any key to run: ./buzzard.1 '1+1' 1: "
echo 1>&2
./buzzard.1 '1+1' 1
