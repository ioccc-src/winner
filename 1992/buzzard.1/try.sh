#!/usr/bin/env bash

make all >/dev/null || exit 1

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
