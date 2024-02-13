#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2006/sykes2
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" sykes2 || exit 1

while :; do
    clear
    rm -f sykes2
    make sykes2 2>/dev/null 1>&2 || exit 1
    ./sykes2
    sleep 1
done
