#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2004/newbern
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

read -r -n 1 -p "Press any key to run: ./newbern newbern.dat \"IOCCC 2004\" (space = next page, q = quit): "
echo 1>&2
./newbern newbern.dat "IOCCC 2004" | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: echo SOS | ./newbern: "
echo 1>&2
echo SOS | ./newbern
echo 1>&2

read -r -n 1 -p "Press any key to run: ./newbern newbern.dat IOCCC x (space = next page, q = quit): "
echo 1>&2
./newbern newbern.dat IOCCC x | less -rEXFK
echo 1>&2
