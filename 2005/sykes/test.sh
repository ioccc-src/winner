#!/usr/bin/env bash
#
# 2005/sykes/test.sh - run the test suite

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "NOTE: you will have to hit ctrl-c to exit after the test." 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2

./sykes 6502test 6 2>&1
