#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2006/toledo1
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
./toledo1 00

read -r -n 1 -p "Press any key to run: ./toledo1 30: "
./toledo1 30

read -r -n 1 -p "Press any key to run: ./toledo1 99: "
./toledo1 99

read -r -n 1 -p "Press any key to run: ./toledo1 42: "
./toledo1 42

read -r -n 1 -p "Press any key to run: ./toledo1 11 # start is A8: "
./toledo1 11       # start is A8

read -r -n 1 -p "Press any key to run: ./toledo1 18 # start is H8: "
./toledo1 18       # start is H8

read -r -n 1 -p "Press any key to run: ./toledo1 81 # start is A1: "
./toledo1 81       # start is A1

read -r -n 1 -p "Press any key to run: ./toledo1 88 # start is H1: "
./toledo1 88       # start is H1

read -r -n 1 -p "Press any key to run: ./toledo1 44 # start is D5: "
./toledo1 44       # start is D5

echo "What happened with the last ones?" 1>&2
