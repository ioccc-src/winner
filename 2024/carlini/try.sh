#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/carlini

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# make sure the program has been built
#
MAKE=$(which gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
trap 'echo 1>&2; echo "Now go forth and calculate!" 1>&2; echo 1>&2; exit' 1 2 3 15
echo 'NOTE: This program may take about 75 seconds per operation.' 1>&2
echo 1>&2
echo 'NOTE: After the square root of 2 is printed, abort the program (control C) to exit.' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: echo '5+3-oS' | ./prog redacted.bin: (please be very patient) "
echo 1>&2
echo 1>&2
echo "5+3-oS" | ./prog redacted.bin
