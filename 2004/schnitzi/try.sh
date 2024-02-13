#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2004/schnitzi
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

# check for vi in the unlikely case it's not installed
#
if [[ -z "$(type -P vi)" ]]; then
    echo "$0: vi not installed, cannot proceed." 1>&2
    exit 1
fi

read -r -n 1 -p "Press any key to run: ./schnitzi <schnitzi.inp0 | vi -n: "
echo 1>&2
./schnitzi <schnitzi.inp0 | vi -n
echo 1>&2

read -r -n 1 -p "Press any key to run: ./schnitzi <schnitzi.inp1 | vi -n: "
echo 1>&2
./schnitzi <schnitzi.inp1 | vi -n
echo 1>&2
