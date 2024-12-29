#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2004/hoyle
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


read -r -n 1 -p "Press any key to run: ./hoyle 10 0.5 (space = next page, q = quit): "
echo 1>&2
./hoyle 10 0.5 | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hoyle 1 1 1 1 (space = next page, q = quit): "
echo 1>&2
./hoyle 1 1 1 1 | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hoyle 2 0 1 0 -0.001 (space = next page, q = quit): "
echo 1>&2
./hoyle 2 0 1 0 -0.001 | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hoyle 1 2 3 42 -0.42 (space = next page, q = quit): "
echo 1>&2
./hoyle 1 2 3 42 -0.42 | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hoyle 42 42 42 42 42 42 (space = next page, q = quit): "
echo 1>&2
./hoyle 42 42 42 42 42 42 | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hoyle 42 42 42 42 42 (space = next page, q = quit): "
echo 1>&2
./hoyle 42 42 42 42 42 | less -rEXFK
echo 1>&2


read -r -n 1 -p "Press any key to run: ./hoyle 0 0 1 | tee hoyle1.txt (space = next page, q = quit): "
echo 1>&2
./hoyle 0 0 1 | tee hoyle1.txt | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hoyle 0 0 2 | tee hoyle2.txt (space = next page, q = quit): "
echo 1>&2
./hoyle 0 0 2 | tee hoyle2.txt | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: diff -s hoyle1.txt hoyle2.txt: "
echo 1>&2
diff -s hoyle1.txt hoyle2.txt
echo "... why are they the same?"
rm -f hoyle1.txt hoyle2.txt
