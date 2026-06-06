#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/jingp49

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
COLUMNS=$(tput cols)
LINES=$(tput lines)
if [[ -z "$COLUMNS" ]]; then
    read -r -p "Enter the width of your current terminal : " COLUMNS
    echo 1>&2
    echo 1>&2
fi
if [[ -z "$LINES" ]]; then
    read -r  -p "Enter the height of your current terminal : " LINES
    echo 1>&2
    echo 1>&2
fi
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
./prog "$COLUMNS" "$LINES"
echo 1>&2
