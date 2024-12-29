#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2020/endoh2
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

read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
./prog
echo 1>&2

read -r -n 1 -p "Press any key to show hello.txt: "
echo 1>&2
cat hello.txt
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog hello.txt: "
echo 1>&2
./prog hello.txt
echo 1>&2

read -r -n 1 -p "Press any key to show yoda.txt: "
echo 1>&2
cat yoda.txt
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog yoda.txt: "
echo 1>&2
./prog yoda.txt

read -r -n 1 -p "Press any key to show bear.txt: "
echo 1>&2
cat bear.txt
read -r -n 1 -p "Press any key to run: ./prog bear.txt: "
echo 1>&2
./prog bear.txt

