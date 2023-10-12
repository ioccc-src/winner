#!/usr/bin/env bash

make all || exit 1

# set it so that when program is terminated through various signals we re-enable
# the cursor
trap "tput cnorm;echo" 0 1 2 3 15

# temporarily disable cursor
tput civis

# run program attempting to feed it a file, if specified
if [[ "$#" -eq 1 ]]; then
    ./endoh4 < "$1"
else
    # otherwise feed the source code of the program to the program
    ./endoh4 < endoh4.c
fi

# explicitly set cursor back just in case it's not terminated through one of the
# above signals
tput cnorm
