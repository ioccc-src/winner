#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 1998/tomtorfs
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

rm -f file.A file.B file.C

echo "$ echo abscond conferrable > file.A" 1>&2
echo "abscond conferrable" > file.A
echo "$ ./tomtorfs file.A 32 04C11DB7 1 FFFFFFFF FFFFFFFF" 1>&2
./tomtorfs file.A 32 04C11DB7 1 FFFFFFFF FFFFFFFF

echo "$ echo adorn condolence > file.B" 1>&2
echo "adorn condolence" > file.B
echo "$ ./tomtorfs file.B 32 04C11DB7 1 FFFFFFFF FFFFFFFF" 1>&2
./tomtorfs file.B 32 04C11DB7 1 FFFFFFFF FFFFFFFF

echo "$ echo adorn condolence too > file.C" 1>&2
echo "adorn condolence too" > file.C
echo "$ ./tomtorfs file.C 32 04C11DB7 1 FFFFFFFF FFFFFFFF" 1>&2
./tomtorfs file.C 32 04C11DB7 1 FFFFFFFF FFFFFFFF

rm -f file.A file.B file.C
