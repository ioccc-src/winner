#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2011/akari
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# in this case we won't fail if we can't compile the code because we can still
# run the supplementary program.
make CC="$CC" all >/dev/null

# clean out old binaries except the entry itself
rm -f akari2 akari3 akari4

# clear screen after compilation so that only the entry is shown
clear

./akari < example.ppm > odd_output.ppm
./akari - - even < example.ppm > even_output.ppm
./akari example.ppm odd_output.ppm

make akari2 >/dev/null|| exit 1
read -r -n 1 -p "Press any key to cat akari2.c: "
cat akari2.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./akari2 < akari2.c: "
./akari2 < akari2.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./akari2 rot13 < akari2.c: "
./akari2 rot13 < akari2.c

make akari3 >/dev/null|| exit 1

read -r -n 1 -p "Press any key to cat akari3.c: "
cat akari3.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./akari3: "
./akari3
echo 1>&2

make akari4 >/dev/null|| exit 1

read -r -n 1 -p "Press any key to cat akari4.c: "
cat akari4.c

read -r -n 1 -p "Press any key to run: ./akari4: "
./akari4
echo 1>&2

read -r -n 1 -p "Press any key to run: ./akari2 rot13 < akari.c | ./akari > rot13.c; cat rot13.c: "
./akari2 rot13 < akari.c | ./akari > rot13.c; cat rot13.c


read -r -n 1 -p "Press any key to run: ./akari2 < akari.c > expanded_output.txt: "
./akari2 < akari.c > expanded_output.txt
read -r -n 1 -p "Press any key to run: ./akari2 rot13 < akari.c > expanded_and_rot13_output.txt: "
./akari2 rot13 < akari.c > expanded_and_rot13_output.txt
read -r -n 1 -p "Press any key to cat expanded_and_rot13_output.txt: "
cat expanded_and_rot13_output.txt
