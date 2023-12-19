#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2019/lynn
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

echo "$ (./prog < fib.hs; cat prog.c) > fib.c" 1>&2
(./prog < fib.hs; cat prog.c) > fib.c
echo "$ cc -Wno-everything fib.c -o fib" 1>&2
cc -Wno-everything fib.c -o fib
echo "$ ./fib" 1>&2
./fib
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2

echo "$ (./prog < lol.hs ; cat prog.c) > lol.c" 1>&2
(./prog < lol.hs ; cat prog.c) > lol.c
echo "$ make lol" 1>&2
make lol
read -r -n 1 -p "Press any key to run: ./lol: "
echo 1>&2
./lol
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ (./prog < scc.hs ; cat prog.c) > scc.c" 1>&2
(./prog < scc.hs ; cat prog.c) > scc.c
echo "$ make scc" 1>&2
make scc
read -r -n 1 -p "Press any key to run: ./scc < example-1.txt: "
echo 1>&2
./scc < example-1.txt
read -r -n 1 -p "Press any key to run: ./scc < example-2.txt: "
echo 1>&2
./scc < example-2.txt


exit 0

