#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/mills2
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

read -r -n 1 -p "Press any key to run: printf '000I\236\f\31H\260\240\301\203' > ioccc.Z: "
echo 1>&2
printf '000I\236\f\31H\260\240\301\203' > ioccc.Z
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog ioccc.Z: "
echo 1>&2
./prog ioccc.Z
echo 1>&2

read -r -n 1 -p "Press any key to run: dd bs=512 count=128 < /dev/urandom > test1: "
echo 1>&2
dd bs=512 count=128 < /dev/urandom > test1
echo 1>&2

read -r -n 1 -p "Press any key to run: compress < test1 > test1.Z: "
echo 1>&2
compress < test1 > test1.Z
echo 1>&2

read -r -n 1 -p "Press any key to run: time ./prog test1.Z | diff -s - test1: "
echo 1>&2
time ./prog test1.Z | diff -s - test1
echo 1>&2

read -r -n 1 -p "Press any key to run: dd bs=512 count=128 < /dev/zero > test2: "
echo 1>&2
dd bs=512 count=128 < /dev/zero > test2
echo 1>&2

read -r -n 1 -p "Press any key to run: compress < test2 > test2.Z: "
echo 1>&2
compress < test2 > test2.Z
echo 1>&2

read -r -n 1 -p "Press any key to run: time ./prog test2.Z | diff -s - test2: "
echo 1>&2
time ./prog test2.Z | diff -s - test2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog ioccc_guidelines.txt.Z (space = next page, q = quit): "
echo 1>&2
./prog ioccc_guidelines.txt.Z | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog ioccc_rules.txt.Z (space = next page, q = quit): "
echo 1>&2
./prog ioccc_rules.txt.Z | less -rEXFK
