#!/bin/ksh

COUNT=$1; shift
CMD="$@"

N=0
SYS=0
USER=0
REAL=0

while [ $N -lt $COUNT ]; do
 	TIME=$( { /usr/bin/time -l $CMD >/dev/null; } 2>&1 | head -n 1 )
	REAL="$REAL + $(echo $TIME | cut -d' ' -f1)"
	USER="$USER + $(echo $TIME | cut -d' ' -f3)"
	SYS="$SYS + $(echo $TIME | cut -d' ' -f5)"
	(( N = $N + 1 ))
done

printf 'avg-real\t%.3f\n' $(echo "scale=3; ( $REAL ) / $COUNT" | bc)
printf 'avg-user\t%.3f\n' $(echo "scale=3; ( $USER ) / $COUNT" | bc)
printf 'avg-sys\t%.3f\n' $(echo "scale=3; ( $SYS ) / $COUNT" | bc)

