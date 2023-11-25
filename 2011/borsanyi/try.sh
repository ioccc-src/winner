#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2011/borsanyi
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


read -r -n 1 -p "Press any key to run: ./borsanyi < data.1: "
./borsanyi < data.1
echo 1>&2

read -r -n 1 -p "Press any key to run: ./borsanyi < data.2: "
./borsanyi < data.2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./borsanyi < data.3: "
./borsanyi < data.3
