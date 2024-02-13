#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2000/anderson
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
echo 1>&2
echo Obfuscate | ./anderson
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 'Hello, world!' | ./anderson: "
echo 1>&2
echo 'Hello, world!' | ./anderson
echo 1>&2

read -r -n 1 -p "Press any key to run: ./anderson < anderson.c (space = next page, q = quit): "
echo 1>&2
./anderson < anderson.c | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./anderson < README.md (space = next page, q = quit): "
echo 1>&2
./anderson < README.md | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: cat README.md anderson.c | ./anderson (space = next page, q = quit): "
echo 1>&2
cat README.md anderson.c | ./anderson | less -rEXFK
echo 1>&2
