#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2004/schnitzi
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


echo "$ ./schnitzi <schnitzi.inp0 | vi -n" 1>&2
./schnitzi <schnitzi.inp0 | vi -n

read -r -n 1 -p "Press any key to continue: "
echo

echo "$ ./schnitzi <schnitzi.inp1 | vi -n" 1>&2
./schnitzi <schnitzi.inp1 | vi -n
