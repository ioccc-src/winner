#!/usr/bin/env bash
#
# try.sh - show IOCCC winner 1995/esde
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

echo "$ ./esde esde.data Johanson"
./esde esde.data Johanson
echo

echo "$ ./esde esde.data2 read"
./esde esde.data2 read
echo

echo "$ ./esde README.md date"
./esde README.md date
