#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1990/westley
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

read -r -n 1 -p "Press any key to run: ./westley 1: "
echo 1>&2
./westley 1
echo 1>&2

read -r -n 1 -p "Press any key to run: ./westley 2: "
echo 1>&2
./westley 2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./westley 3: "
echo 1>&2
./westley 3
echo 1>&2

read -r -n 1 -p "Press any key to run: ./westley 5: "
echo 1>&2
./westley 5
echo 1>&2
