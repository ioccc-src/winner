#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1995/vanschnitz
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

read -r -n 1 -p "Press any key to run: ./vanschnitz (space = next page, q = quit): "
echo 1>&2
./vanschnitz | less -rEXF
echo 1>&2

for i in $(seq 1 6); do
    read -r -n 1 -p "Press any key to set level at $i (make clobber all LEVEL=$i): "
    echo 1>&2
    make clobber all LEVEL="$i"
    read -r -n 1 -p "Press any key to run: ./vanschnitz (space = next page, q = quit): "
    echo 1>&2
    ./vanschnitz | less -rEXF
done
