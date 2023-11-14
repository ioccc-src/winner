#!/usr/bin/env bash
# 
# try.sh - show IOCCC winner 1995/dodsond1
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

echo "$ cat try.this.txt"
cat try.this.txt

echo "$ ./dodsond1 < try.this.txt"
./dodsond1 < try.this.txt
