#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 1994/schnitzi alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" alt >/dev/null || exit 1


read -r -n 1 -p "Press any key to run: ./schnitzi.alt < README.md (space = next page, q = quit): "
echo 1>&2
./schnitzi.alt < README.md | less -rEXF
echo 1>&2

echo "$ ./schnitzi.alt2 < schnitzi.alt2.c | diff - schnitzi.c" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./schnitzi.alt2 < schnitzi.alt2.c | diff - schnitzi.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./schnitzi.alt2 < README.md (space = next page, q = quit): "
echo 1>&2
./schnitzi.alt2 < README.md
echo 1>&2
