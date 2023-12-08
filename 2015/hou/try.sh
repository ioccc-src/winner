#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2015/hou
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


echo "$ echo IOCCC | ./prog" 1>&2
echo IOCCC | ./prog
echo 1>&2

echo "$ ./prog < rfc1321.txt" 1>&2
./prog < rfc1321.txt
echo 1>&2

echo "$ echo \"\" | ./prog" 1>&2
echo "" | ./prog
echo 1>&2

echo "For the next two, observe the magical values: "
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ ./prog < prog.c | cut -c-5" 1>&2
./prog < prog.c | cut -c-5

echo "$ ./prog < Makefile | cut -c-4" 1>&2
./prog < Makefile | cut -c-4
echo 1>&2

echo "$ wc -c large" 1>&2
wc -c large

echo "$ ./prog < large" 1>&2
./prog < large
