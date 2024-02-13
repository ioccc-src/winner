#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2004/jdalbec
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# start out with default 11
make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: ./jdalbec 11 | head: "
echo 1>&2
./jdalbec 11 | head
echo 1>&2
read -r -n 1 -p "Press any key to run: ./jdalbec 47 | head | grep ':': "
echo 1>&2
./jdalbec 47 | head | grep ':'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./jdalbec 1 | head: "
echo 1>&2
./jdalbec 1 | head
echo 1>&2

read -r -n 1 -p "Press any key to run: ./jdalbec 1 1 | head: "
echo 1>&2
./jdalbec 1 1 | head
echo 1>&2
