#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 1985/shapiro alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# run with default first
make clobber CC="$CC" alt >/dev/null || exit 1
./shapiro.alt

i=0
# while i < 5 randomly select a size and recompile it and run
while ((i < 5)); do
    # get random value in range RANDOM % 38. <=0 sets to 39 in the code but
    # since 1 is kind of pointless so we set it to 2 if it's < 2.
    C=$((RANDOM % 38))
    if [[ "$C" -lt 2 ]]; then
	C=2
    fi

    read -r -n 1 -p "Press any key to set to $C: "
    echo 1>&2
    make clobber CC="$CC" SIZE="$C" alt >/dev/null
    ./shapiro.alt
    ((i++))
done

# while input is only numbers recompile the alternate code with that value.  If number
# is <=0 it sets to 39 in the code but here if one enters a negative number it
# will exit due to the '-'. 1 is rather pointless but we don't check for
# it either.
while :; do
    read -r -p "Enter a value (any non-digit = quit): "
    GREP_REPLY=$(echo "$REPLY" | grep -E '\<[0-9]+\>')
    if [[ -z $GREP_REPLY ]]; then
	make clobber CC="$CC" SIZE="$REPLY" alt >/dev/null
	./shapiro.alt
    else
	exit 0
    fi
done
