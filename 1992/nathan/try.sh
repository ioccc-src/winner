#!/usr/bin/env bash
#
# 1992/nathan/try.sh - show IOCCC winner 1992/nathan

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi
make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "$ ./nathan obfuscate < nathan.c > foobarf.c" 1>&2
./nathan obfuscate < nathan.c > foobarf.c

echo "$ ./nathan - obfuscate < foobarf.c > barfoof.c" 1>&2
./nathan - obfuscate < foobarf.c > barfoof.c

echo "$ diff nathan.c barfoof.c" 1>&2
diff -s nathan.c barfoof.c

echo "$ echo 'IOCCC 1992 winner nathan' | ./nathan" 1>&2
echo 'IOCCC 1992 winner nathan' | ./nathan
