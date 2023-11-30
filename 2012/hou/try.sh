#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2012/hou
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

read -r -n 1 -p "Press any key to run: less hou.c (space = next page, q = quit): "
echo 1>&2
less -X hou.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hou ansi.txt hou.c | less -r (space = next page, q = quit): "
echo 1>&2
echo "$ ./hou ansi.txt hou.c | less -r"
./hou ansi.txt hou.c | less -r
echo 1>&2

read -r -n 1 -p "Press any key to check size of hou.c: "
echo 1>&2
echo "$ ./hou chk.txt hou.c | wc" 1>&2
./hou chk.txt hou.c | wc
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hou markdown.txt hint.md > remarks.htm: "
echo 1>&2
./hou markdown.txt hint.md > remarks.htm
echo 1>&2
echo "Now open remarks.htm in your web browser of choice."
