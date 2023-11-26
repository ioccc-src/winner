#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2011/konno
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


echo "$ ./konno qwerty" 1>&2
./konno qwerty
echo 1>&2

echo "$ ./konno ioccc" 1>&2
./konno ioccc
echo 1>&2

echo "$ ./konno \"the quick brown fox jumps over the lazy dog\"" 1>&2
./konno "the quick brown fox jumps over the lazy dog"
echo 1>&2

echo "$ ./konno \"\"" 1>&2
./konno ""

