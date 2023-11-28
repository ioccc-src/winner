#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2011/hamaji
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

read -r -n 1 -p "Press any key to run: ./hamaji < dragon.nono (q = quit, space = next page): "
echo 1>&2
./hamaji < dragon.nono | less -X
echo 1>&2

rm -f dragon dragon2
echo "Checking if you have perl installed..."
PERL="$(type -P perl)"
if [[ -n "$PERL" ]]; then
    echo "Perl installed, will generate output of ./hamaji < dragon.nono."
    read -r -n 1 -p "Press any key to run: $PERL c2nono.pl hamaji.c | ./hamaji > dragon: "
    echo 1>&2
    "$PERL" c2nono.pl hamaji.c | ./hamaji > dragon
    read -r -n 1 -p "Press any key to run: ./hamaji < dragon.nono > dragon2: "
    echo 1>&2
    ./hamaji < dragon.nono > dragon2
    read -r -n 1 -p "Press any key to run: diff -s dragon dragon2: "
    echo 1>&2
    diff -s dragon dragon2
fi
rm -f dragon dragon2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < random.nono: "
echo 1>&2
./hamaji < random.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < soccer.nono: "
echo 1>&2
./hamaji < soccer.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < codegolf.nono: "
echo 1>&2
./hamaji < codegolf.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < face.nono: "
echo 1>&2
./hamaji < face.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < penguin.nono: "
echo 1>&2
./hamaji < penguin.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < samurai.nono (q = quit, space = next page): "
echo 1>&2
./hamaji < samurai.nono | less -X
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < conway-game-of-life.nono: "
echo 1>&2
./hamaji < conway-game-of-life.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < no-solution.nono (no solution): "
echo 1>&2
./hamaji < no-solution.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < multi-solutions.nono (> 1 solution): "
echo 1>&2
./hamaji < multi-solutions.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < plus.nono: "
echo 1>&2
./hamaji < plus.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < smiley.nono: "
echo 1>&2
./hamaji < smiley.nono

exit 0
