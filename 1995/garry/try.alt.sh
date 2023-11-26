#!/usr/bin/env sh
#
# try.alt.sh - demonstrate IOCCC winner 1995/garry alt code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "$ EXAMPLEON=\"\33\133\61\73\67\155\"; EXAMPLEOFF=\"\33\133\155\"; DOLLAR=\"$\"" 1>&2
EXAMPLEON="\33\133\61\73\67\155"
EXAMPLEOFF="\33\133\155"
DOLLAR="$"
export EXAMPLEON EXAMPLEOFF DOLLAR

read -r -n 1 -p "Press any key to run: ./garry.alt < garry.data | less (q = quit, space = next page): "

./garry.alt <garry.data | less -r -X
echo 1>&2

read -r -n 1 -p "Press any key to run: ./garry.alt < README.md | less (q = quit, space = next page): "
./garry.alt < README.md | less -X
