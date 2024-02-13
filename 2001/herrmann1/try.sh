#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2001/herrmann1
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# in this case we won't fail if we can't compile the code because we can still
# run the supplementary program.
make CC="$CC" everything >/dev/null

# clear screen after compilation so that only the entry is shown
clear

echo "$ ./herrmann1.sh 'prg=herrmann1.times2'" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./herrmann1.sh 'prg=herrmann1.times2' | less -rEXFK
echo 1>&2

echo "$ ./herrmann1.sh 'prg=herrmann1.gcd'" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./herrmann1.sh 'prg=herrmann1.gcd' | less -rEXFK
echo 1>&2

