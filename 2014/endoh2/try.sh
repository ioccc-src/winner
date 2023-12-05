#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2014/endoh2
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

read -r -n 1 -p "Press any key to run: echo Hello | ./prog: "
echo 1>&2
echo Hello | ./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: echo IOCCC | ./prog: "
echo 1>&2
echo IOCCC | ./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: echo Hello | ./prog > hello.c: "
echo 1>&2
echo Hello | ./prog > hello.c
echo 1>&2

read -r -n 1 -p "Press any key to compile hello.c: "
echo 1>&2
make hello >/dev/null
echo 1>&2
read -r -n 1 -p "Press any key to run: ./hello: "
./hello
echo 1>&2

read -r -n 1 -p "Press any key to run: echo IOCCC | ./prog > ioccc.c: "
echo 1>&2
echo IOCCC | ./prog > ioccc.c
echo 1>&2

read -r -n 1 -p "Press any key to compile ioccc.c: "
echo 1>&2
make ioccc >/dev/null
echo 1>&2
read -r -n 1 -p "Press any key to run: ./ioccc: "
echo 1>&2
./ioccc
