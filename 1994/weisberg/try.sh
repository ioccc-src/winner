#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1994/weisberg
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

read -r -n 1 -p "Press any key to run: ./weisberg | head -n 15: "
echo 1>&2
./weisberg | head -n 15
echo 1>&2

read -r -n 1 -p "Press any key to run: ./weisberg | head -n 42 (space = next page, q = quit): "
echo 1>&2
./weisberg | head -n 42 | less -rEXF
echo 1>&2

if [[ -n "$REV" ]]; then
    echo 1>&2
    read -r -n 1 -p "Press any key to reverse ./weisberg | head -n 15: "
    echo 1>&2
    ./weisberg | head -n 15 | "$REV"

    read -r -n 1 -p "Press any key to reverse: ./weisberg | head -n 42 (space = next page, q = quit): "
    echo 1>&2
    ./weisberg | head -n 42 | "$REV" | less -rEXF
    echo 1>&2
fi

# run primes.sh too
echo 1>&2
read -r -n 1 -p "Press any key to run: ./primes.sh: "
echo 1>&2
./primes.sh
echo 1>&2

read -r -n 1 -p "Press any key to run: ./primes.sh 25: "
echo 1>&2
./primes.sh 25
echo 1>&2
exit 0
