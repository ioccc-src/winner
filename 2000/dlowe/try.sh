#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2000/dlowe
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

read -r -n 1 -p "Press any key to run: echo '13 14 15 16 17 + - * / p' | ./dlowe: "
echo 1>&2
echo '13 14 15 16 17 + - * / p' | ./dlowe
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '12 13 14 15 16 + + + + f' | ./dlowe: "
echo 1>&2
echo '12 13 14 15 16 + + + + f' | ./dlowe
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '12 13 14 15 16 17 + - * / p' | ./dlowe: "
echo 1>&2
echo '12 13 14 15 16 17 + - * / p' | ./dlowe
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '+' | ./dlowe: "
echo 1>&2
echo '+' | ./dlowe
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '999999999999999 1 + p' | ./dlowe: "
echo 1>&2
echo '999999999999999 1 + p' | ./dlowe
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '99999999999999 1 + p' | ./dlowe: "
echo 1>&2
echo '99999999999999 1 + p' | ./dlowe
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '12.5 9 % 10 * 15 + f' | ./dlowe: "
echo 1>&2
echo '12.5 9 % 10 * 15 + f' | ./dlowe
echo 1>&2
