#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2019/burton
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

read -r -n 1 -p "Press any key to show prog.c: "
echo 1>&2
cat prog.c
echo 1>&2

for i in prog.c Makefile README.md; do
    read -r -n 1 -p "Press any key to run: ./prog < $i && wc < $i: "
    echo 1>&2
    printf "prog: %s\n%4s: %s\n\n" "$(./prog < "$i"|tr -s ' ')" "wc" "$(wc "$i" | tr -s ' ')"
done
echo 1>&2

read -r -n 1 -p "Press any key to run: make test: "
echo 1>&2
make test
echo 1>&2
