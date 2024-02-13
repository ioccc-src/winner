#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2013/robison
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

read -r -n 1 -p "Press any key to run: echo '1*2*3*4*5*6*7*8*9%1000' | ./robison: "
echo 1>&2
echo '1*2*3*4*5*6*7*8*9%1000' | ./robison
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '100000000000000000000*(20*(1+(99477941840441*50)))/31664812345028528' | ./robison: "
echo 1>&2
echo '100000000000000000000*(20*(1+(99477941840441*50)))/31664812345028528' | ./robison
