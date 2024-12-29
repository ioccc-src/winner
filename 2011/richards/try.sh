#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2011/richards
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



read -r -n 1 -p "Press any key to run: echo '10 9 8 7 6 5 4 3 2 1*p*p*p*p*p*p*p*p*p' | ./richards: "
echo 1>&2
echo '10 9 8 7 6 5 4 3 2 1*p*p*p*p*p*p*p*p*p' | ./richards
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '64 256 128 p/p*p' | ./richards: "
echo 1>&2
echo '64 256 128 p/p*p' | ./richards
echo 1>&2
