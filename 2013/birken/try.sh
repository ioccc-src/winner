#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2013/birken

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

if [[ -z "$BIRKEN" ]]; then
    BIRKEN="birken.alt"
fi

trap 'reset; exit' 0 1 2 3 15

for i in *.txt; do
    NAME="$(echo "$i" | awk '{ print toupper(substr($1,1,1)) substr($1,2)}'|sed -e 's/\.txt//g' \
	-e 's/Ioccc/IOCCC/g' -e 's/Mspacman/Ms Pac-Man/g' -e 's/Helloworld/Hello World/g' \
	-e 's/Cheepcheep/Cheep Cheep/g' -e 's/Happyface/Happy Face/g' -e 's/Paranaplant/Piranha Plant/g' \
	-e 's/Koopaparatroopa/Koopa Paratroopa/g')"
    read -r -n1 -p "Press any key to try $NAME: "
    ./"${BIRKEN}" < "$i"
    echo
done
clear
