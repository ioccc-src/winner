#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2005/aidan alt code
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

AIDAN="aidan.alt"

echo "When looking at the output, notice how some of the output is different" 1>&2
echo "from the aidan.c." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo "$ ./$AIDAN < blank.sudoku" 1>&2
./"$AIDAN" < blank.sudoku
echo 1>&2

read -r -n 1 -p "Press any key to continue: "


echo "$ echo IOCCC | ./$AIDAN" 1>&2
echo IOCCC | ./"$AIDAN"
echo "What just happened?" 1>&2
echo 1>&2

echo "$ echo IOCCC | ./$AIDAN 42" 1>&2
read -r -n 1 -p "Press any key to continue (q = exit pager space = go down a page): "
echo IOCCC | ./"$AIDAN" 42 1>&2
echo "Seeing that, was the 'echo IOCCC' relevant?" 1>&2
echo 1>&2

echo "$ ./$AIDAN < insane1.sudoku" 1>&2
read -r -n 1 -p "Press any key to continue: "
./"$AIDAN" < insane1.sudoku
echo "Did you notice how much slower this is than aidan? If not try try.sh!" 1>&2
echo 1>&2
