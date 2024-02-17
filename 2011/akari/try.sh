#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2011/akari
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


echo "Before you begin you might wish to open example.ppm in a graphics viewer." 1>&2
read -r -n 1 -p "Press any key to run: ./akari < example.ppm > odd_output.ppm: "
echo 1>&2
./akari < example.ppm > odd_output.ppm
echo 1>&2
echo "You might care to open odd_output.ppm in a graphics viewer." 1>&2

read -r -n 1 -p "Press any key to run: ./akari - - even < example.ppm > even_output.ppm: "
echo 1>&2
./akari - - even < example.ppm > even_output.ppm
echo 1>&2
echo "You might care to open even_output.ppm in a graphics viewer." 1>&2

read -r -n 1 -p "Press any key to run: ./akari example.ppm odd_output.ppm: "
echo 1>&2
./akari example.ppm odd_output.ppm
echo 1>&2

read -r -n 1 -p "Press any key to run: make akari2 >/dev/null || exit 1: "
echo 1>&2
make akari2 >/dev/null || exit 1
echo 1>&2

read -r -n 1 -p "Press any key to show akari2.c (space = next page, q = quit): "
echo 1>&2
less -rEXF akari2.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./akari2 < akari2.c (space = next page, q = quit): "
echo 1>&2
./akari2 < akari2.c | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./akari2 rot13 < akari2.c (space = next page, q = quit): "
echo 1>&2
./akari2 rot13 < akari2.c | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: make akari3 >/dev/null|| exit 1: "
echo 1>&2
make akari3 >/dev/null|| exit 1
echo 1>&2

read -r -n 1 -p "Press any key to show akari3.c: "
echo 1>&2
cat akari3.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./akari3: "
echo 1>&2
./akari3
echo 1>&2

read -r -n 1 -p "Press any key to run: make akari4 >/dev/null|| exit 1: "
echo 1>&2
make akari4 >/dev/null|| exit 1
echo 1>&2

read -r -n 1 -p "Press any key to show akari4.c: "
echo 1>&2
cat akari4.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./akari4: "
echo 1>&2
./akari4
echo 1>&2

echo "$ ./akari2 rot13 < akari.c | ./akari | tee rot13.c" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./akari2 rot13 < akari.c | ./akari | tee rot13.c | less -rEXF


echo "$ ./akari2 < akari.c | tee expanded_output.txt" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./akari2 < akari.c | tee expanded_output.txt | less -rEXF
echo 1>&2

echo "$ ./akari2 rot13 < akari.c | tee expanded_and_rot13_output.txt" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./akari2 rot13 < akari.c | tee expanded_and_rot13_output.txt | less -rEXF
echo 1>&2
