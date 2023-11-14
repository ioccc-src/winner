#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2011/akari
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# in this case we won't fail if we can't compile the code because we can still
# run the supplementary program.
make CC="$CC" all >/dev/null

# clean out old binaries except the entry itself
rm -f akari2 akari3 akari4

# clear screen after compilation so that only the entry is shown
clear

./akari < example.ppm > odd_output.ppm
./akari - - even < example.ppm > even_output.ppm
./akari example.ppm odd_output.ppm

make akari2 || exit 1
cat akari2.c

./akari2 < akari2.c
./akari2 rot13 < akari2.c

make akari3 || exit 1
cat akari3.c

./akari3

make akari4 || exit 1
cat akari4.c

./akari4
