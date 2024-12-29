#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 2004/jdalbec alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# start out with default 11
make clobber CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: ./jdalbec.alt 11 | head: "
echo 1>&2
./jdalbec.alt 11 | head
echo 1>&2

read -r -n 1 -p "Press any key to run: ./jdalbec.alt 47 | head -n 52572 | grep ':': "
echo 1>&2
./jdalbec.alt 47 | head -n 52572 | grep ':'
echo 1>&2

read -r -n 1 -p "Press any key to set 7 numbers per line: "
echo 1>&2
make clobber CC="$CC" Ag=7 alt >/dev/null || exit 1

read -r -n 1 -p "Press any key to run: ./jdalbec.alt 101 | head: "
echo 1>&2
./jdalbec.alt 101 | head
echo 1>&2

read -r -n 1 -p "Press any key to run: ./jdalbec.alt 7 | head -n 47 | grep ':': "
echo 1>&2
./jdalbec.alt 7 | head -n 47 | grep ':'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./jdalbec.alt 1 1 | head: "
echo 1>&2
./jdalbec.alt 1 1 | head
echo 1>&2
