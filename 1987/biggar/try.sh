#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1987/biggar
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

read -r -n 1 -p "Press any key to run: ./biggar < biggar.c: "
echo 1>&2
./biggar < biggar.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./biggar < biggar.c | od -c: "
echo 1>&2
./biggar < biggar.c | od -c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./biggar < Makefile (space = next page, q = quit): "
./biggar < Makefile | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./biggar < Makefile | od -c (space = next page, q = quit): "
echo 1>&2
./biggar < Makefile | od -c | less -rEXF
