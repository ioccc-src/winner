#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/schweikhardt
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

echo "$ ./prog 19" 1>&2
./prog 19

read -r -n 1 -p "Press any key to run: ./prog 2410 (space = next page, q = quit): "
echo 1>&2
./prog 2410 | less -rEXFK
read -r -n 1 -p "Press any key to run: ./prog abfff (space = next page, q = quit): "
echo 1>&2
./prog abfff | less -rEXFK
read -r -n 1 -p "Press any key to run: ./prog 27f8cebf (space = next page, q = quit): "
echo 1>&2
./prog 27f8cebf | less -rEXFK
read -r -n 1 -p "Press any key to run: ./prog 246f8fddf (space = next page, q = quit): "
echo 1>&2
./prog 246f8fddf | less -rEXFK
read -r -n 1 -p "Press any key to run: ./prog 2e95ab51ffea9de (space = next page, q = quit): "
echo 1>&2
./prog 2e95ab51ffea9de | less -rEXFK
read -r -n 1 -p "Press any key to run: ./prog e6a5c22fd7bde9f (space = next page, q = quit): "
echo 1>&2
./prog e6a5c22fd7bde9f | less -rEXFK
read -r -n 1 -p "Press any key to run: ./prog 1b7dd73a937485bf (space = next page, q = quit): "
echo 1>&2
./prog 1b7dd73a937485bf | less -rEXFK
read -r -n 1 -p "Press any key to run: ./prog 7d3237680d190a77e53751b (space = next page, q = quit): "
echo 1>&2
./prog 7d3237680d190a77e53751b | less -rEXFK
read -r -n 1 -p "Press any key to run: ./prog 302ab3d052fb87c06228d249581be0e4 (space = next page, q = quit): "
echo 1>&2
./prog 302ab3d052fb87c06228d249581be0e4 | less -rEXFK
echo 1>&2
read -r -n 1 -p "Press any key to run ./prog with a googol (10^100) (space = next page, q = quit): "
echo 1>&2
./prog 1249AD2594C37CEB0B2784C4CE0BF38ACE408E211A7CAAB24308A82E8F10000000000000000000000000 | less -rEXFK
