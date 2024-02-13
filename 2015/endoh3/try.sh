#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/endoh3
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# clear screen so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: less -rEXFK prog.c (space = next page, q = quit): "
echo 1>&2
less -EXF prog.c
echo 1>&2

read -r -n 1 -p "Press any key to: make future: "
echo 1>&2
make future || exit 1
echo 1>&2
echo 1>&2

echo "Will go back to the future and run 1984/mullender through prog. To quit" 1>&2
echo "the program hit ctrl-c/intr. We suggest you try hitting enter or another" 1>&2
echo "key when the output reaches the end of the line." 1>&2
echo 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
./prog
