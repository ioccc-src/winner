#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2006/birken
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

birken()
{
    if [[ "$#" -ne 1 ]]; then
	echo "$0: birken() requires exactly 1 arg, got: $#" 1>&2
	return
    fi

    if [[ ! -f "$1" || ! -r "$1" ]]; then
	echo "$0: $1 not a regular readable file" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: ./birken < $1 (space = next page, q = quit): "
    echo 1>&2
    ./birken < "$1" 2>/dev/null | less -rEXFK
}

for f in adder.tofu buffer.tofu computer.tofu counter.tofu divider.tofu lfsr.tofu \
    memory.tofu multiplier.tofu multiplier2.tofu oneline.tofu shift.tofu zuse.tofu \
    zuse2.tofu; do
	
	birken "$f"
done
