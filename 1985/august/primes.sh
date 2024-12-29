#!/usr/bin/env bash
#
# primes.sh - feed primes(1) IOCCC entry 1985/august
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

PRIMES=$(type -P primes)

COUNT=15
if [[ "$#" -ge 1 ]]; then
    COUNT="$1"
    if ! [[ $COUNT =~ ^[0-9]+$ ]]; then
	echo "not a number: $COUNT" 1>&2	
	exit 1
    fi
fi

if [[ -n "$PRIMES" ]]; then
    while read -r n; do primes "$n" $((n + 1)); done < <((./august | head -n "$COUNT" | sed '/^$/d'))
else
    echo "primes not installed" 1>&2
    echo 1>&2
    echo "See the following GitHub repo:" 1>&2
    echo 1>&2
    echo "	https://github.com/vattam/BSDGames" 1>&2
    echo 1>&2
    echo "and after installing it try running this again."
    exit 1
fi
