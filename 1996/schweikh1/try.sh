#!/usr/bin/env bash
#
# try.sh - show IOCCC entry 1996/schweikh1
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


read -r -n 1 -p "Press any key to show date of Easter this year (./schweikh1 |grep \$(date +%Y)): "
echo 1>&2
./schweikh1 |grep "$(date +%Y)"
echo 1>&2

read -r -n 1 -p "Press any key to show Easter dates from 1582 to 2199 (space = next page, q = quit): "
echo 1>&2
./schweikh1 | less -rEXF
echo 1>&2
