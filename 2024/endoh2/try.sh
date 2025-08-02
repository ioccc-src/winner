#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/endoh2

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
make CC="$CC" all tipple >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
echo 'NOTE: To exit, press CTRL+C' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./tipple < tippe-top2.txt: "
echo 1>&2
echo 1>&2
./tipple < tippe-top2.txt
echo 1>&2
