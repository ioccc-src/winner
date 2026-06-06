#!/usr/bin/env bash
#
# digits.sh - display the digits 0 thru 9 using the prog.c source
#
# NOTE: This needs a window at least 42 columns wide by at least 34 lines tall.

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
make CC="$CC" all >/dev/null || exit 1

# --- SIZE CHECK ---
# We check this first to fail fast before changing terminal modes
REQUIRED_W=42
REQUIRED_H=34
CUR_W=$(tput cols)
CUR_H=$(tput lines)

if [[ $CUR_W -lt $REQUIRED_W || $CUR_H -lt $REQUIRED_H ]]; then
    echo "Error: Terminal is too small."
    echo "Current : ${CUR_W}x${CUR_H}"
    echo "Required: ${REQUIRED_W}x${REQUIRED_H}"
    echo
    echo "Hint: make the font smaller if you can't make the window big enough"
    exit 1
fi

clear
for i in $(seq 0 9); do
    echo '[H'; 
    ./prog "$i" < prog.c
    sleep 0.75
done | paste -d '' -

# All Done!!! -- Jessica Noll, Age 2
#
exit 0
