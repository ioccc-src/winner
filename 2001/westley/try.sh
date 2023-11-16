#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2001/westley
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

echo "./westley < westley.c 2>/dev/null > westley2.c" 1>&2
./westley < westley.c 2>/dev/null > westley2.c
echo "Compiling westley2.c..." 1>&2
make CC="$CC" westley2 2>/dev/null 1>&2
echo
echo "$ echo 'Bozos, please deflate shoes before entering the bus!'| ./westley2 2>/dev/null"
echo 'Bozos, please deflate shoes before entering the bus!'| ./westley2 2>/dev/null
echo

make CC="$CC" westley.sort 2>/dev/null 1>&2
echo
echo "./westley.sort < westley.c 2>/dev/null | diff - westley.c"
# SC2094 (info): Make sure not to read and write the same file in the same pipeline.
# shellcheck disable=SC2094
./westley.sort < westley.c 2>/dev/null | diff - westley.c
echo "./westley.sort < westley.c 2>/dev/null | diff - westley2.c"
./westley.sort < westley.c 2>/dev/null | diff - westley2.c
echo "./westley.sort < westley.c 2>/dev/null | diff - westley.sort.c"
./westley.sort < westley.c 2>/dev/null | diff - westley.sort.c
echo "./westley.sort < westley.c 2>/dev/null | diff - westley.punch.c"
./westley.sort < westley.c 2>/dev/null | diff - westley.punch.c

echo
# SC2028 (info): echo may not expand escape sequences. Use printf.
# shellcheck disable=SC2028
echo "printf \"1\n\4\n5\" | ./westley 2>/dev/null"
printf "1\n4\n5" | ./westley 2>/dev/null

echo
# SC2028 (info): echo may not expand escape sequences. Use printf.
# shellcheck disable=SC2028
echo "printf \"1\n\4\n5\" | ./westley 2>/dev/null"
printf "1\n4\n5" | ./westley 2>/dev/null

echo
echo "echo 'Hello, world!' | ./westley.punch 2>/dev/null"
echo 'Hello, world!' | ./westley.punch 2>/dev/null
