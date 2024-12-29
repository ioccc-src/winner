#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC entry 1998/df
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

while :; do
    read -r -n 1 -p "Press any key to run ./df or 'q' to quit: "
    echo 1>&2
    if [[ "$REPLY" = "q" || "$REPLY" = "Q" ]]; then
	exit 0
    fi
    ./df
done
