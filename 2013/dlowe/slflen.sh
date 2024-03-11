#!/usr/bin/env bash
#
# 2013/dlowe/slflen.sh - show sparkline length of all files in the current
# working directory
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

ln -sf dlowe sparkl
find . -mindepth 1 -maxdepth 1 -print | sed -e 's;^\./;;'
echo 1>&2
echo -n "sparkline length of above files: "
wc -c ./* | awk '{print $1}' | xargs ./sparkl
echo 1>&2
