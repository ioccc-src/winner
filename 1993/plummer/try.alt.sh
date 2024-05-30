#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 1993/plummer alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# let user change the sleep duration if they wish
#
[[ -z "$SLEEP" ]] && SLEEP=1000

# let user change the number if they wish to
#
if [[ "$#" -lt 1 || -z "$1" ]]; then
    NUMBER="01234567890876543210"
else
    NUMBER="$1"
fi

# let user change the arg if they wish to
#
if [[ "$#" -lt 2 || -z "$2" ]]; then
    ARG="xxx"
else
    ARG="$2"
fi

make clobber CC="$CC" SLEEP="$SLEEP" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "$ ./plummer.alt $NUMBER $ARG" 1>&2
read -r -n 1 -p "Press any key to continue (send intr/ctrl-c to terminate): "
echo 1>&2
./plummer.alt "$NUMBER" "$ARG"
