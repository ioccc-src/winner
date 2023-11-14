#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2013/misaka
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

echo "$ seq 1 12 | ./horizontal_cat - - -"
seq 1 12 | ./horizontal_cat - - -
sleep 1

echo "$ ./long_cat"
./long_cat
sleep 1

echo "$ ./long_faat_cat"
./long_faat_cat
sleep 1

echo "$ ./long_fat_cat"
./long_fat_cat
sleep 1

echo "$ ./loong_cat"
./loong_cat
sleep 1

echo "$ ./loooong_cat"
./loooong_cat
sleep 1

echo "$ ./loooooooong_cat"
./loooooooong_cat
sleep 1

echo "$ seq -f '%.0f  ' 45 | ./horizontal_cat - misaka.c"
seq -f '%.0f  ' 45 | ./horizontal_cat - misaka.c
