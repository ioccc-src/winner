#!/usr/bin/env bash
#
# script to demonstrate 1998/tomtorfs
#

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
