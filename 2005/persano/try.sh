#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2005/persano
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


read -r -n 1 -p "Press any key to run: ./persano 3 16 > knot3-16.gif: "
echo 1>&2
./persano 3 16 > knot3-16.gif
echo 1>&2
if [[ -f knot3-16.gif ]]; then
    echo "Now open the file knot3-16.gif in a GIF viewer capable of viewing animated" 1>&2
    echo "GIFs. See the README.md for details on a tool to manipulate it, if you wish." 1>&2
fi
echo 1>&2

read -r -n 1 -p "Press any key to run: ./persano 3 2 1 > foo.gif: "
echo 1>&2
./persano 3 2 1 > foo.gif
echo 1>&2
if [[ -f foo.gif ]]; then
    echo "Now open the file foo.gif in a GIF viewer capable of viewing animated" 1>&2
    echo "GIFs. See the README.md for details on a tool to manipulate it, if you wish." 1>&2
fi
echo 1>&2

read -r -n 1 -p "Press any key to run: ./persano 5 2 > seal.gif: "
echo 1>&2
./persano 5 2 > seal.gif
echo 1>&2

if [[ -f seal.gif ]]; then
    echo "Now open seal.gif (Solomon's Seal knot) in a GIF viewer capable of viewing" 1>&2
    echo "animated GIFs. See the README.md for details on a tool to manipulate it, if you wish." 1>&2
fi
echo 1>&2
