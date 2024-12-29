#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2006/toledo1
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


read -r -n 1 -p "Press any key to run: ./toledo1 00: "
echo 1>&2
./toledo1 00
echo 1>&2

read -r -n 1 -p "Press any key to run: ./toledo1 30: "
echo 1>&2
./toledo1 30
echo 1>&2

read -r -n 1 -p "Press any key to run: ./toledo1 99: "
echo 1>&2
./toledo1 99
echo 1>&2

read -r -n 1 -p "Press any key to run: ./toledo1 42: "
echo 1>&2
./toledo1 42
echo 1>&2

read -r -n 1 -p "Press any key to run: ./toledo1 11 # start is A8: "
echo 1>&2
./toledo1 11       # start is A8
echo 1>&2

read -r -n 1 -p "Press any key to run: ./toledo1 18 # start is H8: "
echo 1>&2
./toledo1 18       # start is H8
echo 1>&2

read -r -n 1 -p "Press any key to run: ./toledo1 81 # start is A1: "
echo 1>&2
./toledo1 81       # start is A1
echo 1>&2

read -r -n 1 -p "Press any key to run: ./toledo1 88 # start is H1: "
echo 1>&2
./toledo1 88       # start is H1
echo 1>&2

read -r -n 1 -p "Press any key to run: ./toledo1 44 # start is D5: "
echo 1>&2
./toledo1 44       # start is D5
echo 1>&2

echo "What happened with the last ones?" 1>&2
