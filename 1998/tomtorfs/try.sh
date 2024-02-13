#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1998/tomtorfs
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

read -r -n 1 -p "Press any key to run: echo \"abscond conferrable\" > file.A: "
echo 1>&2
echo "abscond conferrable" > file.A
echo 1>&2

read -r -n 1 -p "Press any key to run: ./tomtorfs file.A 32 04C11DB7 1 FFFFFFFF FFFFFFFF: "
echo 1>&2
./tomtorfs file.A 32 04C11DB7 1 FFFFFFFF FFFFFFFF
echo 1>&2

read -r -n 1 -p "Press any key to run: echo \"adorn condolence\" > file.B: "
echo 1>&2
echo "adorn condolence" > file.B

read -r -n 1 -p "Press any key to run: ./tomtorfs file.B 32 04C11DB7 1 FFFFFFFF FFFFFFFF: "
echo 1>&2
./tomtorfs file.B 32 04C11DB7 1 FFFFFFFF FFFFFFFF
echo 1>&2

read -r -n 1 -p "Press any key to run: echo \"adorn condolence too\" > file.C: "
echo 1>&2
echo "adorn condolence too" > file.C
echo 1>&2
read -r -n 1 -p "Press any key to run: ./tomtorfs file.C 32 04C11DB7 1 FFFFFFFF FFFFFFFF: "
echo 1>&2
./tomtorfs file.C 32 04C11DB7 1 FFFFFFFF FFFFFFFF
echo 1>&2

rm -f file.A file.B file.C
