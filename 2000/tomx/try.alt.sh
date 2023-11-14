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
echo "$ chmod +x tomx.alt.c" 1>&2
chmod +x tomx.alt.c
echo "$ rm -f mkentry" 1>&2
rm -f mkentry
echo "$ ./tomx.alt.c" 1>&2
./tomx.alt.c
echo 1>&2

echo "Using tomx.alt.c as a Makefile to compile mkentry.c:" 1>&2
echo "$ rm -f mkentry"
rm mkentry
echo "$ make -f tomx.alt.c" 1>&2
make -f tomx.alt.c
echo 1>&2

echo "Running mkentry via tomx.alt:" 1>&2
echo "$ ./tomx.alt" 1>&2
./tomx.alt
