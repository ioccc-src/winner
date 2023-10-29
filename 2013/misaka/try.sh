#!/usr/bin/env bash

# make sure code compiled
make all || exit 1

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
