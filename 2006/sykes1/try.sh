#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2006/sykes1
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

    echo "$ diff -s $SYKES1.c $SYKES1.html" 1>&2
    diff -s "$SYKES1".c "$SYKES1".html
    echo 1>&2

    echo "$ ./$SYKES1 | less" 1>&2
    read -r -n 1 -p "Press any key to continue (use 'q' to quit pager, space to scroll a page down): "
    ./"$SYKES1" | less
    echo 1>&2

    echo "$ ./$SYKES1 5 | less" 1>&2
    read -r -n 1 -p "Press any key to continue (use 'q' to quit pager, space to scroll a page down): "
    ./"$SYKES1" 5 | less
    echo 1>&2

    echo "$ ./$SYKES1 -1 | less" 1>&2
    read -r -n 1 -p "Press any key to continue ('q' to quit pager, space to scroll a page down): "
    ./"$SYKES1" -1 | less
    echo 1>&2
    echo "What happened and why did it happen?" 1>&2
    echo 1>&2
}

read -r -n 1 -p "Press any key to see the entry: "
try sykes1
echo 1>&2

read -r -n 1 -p "Press any key to see the alt version: "
try sykes1.alt
echo 1>&2

# clean up output files first
rm -f sykes1.out sykes1.alt.out
read -r -n 1 -p "Press any key to look at output differences of the two: "
echo 1>&2

echo "$ ./sykes1 > sykes1.out" 1>&2
./sykes1 > sykes1.out
echo "$ ./sykes1.alt > sykes1.alt.out" 1>&2
./sykes1.alt > sykes1.alt.out

echo "$ diff sykes1.out sykes1.alt.out | less" 1>&2
read -r -n 1 -p "Press any key to continue (use 'q' to quit pager, space to scroll down a page): "
diff sykes1.out sykes1.alt.out | less
rm -f sykes1.out sykes1.alt.out
