#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1994/westley
#

# make sure CC is set so that one can control what compiler to use in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# check for 80 columns
COLS="$(tput cols)"
if [[ "$COLS" != 80 ]]; then
    echo "WARNING: without a terminal with 80 columns, 8 character tabs and wraparound" 1>&2
    echo "this will not look that great. We have detected that you do not have your terminal" 1>&2
    echo -n "at 80 columns. Do you still wish to continue (Y/N)? "
    read -r -p ""
    if [[ "$REPLY" != "y" && "$REPLY" != "Y" ]]; then
	exit 1
    fi
fi

clear

"${CC}" -Describe -Door westley.c
"${CC}" -Describe -Drain westley.c
"${CC}" -Describe -Dwarf westley.c
"${CC}" -Describe -Debris westley.c # or -Dungeon
"${CC}" -Describe -Desk westley.c
"${CC}" -Describe -Dime westley.c
"${CC}" -Describe -Directory westley.c
"${CC}" -Dial -DUNgeon0614 westley.c
"${CC}" -Drink -Daiquiri westley.c
"${CC}" -Drop -Daiquiri westley.c
"${CC}" -Drop -Dwarf -Daiquiri westley.c # or -Drop -Down -Daiquiri
"${CC}" -Describe -Document westley.c
"${CC}" -Depress -Dotted -Dog westley.c
"${CC}" -Depress -Dalmatian westley.c # also accepts "Dalmation" [sic]
"${CC}" -Deposit -Dime westley.c
"${CC}" -Drop -Donut westley.c
"${CC}" -Drop -Donut -Down -Drain westley.c # or -Drop -Dwarf -Donut
