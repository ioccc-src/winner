#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 1986/stein
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

echo "$ ./stein \$(printf \"\\015\\015\"); echo" 1>&2
./stein $(printf "\015\015"); echo

echo "$ ./stein \$(printf \"\\014\\015\"); echo" 1>&2
./stein $(printf "\014\015"); echo

echo "$ ./stein" 1>&2
./stein
