#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2019/mills
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make clobber CC="$CC" all >/dev/null || exit 1


read -r -n 1 -p "Press any key to run: make test-64bit: "
echo 1>&2
echo "This may take a while:"
make test-64bit

echo "$ less IOCCC-Rules-Guidelines.output.txt" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
less -rEXFK IOCCC-Rules-Guidelines.output.txt
echo 1>&2

echo "$ less IOCCC-hints.output.txt" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
less -rEXFK IOCCC-hints.output.txt
echo 1>&2

echo "$ less Eugene_Onegin.output.txt" 1>&2
echo "You should be able to safely ignore the warnings about this file" 1>&2
echo "being a binary file." 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
less -rEXFK Eugene_Onegin.output.txt
echo 1>&2

echo "$ ./prog < IOCCC-Rules-Guidelines.cp98_0.175 |head -n 100"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog < IOCCC-Rules-Guidelines.cp98_0.175 |head -n 100 | less -rEXFK
echo 1>&2

echo "$ ./prog < Shakespeare.cp04_1.633 | head -n 100" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog < Shakespeare.cp04_1.633 | head -n 100 | less -rEXFK
echo 1>&2
