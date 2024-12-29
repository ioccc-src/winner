#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2020/kurdyukov2
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

# first input to try
read -r -n 1 -p "Press any key to run: echo first input to try | ./prog: "
echo 1>&2
echo first input to try | ./prog
echo 1>&2

# try reading this output
read -r -n 1 -p "Press any key to run: echo International Obfuscated C Code Contest | ./prog: "
echo 1>&2
echo International Obfuscated C Code Contest | ./prog
echo 1>&2

# try reading this other output
read -r -n 1 -p "Press any key to show input.txt: "
echo 1>&2
cat input.txt
echo 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < input.txt: "
echo 1>&2
./prog < input.txt
