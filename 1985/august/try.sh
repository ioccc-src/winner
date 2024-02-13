#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1985/august
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

REV="$(type -P rev)"

read -r -n 1 -p "Press any key to run: ./august | head -n 11: "
echo 1>&2
./august | head -n 11

if [[ -n "$REV" ]]; then
    echo 1>&2
    read -r -n 1 -p "Press any key to reverse bits: "
    echo 1>&2
    ./august | head -n 11 | "$REV"
fi

# run primes.sh too
echo 1>&2
read -r -n 1 -p "Press any key to run: ./primes.sh: "
echo 1>&2
./primes.sh
exit 0
