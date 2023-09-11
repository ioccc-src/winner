#!/usr/bin/env bash

echo "./westley < westley.c 2>/dev/null > westley2.c"
./westley < westley.c 2>/dev/null > westley2.c
make westley2 2>/dev/null 1>&2
echo
echo "echo 'Bozos, please deflate shoes before entering the bus!'| ./westley2 2>/dev/null"
echo 'Bozos, please deflate shoes before entering the bus!'| ./westley2 2>/dev/null
echo

make westley.sort 2>/dev/null 1>&2
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
