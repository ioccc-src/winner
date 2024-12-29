#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 1992/albert alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear


read -r -n 1 -p "Press any key to run: ./albert.alt 1234567890123456789: "
echo 1>&2
./albert.alt 1234567890123456789
echo 1>&2

read -r -n 1 -p "Press any key to run: ./albert.alt 12345678987654321: "
echo 1>&2
./albert.alt 12345678987654321
echo 1>&2

read -r -n 1 -p "Press any key to run: ./albert.alt 42: "
echo 1>&2
./albert.alt 42
echo 1>&2

read -r -n 1 -p "Press any key to run: ./albert.alt 4242424242: "
echo 1>&2
./albert.alt 4242424242
echo 1>&2

read -r -n 1 -p "Press any key to run: ./albert.alt 10000000001: "
echo 1>&2
./albert.alt 10000000001
echo 1>&2
