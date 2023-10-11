#!/usr/bin/env bash

make clobber everything 2>/dev/null

if [[ -z "$BIRKEN" ]]; then
    BIRKEN="birken.alt"
fi

trap "clear; exit" SIGINT

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
