#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/hou
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


read -r -n 1 -p "Press any key to run: echo IOCCC | ./prog: "
echo 1>&2
echo IOCCC | ./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: head -n 13 rfc1321.txt (space = next page, q = quit): "
echo 1>&2
head rfc1321.txt -n 13 | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < rfc1321.txt: "
echo 1>&2
./prog < rfc1321.txt | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: echo \"\" | ./prog: "
echo 1>&2
echo "" | ./prog
echo 1>&2

read -r -n 1 -p "Press any key to show prog.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK prog.c
echo 1>&2

echo "For the next two, observe the magical values."
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog < prog.c | cut -c-5: "
echo 1>&2
./prog < prog.c | cut -c-5

read -r -n 1 -p "Press any key to run: ./prog < Makefile | cut -c-4: "
echo 1>&2
./prog < Makefile | cut -c-4
echo 1>&2

read -r -n 1 -p "Press any key to run: wc -c large: "
echo 1>&2
wc -c large
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < large: "
echo 1>&2
./prog < large
