#!/usr/bin/env bash
# 
# try.sh - show IOCCC entry 1995/dodsond1
#

# get CC

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to show try.this.txt: "
echo 1>&2
cat try.this.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dodsond1 < try.this.txt: "
echo 1>&2
./dodsond1 < try.this.txt
echo 1>&2
