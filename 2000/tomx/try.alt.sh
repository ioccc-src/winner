#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC winner 2000/tomx alt code
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

echo "Using tomx.alt.c to compile mkentry.c directly:" 1>&2
read -r -n 1 -p "Press any key to run: chmod +x tomx.alt.c: "
echo 1>&2
chmod +x tomx.alt.c
echo 1>&2

read -r -n 1 -p "Press any key to run: rm -vf mkentry: "
echo 1>&2
rm -vf mkentry
echo 1>&2

read -r -n 1 -p "Press any key to run: ./tomx.alt.c: "
echo 1>&2
./tomx.alt.c
echo 1>&2

echo "Using tomx.alt.c as a Makefile to compile mkentry.c:" 1>&2
read -r -n 1 -p "Press any key to run: rm -vf mkentry: "
echo 1>&2
rm -vf mkentry
echo 1>&2

read -r -n 1 -p "Press any key to run: make -f tomx.alt.c: "
echo 1>&2
make -f tomx.alt.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./tomx.alt: "
echo 1>&2
./tomx.alt
echo 1>&2
