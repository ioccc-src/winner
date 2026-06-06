#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/endoh1

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

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

# show the source
#
read -r -n 1 -p "Press any key to view prog.c: " 1>&2
echo 1>&2
echo 1>&2
cat prog.c
echo 1>&2

# try the program
#
read -r -n 1 -p "Press any key to run: ./prog code < prog.c: "
echo 1>&2
echo 1>&2
./prog code < prog.c
echo 1>&2

# show digits
#
echo 'Now to show the Nixie digits.' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./digits.sh: "
echo 1>&2
echo 1>&2
./digits.sh
echo 1>&2

# show the clock for 10 seconds
#
echo 1>&2
read -r -n 1 -p "Press any key to run the clock for 10 seconds: ./clock.sh 10: "
echo 1>&2
echo 1>&2
./clock.sh 10
echo 1>&2
