#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1984/laman
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

run()
{
    if [[ "$#" -ne 1 ]]; then
	echo "$0: expected 1 arg, got: $#" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: ./laman $1: "
    echo 1>&2
    ./laman "$1"
    echo 1>&2
}


run_twice()
{
    if [[ "$#" -ne 1 ]]; then
	echo "$0: expected 1 arg, got: $#" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: ./laman $1; ./laman $1: "
    echo 1>&2
    ./laman "$1"; ./laman "$1"
    echo 1>&2
}
run 4
run 9
run 16

run_twice 4
run_twice 9
run_twice 16

read -r -n 1 -p "Press any key to run: ./laman 4; ./laman 9; ./laman 16: "
echo 1>&2
./laman 4; ./laman 9; ./laman 16
echo 1>&2

read -r -n 1 -p "Press any key to run: ./laman 4; ./laman 8; ./laman 16; ./laman 32; ./laman 64: "
echo 1>&2
./laman 4; ./laman 8; ./laman 16; ./laman 32; ./laman 64
echo 1>&2
