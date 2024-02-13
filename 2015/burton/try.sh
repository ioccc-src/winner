#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/burton
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

read -r -n 1 -p "Press any key to run: ./calc '?0x3343<<2': "
echo 1>&2
./calc '?0x3343<<2'
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '?0x3343<<2' | ./ecalc: "
echo 1>&2
echo '?0x3343<<2' | ./ecalc
echo 1>&2


read -r -n 1 -p "Press any key to run: grep '[0-9]' prog.c || echo \"no digits in prog.c!\": "
echo 1>&2
grep -q '[0-9]' prog.c || echo "no digits found in prog.c!"
echo 1>&2

read -r -n 1 -p "Press any key to show calc.in (space = next page, q = quit): "
echo 1>&2
less -rEXFK test.in
echo 1>&2

read -r -n 1 -p "Press any key to run: ./calc < test.in (space = next page, q = quit): "
echo 1>&2
./calc < test.in | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to show try.this.txt (space = next page, q = quit): "
echo 1>&2
less -rEXFK try.this.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./calc < try.this.txt (space = net page, q = quit): "
echo 1>&2
./calc < try.this.txt | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./ecalc < try.this.txt (space = next page, q = quit): "
echo 1>&2
./ecalc < try.this.txt | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./calc 42 # show hex value of 42: "
echo 1>&2
./calc 42
echo 1>&2

read -r -n 1 -p "Press any key to run: ./calc '1<<22-1' # show mask value for 22 bits: "
echo 1>&2
./calc '1<<22-1'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./calc ?0x11223344 # byte-swapped value of 0x11223344: "
echo 1>&2
./calc '?0x11223344'
echo 1>&2
