#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2001/westley
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

read -r -n 1 -p "Press any key to run: ./westley < westley.c (space = next page, q = quit): "
echo 1>&2
./westley < westley.c 2>/dev/null | tee westley2.c | less -rEXFK

echo "Compiling westley2.c..." 1>&2
make CC="$CC" westley2 2>/dev/null 1>&2
echo 1>&2
echo "$ echo 'Bozos, please deflate shoes before entering the bus!'| ./westley2"
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 'Bozos, please deflate shoes before entering the bus!'| ./westley2 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: make CC=\"$CC\" westley.sort 2>/dev/null: "
echo 1>&2
make CC="$CC" westley.sort 2>/dev/null 1>&2
echo 1>&2

echo "$ ./westley.sort < westley.c 2>/dev/null | diff -s - westley.c"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
# There isn't a read and write problem.
#
# SC2094 (info): Make sure not to read and write the same file in the same pipeline.
# https://www.shellcheck.net/wiki/SC2094
# shellcheck disable=SC2094
./westley.sort < westley.c 2>/dev/null | diff -s - westley.c | less -rEXFK
echo 1>&2

echo "$ ./westley.sort < westley.c 2>/dev/null | diff - westley2.c"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./westley.sort < westley.c 2>/dev/null | diff -s - westley2.c | less -rEXFK
echo 1>&2

echo "$ ./westley.sort < westley.c 2>/dev/null | diff - westley.sort.c"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./westley.sort < westley.c 2>/dev/null | diff - westley.sort.c | less -rEXFK
echo 1>&2

echo "$ ./westley.sort < westley.c 2>/dev/null | diff - westley.punch.c"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./westley.sort < westley.c 2>/dev/null | diff - westley.punch.c | less -rEXFK

echo 1>&2
read -r -n 1 -p "Press any key to run: printf \"1\n\4\n5\" | ./westley: "
echo 1>&2
printf "1\n4\n5" | ./westley 2>/dev/null
echo 1>&2

echo 1>&2
read -r -n 1 -p "Press any key to run: printf \"1\n4\n5\" | ./westley: "
echo 1>&2
printf "1\n4\n5" | ./westley 2>/dev/null
echo 1>&2

echo 1>&2
read -r -n 1 -p "Press any key to run: echo 'Hello, world!' | ./westley.punch: "
echo 1>&2
echo 'Hello, world!' | ./westley.punch 2>/dev/null
