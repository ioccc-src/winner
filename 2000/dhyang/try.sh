#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2000/dhyang
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


read -r -n 1 -p "Press any key to run: make saitou >/dev/null || exit 1: "
echo 1>&2
make saitou >/dev/null || exit 1
echo 1>&2

read -r -n 1 -p "Press any key to run: ./saitou | tee aku.c (space = next page, q = quit): "
echo 1>&2
./saitou | tee aku.c | less -rEXFK

read -r -n 1 -p "Press any key to run: make soku >/dev/null || exit 1: "
echo 1>&2
make soku >/dev/null || exit 1
echo 1>&2

read -r -n 1 -p "Press any key to run: ./soku | tee soku.c (space = next page, q = quit): "
echo 1>&2
./soku | tee soku.c | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: make zan >/dev/null || exit 1: "
echo 1>&2
make zan >/dev/null || exit 1
echo 1>&2

read -r -n 1 -p "Press any key to run: ./zan | tee zan.c (space = next page, q = quit): "
echo 1>&2
./zan | tee zan.c | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: make aku >/dev/null || exit 1: "
echo 1>&2
make aku >/dev/null || exit 1
echo 1>&2

read -r -n 1 -p "Press any key to run: ./aku | diff -s - aku.c: "
echo 1>&2
./aku | diff -s - aku.c
