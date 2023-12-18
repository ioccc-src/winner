#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC winner 1988/spinellis alt code
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

echo "$ cc -Wno-error spinellis.alt.c -o spinellis.alt && ./spinellis.alt < input.txt"
cc -Wno-error spinellis.alt.c -o spinellis.alt && ./spinellis.alt < input.txt
echo "$ ./spinellis.alt" 1>&2
./spinellis.alt

echo 1>&2

echo "$ cat input2.txt" 1>&2
cat input2.txt
echo "$ cc -Wno-error spinellis.c -o spinellis.alt && ./spinellis" 1>&2
cc -Wno-error spinellis.alt.c -o spinellis.alt && ./spinellis.alt < input2.txt
echo "$ ./spinellis.alt" 1>&2
./spinellis.alt
