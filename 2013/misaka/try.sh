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

read -r -n 1 -p "Press any key to run: seq 1 12 | ./horizontal_cat - - -: "
echo 1>&2
seq 1 12 | ./horizontal_cat - - -
echo 1>&2

read -r -n 1 -p "Press any key to run: ./long_cat: "
echo 1>&2
./long_cat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./long_faat_cat: "
echo 1>&2
./long_faat_cat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./long_fat_cat: "
echo 1>&2
./long_fat_cat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./loong_cat: "
echo 1>&2
./loong_cat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./loooong_cat: "
echo 1>&2
./loooong_cat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./loooooooong_cat (space = next page, q = quit): "
echo 1>&2
./loooooooong_cat | less -EX
echo 1>&2

echo "Press any key to run: seq -f '%.0f  ' 45 | ./horizontal_cat - misaka.c"
read -r -n 1 -p "(space = next page, q = quit): "
echo 1>&2
seq -f '%.0f  ' 45 | ./horizontal_cat - misaka.c | less -EX
echo 1>&2
