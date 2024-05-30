#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2013/birken alternate code

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make clobber CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear


trap 'reset; exit' 0 1 2 3 15

PERL="$(type -P perl)"

if [[ -n "$PERL" ]]; then
    read -r -n 1 -p "Press any key to try a random run: "
    echo 1>&2
    perl -e 'map{map{print int(rand()*8);}(0..16);print chr(10);}(0..30);' | tr '0-4' ' '| ./birken.alt
fi

for i in *.txt; do
    NAME="$(echo "$i" | awk '{ print toupper(substr($1,1,1)) substr($1,2)}'|sed -e 's/\.txt//g' \
	-e 's/Ioccc/IOCCC/g' -e 's/Mspacman/Ms Pac-Man/g' -e 's/Helloworld/Hello World/g' \
	-e 's/Cheepcheep/Cheep Cheep/g' -e 's/Happyface/Happy Face/g' -e 's/Paranaplant/Piranha Plant/g' \
	-e 's/Koopaparatroopa/Koopa Paratroopa/g')"
    read -r -n1 -p "Press any key to try $NAME: "
    echo 1>&2
    ./birken.alt < "$i"
    echo 1>&2
done
clear
