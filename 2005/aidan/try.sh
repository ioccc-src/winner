#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2005/aidan
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

AIDAN="aidan"

echo "$ ./$AIDAN < blank.sudoku" 1>&2
./"$AIDAN" < blank.sudoku
echo 1>&2

echo "$ ./$AIDAN U < blank.sudoku" 1>&2
read -r -n 1 -p "Press any key to continue: "
./"$AIDAN" U < blank.sudoku
echo "What was the difference between the previous command?" 1>&2
echo "More specifically, what did it do?" 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo "$ echo IOCCC | ./$AIDAN" 1>&2
echo IOCCC | ./"$AIDAN"
echo "What just happened?" 1>&2
echo 1>&2

echo 1>&2
echo "$ echo IOCCC | ./$AIDAN 42 | less -r" 1>&2
read -r -n 1 -p "Press any key to continue (q = exit pager space = go down a page): "
echo IOCCC | ./"$AIDAN" 42 | less -r
echo "Seeing that, was the 'echo IOCCC' relevant?" 1>&2
echo 1>&2

echo "$ ./$AIDAN < insane1.sudoku" 1>&2
read -r -n 1 -p "Press any key to continue: "
./"$AIDAN" < insane1.sudoku

read -r -n 1 -p "Do you with to run the test suite (y/n)? "
if [[ "$REPLY" = "y" ]]; then
    echo 1>&2
    echo "$ make test" 1>&2
    read -r -n 1 -p "Press any key to continue: "
    make test
fi
