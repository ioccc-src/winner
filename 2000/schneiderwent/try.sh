#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2000/schneiderwent
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

echo "This will take a long time to run to completion: " 1>&2
i=0
while [[ "$i" -lt 60 ]]; do
    ./schneiderwent
    ./schneiderwent schneiderwent.data
    sleep 60
    ((i++))
done



