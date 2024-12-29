#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2019/lynn
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

echo "$ (./prog < fib.hs; cat prog.c) | tee fib.c" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
(./prog < fib.hs; cat prog.c) | tee fib.c | less -rEXFK

read -r -n 1 -p "Press any key to run: make fib: "
echo 1>&2
make CC="$CC" fib
echo 1>&2

read -r -n 1 -p "Press any key to run: ./fib: "
echo 1>&2
./fib

echo "$ (./prog < lol.hs ; cat prog.c) | tee lol.c" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
(./prog < lol.hs ; cat prog.c) | tee lol.c | less -rEXFK

read -r -n 1 -p "Press any key to run: make lol: " 1>&2
echo 1>&2
make CC="$CC" lol
read -r -n 1 -p "Press any key to run: ./lol: "
echo 1>&2
./lol
echo 1>&2

echo 1>&2
echo "$ (./prog < scc.hs ; cat prog.c) | tee scc.c" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
(./prog < scc.hs ; cat prog.c) | tee scc.c | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: make scc: "
echo 1>&2
make CC="$CC" scc

read -r -n 1 -p "Press any key to run: ./scc < example-1.txt: "
echo 1>&2
./scc < example-1.txt
read -r -n 1 -p "Press any key to run: ./scc < example-2.txt: "
echo 1>&2
./scc < example-2.txt

exit 0

