#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/tompng

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# make sure the program has been built
#
make CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear


read -r -n 1 -p "Press any key to view sample.txt: "
echo 1>&2
echo 1>&2
cat sample.txt
echo 1>&2

echo "Encrypt sample input file"
echo 1>&2
echo "./prog < sample.txt > sample.enc.txt"
echo 1>&2
read -r -n 1 -p "Press any key to run: "
echo 1>&2
echo 1>&2
./prog < sample.txt > sample.enc.txt
echo 1>&2

echo "Decrypt the previously encrypted file"
echo 1>&2
echo "./prog < sample.enc.txt"
echo 1>&2
read -r -n 1 -p "Press any key to run: "
echo 1>&2
echo 1>&2
./prog < sample.enc.txt
echo 1>&2

read -r -n 1 -p "Press any key to view prog.c: "
echo 1>&2
echo 1>&2
cat prog.c
echo 1>&2

echo "Encrypt the program itself"
echo 1>&2
echo "./prog < prog.c > prog2.c"
echo 1>&2
read -r -n 1 -p "Press any key to run: "
echo 1>&2
echo 1>&2
./prog < prog.c > prog2.c
echo 1>&2

echo "Encrypt and decrypt sample input file with the encrypted program"
echo 1>&2
echo "cc prog2.c -o prog2 && ./prog2 < sample.txt | ./prog2"
echo 1>&2
read -r -n 1 -p "Press any key to run: "
echo 1>&2
echo 1>&2
cc prog2.c -o prog2
./prog2 < sample.txt | ./prog2
echo 1>&2

read -r -n 1 -p "Press any key to cleanup:"
echo 1>&2
echo 1>&2
echo rm prog2.c prog2 sample.enc.txt
rm prog2.c prog2 sample.enc.txt
echo 1>&2
