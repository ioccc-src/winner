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

read -r -n 1 -p "Press any key to run: echo 1985/10/28 | ./morgan1: "
echo 1>&2
echo "1985/10/28" | ./morgan1
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 1996/12/31 | ./morgan1: "
echo 1>&2
echo "1996/12/31" | ./morgan1
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 1986/03/31 | ./morgan1 # Comet Halley (look for 'Ha'): "
echo 1>&2
echo "1986/03/31" | ./morgan1 # Comet Halley (look for 'Ha')
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 1997/04/01 | ./morgan1 # Comet Hale-Bopp (look for 'Hb'): "
echo 1>&2
echo "1997/04/01" | ./morgan1 # Comet Hale-Bopp (look for 'Hb')
echo 1>&2
