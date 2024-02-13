#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1995/schnitzi
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


read -r -n 1 -p "Press any key to run: ./schnitzi 24 (space = next page, q = quit): "
echo 1>&2
./schnitzi 24 | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./schnitzi 18 (space = next page, q = quit): "
echo 1>&2
./schnitzi 18 | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./schnitzi 30 (space = next page, q = quit): "
echo 1>&2
./schnitzi 30 | less -rEXF
echo 1>&2




