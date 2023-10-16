#!/usr/bin/env bash


make everything || exit 1

PRIMES=$(type -P primes)

COUNT=15
if [[ "$#" -ge 1 ]]; then
    COUNT="$1"
    if ! [[ $COUNT =~ ^[0-9]+$ ]] ; then
	echo "not a number: $COUNT" 1>&2	
	exit 1
    fi
fi

if [[ -n "$PRIMES" ]]; then
    while read -r n ; do primes "$n" $((n + 1)) ; done < <((./august | head -n "$COUNT" ))
else
    echo "primes not installed" 1>&2
    echo "See the following GitHub repo:" 1>&2
    echo "" 1>&2
    echo "	https://github.com/vattam/BSDGames"
    exit 1
fi
