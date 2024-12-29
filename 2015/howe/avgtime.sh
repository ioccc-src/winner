#!/usr/bin/env bash

if [[ "$#" -lt 2 ]]; then
    echo "usage: $0 <count> <command>" 1>&2
    exit 1
fi

COUNT=$1; shift
# SC2124 (warning): Assigning an array to a string! Assign as array, or use * instead of @ to concatenate.
# https://www.shellcheck.net/wiki/SC2124
# shellcheck disable=SC2124
CMD="$@"

N=0
SYS=0
USER=0
REAL=0

while [[ $N -lt $COUNT ]]; do
	# 'fixing' this will break the script so we disable it:
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# https://www.shellcheck.net/wiki/SC2086
	# shellcheck disable=SC2086
 	TIME=$( { /usr/bin/time -l $CMD >/dev/null; } 2>&1 | head -n 1 )
	# 'fixing' this will break the script so we disable it:
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# https://www.shellcheck.net/wiki/SC2086
	# shellcheck disable=SC2086
	REAL="$REAL + $(echo $TIME | cut -d' ' -f1)"
	# 'fixing' this will break the script so we disable it:
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# shellcheck disable=SC2086
	USER="$USER + $(echo $TIME | cut -d' ' -f3)"
	# 'fixing' this will break the script so we disable it:
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# https://www.shellcheck.net/wiki/SC2086
	# shellcheck disable=SC2086
	SYS="$SYS + $(echo $TIME | cut -d' ' -f5)"
	((N++))
done

printf 'avg-real\t%.3f\n' "$(echo "scale=3; ( $REAL ) / $COUNT" | bc)"
printf 'avg-user\t%.3f\n' "$(echo "scale=3; ( $USER ) / $COUNT" | bc)"
printf 'avg-sys\t%.3f\n' "$(echo "scale=3; ( $SYS ) / $COUNT" | bc)"

