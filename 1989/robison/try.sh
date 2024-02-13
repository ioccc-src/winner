#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1989/robison
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

read -r -n 1 -p "Press any key to run: echo 1x10x111 | ./robison: "
echo 1>&2
echo 1x10x111 | ./robison
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 1+1+10 | ./robison: "
echo 1>&2
echo 1+1+10 | ./robison
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 100 - 1 | ./robison: "
echo 1>&2
echo 100 - 1 | ./robison
echo 1>&2

read -r -n 1 -p "Press any key to run: echo -100 x 100 + 1 | ./robison: "
echo 1>&2
echo -100 x 100 + 1 | ./robison
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 101x111-100 | ./robison: "
echo 1>&2
echo 101x111-100 | ./robison
echo 1>&2
