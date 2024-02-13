#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2018/vokes
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

read -r -n 1 -p "Press any key to show example-1.txt: "
echo 1>&2
cat example-1.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < example-1.txt: "
echo 1>&2
./prog < example-1.txt
echo 1>&2


read -r -n 1 -p "Press any key to show example-2.txt: "
echo 1>&2
cat example-2.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < example-2.txt: "
echo 1>&2
./prog < example-2.txt
echo 1>&2

read -r -n 1 -p "Press any key to show example-tab.txt: "
echo 1>&2
cat example-tab.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < example-tab.txt: "
echo 1>&2
./prog < example-tab.txt

read -r -n 1 -p "Press any key to show ioccc.txt: "
echo 1>&2
cat ioccc.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < ioccc.txt: "
echo 1>&2
./prog < ioccc.txt
