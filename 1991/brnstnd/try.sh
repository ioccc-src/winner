#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1991/brnstnd
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

sorta_with_arg()
{
    if [[ "$#" != 2 ]]; then
	echo "$0: sorta_with_arg() expects a file and arg, only got file name" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: ./sorta < $1 $2: "
    echo 1>&2
    ./sorta < "$1" "$2"
    echo 1>&2
}

sorta()
{
    if [[ "$#" != 1 ]]; then
	echo "$0: sorta() expects 1 arg, got: $#" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: ./sorta < $1: "
    echo 1>&2
    ./sorta < "$1"
    echo 1>&2
}

sorta sorta.i2+2
sorta sorta.icalc
sorta_with_arg sorta.iecho "IOCCC 1991/brnstnd"
sorta sorta.ifact2
sorta sorta.iio
sorta sorta.isleep
sorta sorta.iwhosort
sorta sorta.iarg0
sorta sorta.idup
sorta sorta.ifact1
sorta sorta.ifact3
read -r -n 1 -p "Press any key to show try.txt: "
echo 1>&2
cat try.txt
echo 1>&2
sorta_with_arg sorta.irot13 try.txt
