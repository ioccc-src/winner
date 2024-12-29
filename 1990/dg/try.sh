#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1990/dg
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


read -r -n 1 -p "Press any key to run: echo 'to C or not to C' | ./dg: "
echo 1>&2
echo 'to C or not to C' | ./dg
echo 1>&2

echo "$ echo 'The quick brown fox jumps over the lazy dog' | ./dg" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 'The quick brown fox jumps over the lazy dog' | ./dg
echo 1>&2

read -r -n 1 -p "Press any key to show dg.c (space = next page, q = quit): "
echo 1>&2
less -rEXF dg.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dg < dg.c (space = next page, q = quit): "
echo 1>&2
./dg < dg.c | less -rEXF
echo 1>&2
