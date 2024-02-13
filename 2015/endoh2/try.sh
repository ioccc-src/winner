#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/endoh2
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

read -r -n 1 -p "Press any key to run: cat prog.c: "
echo 1>&2
cat prog.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: less -rEXFK prog.c: "
echo 1>&2
less -EXF prog.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog | diff -s - prog.c: "
echo 1>&2
./prog | diff -s - prog.c
echo 1>&2

read -r -n 1 -p "Press any key to run: wc -c prog.c: "
echo 1>&2
wc -c prog.c
echo 1>&2
echo "Can you figure out the inconsistencies?" 1>&2
echo "If you can't or you're still confused try" 1>&2
echo "opening prog.c in an editor like vim." 1>&2
