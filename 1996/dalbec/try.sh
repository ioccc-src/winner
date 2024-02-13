#!/usr/bin/env bash
#
# try.sh - show IOCCC entry 1996/dalbec
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

read -r -n 1 -p "Press any key to run: ./dalbec 5 | head -n 29 (space = next page, q = quit): "
echo 1>&2
./dalbec 5 | head -n 29 | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dalbec 3 | head -n 29 (space = next page, q = quit): "
echo 1>&2
./dalbec 3 | head -n 29 | less -rEXF
echo 1>&2
