#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2005/klausler
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

echo "$ ./klausler peter klausler | head -n 10" 1>&2
./klausler peter klausler | head -n 10

echo "$ ./klausler abc def ghi jkl mno | head -n 10" 1>&2
./klausler abc def ghi jkl mno | head -n 10

echo "$ ./klausler foo bar baz | head -n 10" 1>&2
./klausler foo bar baz | head -n 10

echo "$ ./klausler zebra elephant bear fox | head -n 10" 1>&2
./klausler zebra elephant bear fox | head -n 10

echo "$ ./klausler the lion king | head -n 10" 1>&2
./klausler the lion king | head -n 10

echo "$ ./klausler fire breathing dragon | head -n 10" 1>&2
./klausler fire breathing dragon | head -n 10

echo "$ ./klausler lord of the rings | head -n 10" 1>&2
./klausler lord of the rings | head -n 10

echo "$ ./klausler fawlty towers | head -n 10" 1>&2
./klausler fawlty towers | head -n 10

echo "$ ./klausler carriown fowl | head -n 10" 1>&2
./klausler carriown fowl | head -n 10

echo "$ ./klausler werewolf vampire dragon | head -n 10" 1>&2
./klausler werewolf vampire dragon | head -n 10

echo "$ ./klausler werewolf vampire | head -n 10" 1>&2
./klausler werewolf vampire | head -n 10
