#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1990/baruch
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

read -r -n 1 -p "Press any key to run: echo 5 | ./baruch (space = next page, q = quit): "
echo 1>&2
echo 5 | ./baruch | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 8 | ./baruch (space = next page, q = quit): "
echo 1>&2
echo 8 | ./baruch | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 2 | ./baruch: "
echo 1>&2
echo 2 | ./baruch
echo "Why was there no output? What other conditions cause this?" 1>&2
echo 1>&2
