#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2000/schneiderwent
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
[[ -z "$CC" ]] && CC="cc"

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

# get the number of seconds to sleep in between runs (def: 60)
[[ -z "$SLEEP" ]] && SLEEP=60
# verify it's a positive number:
echo "$SLEEP" | grep -qE '^[0-9]+'
if [[ "${PIPESTATUS[1]}" -ne 0 ]]; then
    echo "SLEEP value not a positive number, fix and run again."
    exit 1
fi
# get the number of iterations to run (default: 60)
[[ -z "$ITERATIONS" ]] && ITERATIONS=60
# verify it's a positive number:
echo "$ITERATIONS" | grep -qE '^[0-9]+'
if [[ "${PIPESTATUS[1]}" -ne 0 ]]; then
    echo "ITERATIONS value not a positive number, fix and run again."
    exit 1
fi

echo "If you did not override \$SLEEP and \$ITERATIONS this will take a long" 1>&2
echo "time to run to completion: approximately one hour. If you do not care to" 1>&2
echo "wait such a long time, which we presume is probably quite likely, you" 1>&2
echo "you might wish to run this entry like the following: " 1>&2
echo 1>&2
echo "    ./schneiderwent" 1>&2
echo "    ./schneiderwent schneiderwent.data" 1>&2
echo 1>&2
echo "at various times throughout the day, preferably at different" 1>&2
echo "minutes of the hours." 1>&2
echo 1>&2
echo "Alternatively, you can leave this running in a console tab for an hour" 1>&2
echo "and look back at it later, so that you can see all the entry does." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to start: "
echo 1>&2
i=0
while [[ "$i" -lt "$ITERATIONS" ]]; do
    ./schneiderwent
    ./schneiderwent schneiderwent.data
    sleep "$SLEEP"
    ((i++))
done
