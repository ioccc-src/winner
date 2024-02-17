#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2011/hamaji
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
./hamaji < dragon.nono | less -rEXFK
echo 1>&2

rm -f dragon dragon2
PERL="$(type -P perl)"
if [[ -n "$PERL" && -f "$PERL" && -x "$PERL" ]]; then
    echo "Perl installed, will generate output of ./hamaji < dragon.nono."
    echo 1>&2
    echo "$ $PERL c2nono.pl hamaji.c | ./hamaji | tee dragon"
    read -r -n 1 -p "Press any key to continue (space =  next page, q = quit): "
    "$PERL" c2nono.pl hamaji.c | ./hamaji | tee dragon | less -rEXFK
    echo 1>&2
    echo "$ ./hamaji < dragon.nono | tee dragon2" 1>&2
    read -r -n 1 -p "Press any key to run: ./hamaji < dragon.nono | tee dragon2 (space = next page, q = quit): "
    echo 1>&2
    ./hamaji < dragon.nono | tee dragon2 | less -rEXFK
    read -r -n 1 -p "Press any key to run: diff -s dragon dragon2: "
    echo 1>&2
    diff -s dragon dragon2
else
    echo "Perl not found, will not run perl related steps." 1>&2
fi
rm -f dragon dragon2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < random.nono (space = next page, q = quit): "
echo 1>&2
./hamaji < random.nono | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < soccer.nono (space = next page, q = quit): "
echo 1>&2
./hamaji < soccer.nono | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < codegolf.nono (space = next page, q = quit): "
echo 1>&2
./hamaji < codegolf.nono | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < face.nono (space = next page, q = quit): "
echo 1>&2
./hamaji < face.nono | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < penguin.nono (space = next page, q = quit): "
echo 1>&2
./hamaji < penguin.nono | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < samurai.nono (q = quit, space = next page): "
echo 1>&2
./hamaji < samurai.nono | less -rEXFK
echo 1>&2

echo "$ ./hamaji < conway-game-of-life.nono" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./hamaji < conway-game-of-life.nono | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < no-solution.nono (no solution): "
echo 1>&2
./hamaji < no-solution.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < multi-solutions.nono (> 1 solution): "
echo 1>&2
./hamaji < multi-solutions.nono
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < plus.nono (space = next page, q = quit): "
echo 1>&2
./hamaji < plus.nono | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamaji < smiley.nono (space = next page, q = quit): "
echo 1>&2
./hamaji < smiley.nono | less -rEXFK

exit 0
