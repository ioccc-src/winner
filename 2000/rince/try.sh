#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2000/rince
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

echo "$ ./rince" 1>&2
./rince

echo "$ ./rince 0.001 $(./dmy2jd 7.8 1 1610)" 1>&2
./rince 0.001 $(./dmy2jd 7.8 1 1610)

echo "$ ./rince 0.01" 1>&2
./rince 0.01

echo "$ ./rince 0 2441193.6" 1>&2
./rince 0 2441193.6

echo "$ ./rince 0.01 2441193.6" 1>&2
./rince 0.01 2441193.6

echo "$ ./rince 0 $(./dmy2jd 7.8 1 1610)" 1>&2
./rince 0 $(./dmy2jd 7.8 1 1610)

echo "$ ./rince 0 $(./dmy2jd 8.8 1 1610)" 1>&2
./rince 0 $(./dmy2jd 8.8 1 1610)

echo "$ ./rince 0 $(./dmy2jd 10.8 1 1610)" 1>&2
./rince 0 $(./dmy2jd 10.8 1 1610)
