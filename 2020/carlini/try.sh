#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2020/carlini
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

read -r -n 1 -p "Press any key to run: echo 1 2 3 4 5 6 7 | ./prog: "
echo 1>&2
echo 1 2 3 4 5 6 7 | ./prog
echo 1>&2

echo "... now go and play for real, with a friend, real or imagined." 1>&2
