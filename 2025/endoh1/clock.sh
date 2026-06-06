#!/usr/bin/env bash
#
# clock - display a 24 hour Nixie tube clock
#
# NOTE: This needs a window at least 336 columns wide by at least 34 lines tall.

# setup
#
export VERSION="1.0 2026-03-26"
NAME=$(basename "$0")
export NAME
#
export CYCLE_LIMIT=""

# usage
#
export USAGE="usage: $0 [-h] [-V] [seconds]

    -h          print help message and exit
    -V          print version string and exit

    [seconds]	seconds to run, 0 ==> unlimited (def: unlimited)

Exit codes:
     0         all OK
     2         -h and help string printed or -V and version string printed
     3         command line error
 >= 10         internal error

$NAME version: $VERSION"

# parse command line
#
while getopts :hV flag; do
  case "$flag" in
    h) echo "$USAGE"
	exit 2
	;;
    V) echo "$VERSION"
	exit 2
	;;
    \?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    :) echo "$0: ERROR: option -$OPTARG requires an argument" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    *) echo "$0: ERROR: unexpected value from getopts: $flag" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
  esac
done
#
# remove the options
#
shift $(( OPTIND - 1 ));
#
# parse args
#
if [[ $# -eq 1 ]]; then
    CYCLE_LIMIT="$1"
elif [[ $# -gt 1 ]]; then
    echo "$0: ERROR: expected 0 or 1 args, found: $#" 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi
if [[ $CYCLE_LIMIT -eq 0 ]]; then
    CYCLE_LIMIT=""
fi

# --- SIZE CHECK ---
# We check this first to fail fast before changing terminal modes
REQUIRED_W=336
REQUIRED_H=34
CUR_W=$(tput cols)
CUR_H=$(tput lines)

if [[ $CUR_W -lt $REQUIRED_W || $CUR_H -lt $REQUIRED_H ]]; then
    echo "Error: Terminal is too small."
    echo "Current : ${CUR_W}x${CUR_H}"
    echo "Required: ${REQUIRED_W}x${REQUIRED_H}"
    echo
    echo "Hint: make the font smaller if you can't make the window big enough"
    exit 1
fi

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
make CC="$CC" all >/dev/null || exit 1

# cleanup temporary files
#
cleanup() {
    rm -f digit0.out digit1.out digit2.out digit3.out digit4.out digit5.out colon.out
}
trap 'cleanup; exit 0' EXIT HUP INT QUIT TERM
cleanup

# generate the colon
#
./prog ':' < colon.txt > colon.out

export BLINK_ON="true"
export PREV_CLOCK_24H=""
export CLOCK_24H=""
clear
export CYCLES=0
while : ; do

    # go home on the screen
    #
    echo '[H';

    # find a new time of day
    #
    # If we arrived here a bit early, such that the 24 hour clock time is the same,
    # wait a small amount and try again until the 24 hour clock time has changed.
    #
    CLOCK_24H=$(date +%H%M%S)
    while [[ $CLOCK_24H == "$PREV_CLOCK_24H" ]]; do
	sleep 0.02
	CLOCK_24H=$(date +%H%M%S)
    done

    # fire up the appropriate Nixie tube grids
    #
    for j in $(seq 0 5); do
	./prog "${CLOCK_24H:$j:1}" < prog.alt.c > "digit$j.out"
    done

    # display the time, blinking the colons every other second
    #
    if [[ -n $BLINK_ON ]]; then
	paste -d '' digit0.out digit1.out colon.out digit2.out digit3.out colon.out digit4.out digit5.out
	BLINK_ON=""
    else
	paste -d '' digit0.out digit1.out spaces.txt digit2.out digit3.out spaces.txt digit4.out digit5.out
	BLINK_ON="true"
    fi

    # wait a bit
    #
    # We don't wait 1 second as this can cause us to skip a time.
    # As a nice hack, we wait a bit short of 1 second and let
    # the "find a new time of day" deal with arriving to early.
    #
    PREV_CLOCK_24H="$CLOCK_24H"
    sleep 0.91

    # exit if we exceed a cycle limit
    #
    ((CYCLES = CYCLES + 1))
    if [[ -n $CYCLE_LIMIT ]]; then
	if [[ $CYCLES -ge $CYCLE_LIMIT ]]; then
	    break
	fi
    fi
done

# All Done!!! -- Jessica Noll, Age 2
#
exit 0
