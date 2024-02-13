#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2020/burton
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

read -r -n 1 -p "Press any key to run: make test: "
echo 1>&2
make test
echo 1>&2

read -r -n 1 -p "Press any key to run: ./check_be.sh (Big Endian) (space = next page, q = quit): "
echo 1>&2
./check_be.sh | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./check_le.sh (Little Endian) (space = next page, q = quit): "
echo 1>&2
./check_le.sh | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog 128: "
echo 1>&2
./prog 128
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog_le 128: "
echo 1>&2
./prog_le 128
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog_be 128: "
echo 1>&2
./prog_be 128
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog 170: "
echo 1>&2
./prog 170
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog 85: "
echo 1>&2
./prog 85
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog 128 128: "
echo 1>&2
./prog 128 128
echo 1>&2
echo "Why did that print strange output?"
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog 128 128 128: "
echo 1>&2
./prog 128 128 128
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog 128 128 128 128: "
echo 1>&2
./prog 128 128 128 128
echo 1>&2
echo "Why did that print strange output?"
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog 1; ./prog_be 1: "
echo 1>&2
./prog 1; ./prog_be 1
echo 1>&2
