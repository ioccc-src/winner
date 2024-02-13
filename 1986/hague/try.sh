#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1986/hague
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

read -r -n 1 -p "Press any key to show input.txt: "
echo 1>&2
cat input.txt
echo 1>&2

read -r -n 1 -p "Press any key to feed input.txt to hague: "
echo 1>&2
./hague < input.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: echo IOCCC | ./hague: "
echo 1>&2
echo IOCCC | ./hague



