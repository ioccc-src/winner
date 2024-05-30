#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 1989/ovdluhe.alt alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# user may also reconfigure P
if [[ -n "$P" ]]; then
    make clobber CC="$CC" P="$P" alt >/dev/null || exit 1
else
    make clobber CC="$CC" alt >/dev/null || exit 1
fi

# clear screen after compilation so that only the entry is shown

i=0
for ((i=0; i<4; ++i)); do
    read -r -n 1 -p "Press any key to run: ./ovdluhe.alt < ovdluhe.alt.c: "
    echo 1>&2
    ./ovdluhe.alt < ovdluhe.alt.c
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./ovdluhe.alt < README.md: "
    echo 1>&2
    ./ovdluhe.alt < README.md
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./ovdluhe.alt < Makefile: "
    echo 1>&2
    ./ovdluhe.alt < Makefile
    echo 1>&2
done
