#!/usr/bin/env bash
# 
# try.sh - script to show 2000/tomx

if [[ ! -f "tomx" || ! -e "tomx" ]]; then
    echo "Compiling tomx.c:" 1>&2
    make all || exit 1
fi

echo "Running tomx:" 1>&2
echo "$ ./tomx" 1>&2
./tomx
echo 1>&2

echo "Using source code to compile tomx.c: " 1>&2
echo "$ rm -f tomx" 1>&2
rm -f tomx
echo "$ chmod +x tomx.c" 1>&2
chmod +x tomx.c
echo "$ ./tomx.c" 1>&2
./tomx.c
echo "Running tomx again:" 1>&2
echo "$ ./tomx" 1>&2
./tomx

echo 1>&2
echo "Using tomx.c as a Makefile:" 1>&2
echo "$ rm -f tomx" 1>&2
rm -f tomx
echo "$ make -f tomx.c" 1>&2
make -f tomx.c
echo "Running tomx again:" 1>&2
echo "$ ./tomx"
./tomx
