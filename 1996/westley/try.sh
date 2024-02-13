#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC entry 1996/westley
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to show grandfather clock: "
echo 1>&2
WESTLEY=./westley ./clock1.sh
echo 1>&2

read -r -n 1 -p "Press any key to show alt mantle clock that runs backwards: "
echo 1>&2
WESTLEY=./westley ./clock2.sh
echo 1>&2

read -r -n 1 -p "Press any key to show alt linear style clock: "
echo 1>&2
WESTLEY=./westley ./clock3.sh
echo 1>&2
