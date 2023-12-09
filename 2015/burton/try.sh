#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2015/burton
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

echo "$ ./prog '?0x3343<<2'" 1>&2
./prog '?0x3343<<2'

echo "$ echo '?0x3343<<2' | ./prog" 1>&2
echo '?0x3343<<2' | ./prog


echo "$ grep '[0-9]' prog.c" 1>&2
read -r -n 1 -p "Press any key to continue (notice how there are no digits!): "
echo 1>&2
grep -c '[0-9]' prog.c

read -r -n 1 -p "Press any key to run: ./prog < test.in: "
echo 1>&2
./prog < test.in
echo 1>&2

read -r -n 1 -p "Press any key to show try.this.txt: "
echo 1>&2
cat try.this.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < try.this.txt: "
echo 1>&2
./prog < try.this.txt

read -r -n 1 -p "Press any key to show the hex value of 42: "
echo 1>&2
echo "$ ./prog 42" 1>&2
./prog 42
