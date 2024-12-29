#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2000/tomx
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

read -r -n 1 -p "Press any key to run: ./tomx (compiled from tomx.c): "
echo 1>&2
./tomx
echo 1>&2

read -r -n 1 -p "Press any key to run: rm -v -f tomx: "
echo 1>&2
rm -v -f tomx
echo 1>&2

read -r -n 1 -p "Press any key to run: chmod +x tomx.c: "
echo 1>&2
chmod +x tomx.c
echo 1>&2

echo "Using source code to compile tomx.c: " 1>&2
read -r -n 1 -p "Press any key to run: ./tomx.c: "
echo 1>&2
./tomx.c
echo 1>&2
read -r -n 1 -p "Press any key to run: ./tomx (compiled by tomx.c as an executable itself): "
echo 1>&2
./tomx

echo 1>&2
read -r -n 1 -p "Press any key to run: rm -v -f tomx: "
echo 1>&2
rm -v -f tomx
echo 1>&2

echo "Using tomx.c as a Makefile:" 1>&2
read -r -n 1 -p "Press any key to run: make -f tomx.c: "
echo 1>&2
make -f tomx.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./tomx (built from tomx.c as a Makefile): "
echo 1>&2
./tomx
echo 1>&2
