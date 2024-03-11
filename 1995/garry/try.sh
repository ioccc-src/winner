#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1995/garry
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

# This warning from ShellCheck is incorrect because we don't want them to be expanded.
# This does show correct output.
#
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2028
echo "$ EXAMPLEON=\"\\33\133\61\73\67\155\"; EXAMPLEOFF=\"\33\133\155\"; DOLLAR=\"$\"" 1>&2
EXAMPLEON="\33\133\61\73\67\155"
EXAMPLEOFF="\33\133\155"
DOLLAR="$"
echo "$ export EXAMPLEON EXAMPLEOFF DOLLAR" 1>&2
export EXAMPLEON EXAMPLEOFF DOLLAR
echo 1>&2
echo "As you continue with the script, consider why the above was necessary." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to show garry.data (space = next page, q = quit): "
echo 1>&2
less -rEXF garry.data
echo 1>&2

read -r -n 1 -p "Press any key to run: ./garry < garry.data (space = next page, q = quit): "
echo 1>&2
./garry <garry.data | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./garry < README.md | less (q = quit, space = next page): "
./garry < README.md | less -rEXF
