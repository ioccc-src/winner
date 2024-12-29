#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/vik
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

read -r -n 1 -p "Press any key to embed chocolate.png in ioccc.png: "
echo 1>&2
echo "$ ./vik e ioccc.png chocolate.png > chocolate-in-ioccc.png" 1>&2
./vik e ioccc.png chocolate.png > chocolate-in-ioccc.png
echo 1>&2

read -r -n 1 -p "Press any key to embed ioccc.png in chocolate.png: "
echo 1>&2
echo "$ ./vik e chocolate.png ioccc.png > ioccc-in-chocolate.png"
./vik e chocolate.png ioccc.png > ioccc-in-chocolate.png
echo 1>&2

read -r -n 1 -p "Press any key to embed chocolate in chocolate-in-ioccc.png: "
echo 1>&2
echo "$ ./vik e chocolate-in-ioccc.png \"Mmm... chocolate.\" > mmm-chocolate.png" 1>&2
./vik e chocolate-in-ioccc.png "Mmm... chocolate." > mmm-chocolate.png
echo 1>&2

read -r -n 1 -p "Press any key to extract chocolate from mmm-chocolate.png: "
echo 1>&2
echo "$ ./vik d mmm-chocolate.png" 1>&2
./vik d mmm-chocolate.png
echo 1>&2

read -r -n 1 -p "Press any key to embed a brainfuck program as a text file and decode it: "
echo 1>&2
echo "$ ./vik e ioccc.png .+[.+] > encodedimg.png" 1>&2
./vik e ioccc.png .+[.+] > encodedimg.png
echo "$ ./vik b encodedimg.png" 1>&2
./vik b encodedimg.png
echo 1>&2

read -r -n 1 -p "Press any key to extract chocolate from chocolate-in-ioccc.png: "
echo 1>&2
echo "$ ./vik d chocolate-in-ioccc.png > restored-chocolate.png" 1>&2
./vik d chocolate-in-ioccc.png > restored-chocolate.png
echo 1>&2
echo "Make sure to open restored-chocolate.png in your graphics viewer of choice!" 1>&2

read -r -n 1 -p "Press any key to extract ioccc from ioccc-in-chocolate.png: "
echo 1>&2
echo "$ ./vik d ioccc-in-chocolate.png > restored-ioccc.png" 1>&2
./vik d ioccc-in-chocolate.png > restored-ioccc.png
echo "Now make sure to open restored-ioccc.png in your graphics viewer of choice!" 1>&2

exit 0
