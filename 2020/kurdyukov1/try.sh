#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2020/kurdyukov1
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

# try and find an md5sum tool
MD5SUM="$(type -P md5sum)"
if [[ -z "$MD5SUM" ]]; then
    MD5SUM="$(type -P openssl)"
fi

read -r -n 1 -p "Press any key to run: echo IOCCC | ./prog: "
echo 1>&2
echo IOCCC | ./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < prog.c: "
echo 1>&2
./prog < prog.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < prog: "
echo 1>&2
./prog < prog
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < prog.x86.asm: "
echo 1>&2
./prog < prog.x86.asm
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < prog.x86_64.asm: "
echo 1>&2
./prog < prog.x86_64.asm

rm -f md5.txt prog.md5.txt
if [[ -n "$MD5SUM" ]]; then
    if [[ "$(basename $MD5SUM)" == "openssl" ]]; then
	echo "$ $MD5SUM md5 prog.c | cut -f 2 -d' ' > md5.txt" 1>&2
	"$MD5SUM" md5 prog.c | cut -f 2 -d' ' > md5.txt
	echo "$ ./prog < prog.c > prog.md5.txt" 1>&2
	./prog < prog.c > prog.md5.txt
    else
	echo "$ $MD5SUM prog.c | cut -f1 -d' ' > md5.txt" 1>&2
	"$MD5SUM" prog.c | cut -f1 -d' ' > md5.txt
	echo "$ ./prog < prog.c > prog.md5.txt" 1>&2
	./prog < prog.c > prog.md5.txt
    fi
    read -r -n 1 -p "Press any key to compare the two files md5.txt and prog.md5.txt: "
    echo 1>&2
    diff -s md5.txt prog.md5.txt
fi
rm -f md5.txt prog.md5.txt
