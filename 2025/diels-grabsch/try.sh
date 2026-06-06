#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/diels-grabsch

# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
rm -f spaces spaces.Z
read -r -n 1 -p "Press any key to run: echo -n <100 spaces> | tee spaces | ./prog <14 arguments> > spaces.Z; wc -c spaces spaces.Z "
echo 1>&2
echo 1>&2
echo -n "                                                                                                    " | \
tee spaces | ./prog 1 2 3 4 5 6 7 8 9 10 11 12 13 14 > spaces.Z; wc -c spaces spaces.Z
echo 1>&2
echo 'Due to a ncompress prior to the 5.0 release, the following may fail:'
echo 1>&2
read -r -n 1 -p "Press any key to run: zcat spaces.Z | (cmp - spaces && echo Match) : "
echo 1>&2
echo 1>&2
zcat spaces.Z | (cmp - spaces && echo Match)
echo 1>&2
