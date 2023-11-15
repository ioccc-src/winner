#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2000/anderson
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

read -r -n 1 -p "Press any key to run: echo Obfuscate | ./anderson: "
echo Obfuscate | ./anderson

read -r -n 1 -p "Press any key to run: echo 'Hello, world!' | ./anderson: "
echo 'Hello, world!' | ./anderson

read -r -n 1 -p "Press any key to run: ./anderson < anderson.c: "
./anderson < anderson.c

read -r -n 1 -p "Press any key to run: ./anderson < README.md: "
./anderson < README.md

read -r -n 1 -p "Press any key to run: cat README.md anderson.c | ./anderson: "
cat README.md anderson.c | ./anderson
