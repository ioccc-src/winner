#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/hou
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

read -r -n 1 -p "Press any key to run show hou.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK hou.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hou ansi.txt hou.c (space = next page, q = quit): "
echo 1>&2
# Note: unlike the other try.sh/try.alt.sh scripts we don't use options that
# don't reset the terminal and that quit less(1) when it reaches EOF. This is
# because if we do the effect will vanish the moment they reach the EOF. Also if
# we don't have less(1) reset things the colour of the rest of the script will
# be wrong. Thus in this script the user must hit 'q' to finish this command.
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
