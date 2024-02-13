#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2000/briddlebane
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

[[ -z "$INSULTS" ]] && INSULTS=10
echo "$INSULTS" | grep -qE '^[0-9]+'
if [[ "${PIPESTATUS[1]}" -ne 0 ]]; then
    echo "INSULTS value not a positive number, fix and run again."
    exit 1
fi

for ((i=0; i<"$INSULTS"; i++)); do
    ./briddlebane
    sleep 1
done
