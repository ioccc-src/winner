#!/usr/bin/env sh
#
# try.sh - demonstrate IOCCC winner 1995/garry
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


echo "$ EXAMPLEON=\"\33\133\61\73\67\155\"; EXAMPLEOFF=\"\33\133\155\"; DOLLAR=\"$\"" 1>&2
EXAMPLEON="\33\133\61\73\67\155"
EXAMPLEOFF="\33\133\155"
DOLLAR="$"
export EXAMPLEON EXAMPLEOFF DOLLAR

read -r -n 1 -p "Press any key to run: ./garry < garry.data | less (q = quit, space = next page): "

./garry <garry.data | less -r -X
echo 1>&2

read -r -n 1 -p "Press any key to run: ./garry < README.md | less (q = quit, space = next page): "
./garry < README.md | less -X
