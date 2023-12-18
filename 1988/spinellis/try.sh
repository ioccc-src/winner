#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 1988/spinellis
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# clear screen after compilation so that only the entry is shown
clear

echo "$ cat input.txt" 1>&2
cat input.txt

echo "$ cc spinellis.c -o spinellis < input.txt && ./spinellis" 1>&2
cc spinellis.c -o spinellis < input.txt && ./spinellis

echo 1>&2

echo "$ cat input2.txt" 1>&2
cat input2.txt
echo "$ cc spinellis.c -o spinellis < input2.txt && ./spinellis" 1>&2
cc spinellis.c -o spinellis < input2.txt && ./spinellis
