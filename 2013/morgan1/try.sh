#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2013/morgan1
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

echo "Usage instructions: once the program is in focus, use the arrow keys to" 1>&2
echo "go through the dates:" 1>&2
echo 1>&2
echo "Right: go forwards one day." 1>&2
echo "Left : go backwards one." 1>&2
echo "Up   : go forwards 20 days." 1>&2
echo "Down : go backwards 20 days." 1>&2
echo 1>&2
echo "Note: the third run is Comet Halley - look for 'Ha'." 1>&2
echo 1>&2
echo "Note: the fourth run is Comet Hale-Bopp - Look for 'Hb'." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 1985/10/28 | ./morgan1: "
echo 1>&2
echo "1985/10/28" | ./morgan1
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 1996/12/31 | ./morgan1: "
echo 1>&2
echo "1996/12/31" | ./morgan1
echo 1>&2

echo "The next one is Comet Halley. Look for 'Ha' in the display." 1>&2
read -r -n 1 -p "Press any key to run: echo 1986/03/31 | ./morgan1: "
echo 1>&2
# Comet Halley (look for 'Ha'):
echo "1986/03/31" | ./morgan1
echo 1>&2

echo "The next one is Comet Hale-Bopp. Look for 'Hb' in the display." 1>&2
read -r -n 1 -p "Press any key to run: echo 1997/04/01 | ./morgan1: "
echo 1>&2
# Comet Hale-Bopp (look for 'Hb'):
echo "1997/04/01" | ./morgan1
echo 1>&2
