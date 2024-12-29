#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2005/aidan
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
read -r -n 1 -p "Press any key to run: ./$AIDAN < blank.sudoku (space = next page, q = quit): "
echo 1>&2
./"$AIDAN" < blank.sudoku | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./$AIDAN U < blank.sudoku (space = next page, q = quit): "
echo 1>&2
./"$AIDAN" U < blank.sudoku | less -rEXFK
echo 1>&2
echo "What was the difference between the previous command?" 1>&2
echo "More specifically, what did it do?" 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: echo IOCCC | ./$AIDAN (space = next page, q = quit): "
echo 1>&2
echo IOCCC | ./"$AIDAN" | less -rEXFK
echo 1>&2
echo "What just happened?" 1>&2
echo 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: echo IOCCC | ./$AIDAN 42 (space = next page, q = quit): "
echo 1>&2
echo IOCCC | ./"$AIDAN" 42 | less -rEXFK
echo 1>&2
echo "Seeing that, was the 'echo IOCCC' relevant?" 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./$AIDAN < insane1.sudoku (space = next page, q = quit): "
./"$AIDAN" < insane1.sudoku | less -rEXFK

read -r -n 1 -p "Do you with to run the test suite (y/n)? "
if [[ "$REPLY" = "y" || "$REPLY" = "Y" ]]; then
    echo 1>&2
    read -r -n 1 -p "Press any key to run: make test (space = next page, q = quit): "
    echo 1>&2
    make test | less -rEXFK
fi
