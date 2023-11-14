#!/usr/bin/env bash
#
# try.sh - show IOCCC winner 1992/buzzard.1

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi
make CC="$CC" all >/dev/null || exit 1

# clear screen so only entry is shown
#
clear

echo "$ ./buzzard.1 0 10" 1>&2
./buzzard.1 0 10
echo "$ ./buzzard.1 56 720" 1>&2
./buzzard.1 56 720
echo "$ ./buzzard.1 1 521" 1>&2
./buzzard.1 1 521

echo "$ ./buzzard.1 '1+1' 111" 1>&2
./buzzard.1 '1+1' 111
echo "$ ./buzzard.1 '1+1' 11" 1>&2
./buzzard.1 '1+1' 11
echo "$ ./buzzard.1 '1+1' 1" 1>&2
./buzzard.1 '1+1' 1
