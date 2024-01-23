#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC winner 1994/westley alt code
#

# make sure CC is set so that one can control what compiler to use in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

rm -f a.out
"${CC}" -Describe -Door westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Describe -Drain westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Describe -Dwarf westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Describe -Debris westley.alt.c && ./a.out # or -Dungeon
sleep 1
echo 1>&2
"${CC}" -Describe -Desk westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Describe -Dime westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Describe -Directory westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Dial -DUNgeon0614 westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Drink -Daiquiri westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Drop -Daiquiri westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Drop -Dwarf -Daiquiri westley.alt.c && ./a.out # or -Drop -Down -Daiquiri
sleep 1
echo 1>&2
"${CC}" -Describe -Document westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Depress -Dotted -Dog westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Depress -Dalmatian westley.alt.c && ./a.out # also accepts "Dalmation" [sic]
sleep 1
echo 1>&2
"${CC}" -Deposit -Dime westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Drop -Donut westley.alt.c && ./a.out
sleep 1
echo 1>&2
"${CC}" -Drop -Donut -Down -Drain westley.alt.c && ./a.out # or -Drop -Dwarf -Donut
echo 1>&2
rm -f a.out
