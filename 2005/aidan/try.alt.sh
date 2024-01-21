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

read -r -n 1 -p "Press any key to run: ./$AIDAN < blank.sudoku (space = next page, q = quit): "
echo 1>&2
./"$AIDAN" < blank.sudoku | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: echo IOCCC | ./$AIDAN (space = next page, q = quit): "
echo IOCCC | ./"$AIDAN" | less -rEXF
echo "What just happened?" 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: echo IOCCC | ./$AIDAN 42 (space = next page, q = quit): "
echo IOCCC | ./"$AIDAN" 42 1>&2 | less -rEXF
echo 1>&2
echo "Seeing that, was the 'echo IOCCC' relevant?" 1>&2
echo 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./$AIDAN < insane1.sudoku (space = next page, q = quit): "
echo 1>&2
./"$AIDAN" < insane1.sudoku
echo 1>&2
echo "Did you notice how much slower this is than aidan.c? If not try try.sh!" 1>&2
echo 1>&2
