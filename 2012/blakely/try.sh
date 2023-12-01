#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2012/blakely
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

echo "$ ./blakely "xx*yy*+" 64 > paraboloid.gif" 1>&2
./blakely "xx*yy*+" 64 > paraboloid.gif

echo "$ ./blakely 9 32 > empty.gif 1>&2"
./blakely 9 32 > empty.gif

echo "$ ./blakely xy* 32 > saddle.gif" 1>&2
./blakely xy* 32 > saddle.gif

echo "$ ./blakely xx*yy*1++d5*ct/ 64 > ripple.gif" 1>&2
./blakely xx*yy*1++d5*ct/ 64 > ripple.gif

echo "This might take a bit of time:" 1>&2
echo "$ time ./blakely 0 250 > flat.gif" 1>&2
time ./blakely 0 250 > flat.gif

echo "Now open paraboloid.gif, empty.gif, saddle.gif, ripple.gif and flat.gif in a" 1>&2
echo "viewer that shows animated GIFs." 1>&2
