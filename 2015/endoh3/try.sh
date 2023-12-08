#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2015/endoh3
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# clear screen so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: less -EXF prog.c (space = next page, q = quit): "
echo 1>&2
less -EXF prog.c
echo 1>&2

echo "$ make future" 1>&2
make future || exit 1

echo 1>&2
echo 1>&2

echo "Will go back to the future and run 1984/mullender through prog. To quit" 1>&2
echo "the program hit ctrl-c/intr." 1>&2
echo 1>&2
echo "You might want to try hitting enter or another key when the output reaches" 1>&2
echo "the end of the line." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ ./prog" 1>&2
./prog
