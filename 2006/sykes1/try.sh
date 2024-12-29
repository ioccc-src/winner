#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2006/sykes1
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

try()
{
    if [[ "$#" -ne 1 ]]; then
	SYKES1="sykes1"
    else
	SYKES1="$1"
    fi

    read -r -n 1 -p "Press any key to see $SYKES1.c (space = next page, q = quit): "
    echo 1>&2
    less -rEXFK "$SYKES1.c"
    echo 1>&2

    read -r -n 1 -p "Press any key to run: diff -s $SYKES1.c $SYKES1.html: "
    echo 1>&2
    diff -s "$SYKES1".c "$SYKES1".html
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./$SYKES1 (space = next page, q = quit): "
    echo 1>&2
    ./"$SYKES1" | less -rEXFK
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./$SYKES1 5 (space = next page, q = quit): "
    echo 1>&2
    ./"$SYKES1" 5 | less -rEXFK
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./$SYKES1 -1 (space = next page, q = quit): "
    echo 1>&2
    ./"$SYKES1" -1 | less -rEXFK
    echo 1>&2
    echo "What happened and why did it happen?" 1>&2
    echo 1>&2
}

try sykes1
echo 1>&2

read -r -n 1 -p "Press any key to see the alt version: "
echo 1>&2
try sykes1.alt
echo 1>&2

# clean up output files first
rm -f sykes1.out sykes1.alt.out
read -r -n 1 -p "Press any key to run: ./sykes1 > sykes1.out: "
echo 1>&2
./sykes1 > sykes1.out
echo 1>&2
read -r -n 1 -p "Press any key to run: ./sykes1.alt > sykes1.alt.out: "
echo 1>&2
./sykes1.alt > sykes1.alt.out
echo 1>&2

read -r -n 1 -p "Press any key to run: diff sykes1.out sykes1.alt.out (space = next page, q = quit): "
echo 1>&2
diff sykes1.out sykes1.alt.out | less -rEXFK
rm -f sykes1.out sykes1.alt.out
