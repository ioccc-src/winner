#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2000/primenum
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
[[ -z "$CC" ]] && CC="cc"

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: echo IOCCC 23209 | ./primenum 23209: "
echo 1>&2
echo IOCCC 23209 | ./primenum 23209
echo 1>&2

read -r -n 1 -p "Press any key to run: echo THIS MESSAGE IS IN ALL CAPS | ./primenum 32: "
echo 1>&2
echo THIS MESSAGE IS IN ALL CAPS | ./primenum 32
echo 1>&2

rm -f try.sh.txt
read -r -n 1 -p "Press any key to run: ./primenum 101 < try.sh | ./primenum 101 > try.sh.txt: "
echo 1>&2
./primenum 101 < try.sh | ./primenum 101 > try.sh.txt
echo 1>&2

read -r -n 1 -p "Press any key to show try.sh.txt (space = next page, q = quit): "
echo 1>&2
less -rEXFK try.sh.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: diff -s try.sh try.sh.txt: " 1>&2
echo 1>&2
diff -s try.sh try.sh.txt

rm -f try.sh.txt
