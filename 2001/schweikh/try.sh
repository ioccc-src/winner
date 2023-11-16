#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2001/schweikh
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

echo "$ ./schweikh foo 'f??'; echo \$?" 1>&2
./schweikh foo 'f??'; echo $?

echo "$ ./schweikh 'best short program' '??st*o**p?*'; echo \$?" 1>&2
./schweikh 'best short program' '??st*o**p?*'; echo $?

echo "$ ./schweikh bar 'f??'; echo \$?" 1>&2
./schweikh bar 'f??'; echo $?
