#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2020/kurdyukov4
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

read -r -n 1 -p "Press any key to run: time ./prog Shakespeare.txt 2000 10 1: "
echo 1>&2
time ./prog Shakespeare.txt 2000 10 1
echo 1>&2

read -r -n 1 -p "Press any key to run: time ./prog Shakespeare.txt 2000 9 1: "
echo 1>&2
time ./prog Shakespeare.txt 2000 9 1
echo 1>&2

read -r -n 1 -p "Press any key to run: time ./prog Shakespeare.txt 2000 8 1: "
echo 1>&2
time ./prog Shakespeare.txt 2000 8 1

read -r -n 1 -p "Press any key to run: time ./prog Eugene_Onegin.txt 2000 10 1: "
echo 1>&2
time ./prog Eugene_Onegin.txt 2000 10 1

read -r -n 1 -p "Press any key to run: echo 00000000000000000000 01 02 02 02 02 02 02 > test.txt: "
echo 1>&2
echo "00000000000000000000 01 02 02 02 02 02 02" > test.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: time ./prog test.txt 1000 2 123: "
echo 1>&2
time ./prog test.txt 1000 2 123
echo 1>&2

read -r -n 1 -p "Press any key to run: make rand >/dev/null: "
echo 1>&2
make rand >/dev/null || exit 0
read -r -n 1 -p "Press any key to run: time ./rand test.txt 1000 2 123" 1>&2
echo 1>&2
time ./rand test.txt 1000 2 123

exit 0
