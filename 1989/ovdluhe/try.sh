#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1989/ovdluhe
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

i=0
for ((i=0; i<4; ++i)); do
    read -r -n 1 -p "Press any key to run: ./ovdluhe < ovdluhe.c: "
    echo 1>&2
    ./ovdluhe < ovdluhe.c
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./ovdluhe < README.md: "
    echo 1>&2
    ./ovdluhe < README.md
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./ovdluhe < Makefile: "
    echo 1>&2
    ./ovdluhe < Makefile
    echo 1>&2
done
