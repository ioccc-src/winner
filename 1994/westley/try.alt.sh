#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 1994/westley alternate code
#

# make sure CC is set so that one can control what compiler to use in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

rm -f westley.alt
"${CC}" -Describe -Door westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Describe -Drain westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Describe -Dwarf westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Describe -Debris westley.alt.c -o westley.alt && ./westley.alt # or -Dungeon
sleep 1
echo 1>&2
"${CC}" -Describe -Desk westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Describe -Dime westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Describe -Directory westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Dial -DUNgeon0614 westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Drink -Daiquiri westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Drop -Daiquiri westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Drop -Dwarf -Daiquiri westley.alt.c -o westley.alt && ./westley.alt # or -Drop -Down -Daiquiri
sleep 1
echo 1>&2
"${CC}" -Describe -Document westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Depress -Dotted -Dog westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Depress -Dalmatian westley.alt.c -o westley.alt && ./westley.alt # also accepts "Dalmation" [sic]
sleep 1
echo 1>&2
"${CC}" -Deposit -Dime westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Drop -Donut westley.alt.c -o westley.alt && ./westley.alt
sleep 1
echo 1>&2
"${CC}" -Drop -Donut -Down -Drain westley.alt.c -o westley.alt && ./westley.alt # or -Drop -Dwarf -Donut
echo 1>&2
rm -f westley.alt
