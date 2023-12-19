#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2000/tomx
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

echo "Running tomx:" 1>&2
echo "$ ./tomx" 1>&2
./tomx
echo 1>&2

echo "Using source code to compile tomx.c: " 1>&2
echo "$ rm -f tomx" 1>&2
rm -f tomx
echo "$ chmod +x tomx.c" 1>&2
chmod +x tomx.c
echo "$ ./tomx.c" 1>&2
./tomx.c
echo "Running tomx again:" 1>&2
echo "$ ./tomx" 1>&2
./tomx

echo 1>&2
echo "Using tomx.c as a Makefile:" 1>&2
echo "$ rm -f tomx" 1>&2
rm -f tomx
echo "$ make -f tomx.c" 1>&2
make -f tomx.c
echo "Running tomx again:" 1>&2
echo "$ ./tomx"
./tomx
