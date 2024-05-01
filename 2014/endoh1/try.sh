#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2014/endoh1
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

read -r -n 1 -p "Press any key to show prog.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK prog.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog > main.c: "
echo 1>&2
./prog > main.c
read -r -n 1 -p "Press any key to run: make main: "
echo 1>&2
make main

read -r -n 1 -p "Press any key to run: ./main IOCCC: "
echo 1>&2
./main IOCCC
echo 1>&2

read -r -n 1 -p "Press any key to run: ./main Hello: "
echo 1>&2
./main Hello
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog IOCCC: "
echo 1>&2
./prog IOCCC

echo 1>&2

read -r -p "Do you want to run make rake (Y/N)? "
if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
    make clobber
    make rake 2>/dev/null
fi
