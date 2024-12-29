#!/usr/bin/env bash
# 
# try.alt.sh - demonstrate IOCCC entry 1996/westley alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "WARNING: this is likely to segfault after showing the output." 1>&2
echo "It might also show one or more environmental variables. Use" 1>&2
echo "try.sh if you want to see the fixed version." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to show alt grandfather clock: "
echo 1>&2
WESTLEY=./westley.alt ./clock1.sh
echo 1>&2

read -r -n 1 -p "Press any key to show alt mantle clock that runs backwards: "
echo 1>&2
WESTLEY=./westley.alt ./clock2.sh
echo 1>&2

read -r -n 1 -p "Press any key to show alt linear style clock: "
echo 1>&2
WESTLEY=./westley.alt ./clock3.sh
echo 1>&2
