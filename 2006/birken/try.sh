#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2006/birken
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

read -r -n 1 -p "Press any key to run: ./birken < adder.tofu 2>/dev/null: "
echo 1>&2
./birken < adder.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < buffer.tofu 2>/dev/null: "
echo 1>&2
./birken < buffer.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < computer.tofu 2>/dev/null (space = next page, q = quit): "
echo 1>&2
./birken < computer.tofu 2>/dev/null | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < counter.tofu 2>/dev/null: "
echo 1>&2
./birken < counter.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < divider.tofu 2>/dev/null: "
echo 1>&2
./birken < divider.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < lfsr.tofu 2>/dev/null: "
echo 1>&2
./birken < lfsr.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < memory.tofu 2>/dev/null: "
echo 1>&2
./birken < memory.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < multiplier.tofu 2>/dev/null: "
echo 1>&2
./birken < multiplier.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < multiplier2.tofu 2>/dev/null: "
echo 1>&2
./birken < multiplier2.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < oneline.tofu 2>/dev/null: "
echo 1>&2
./birken < oneline.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < shift.tofu 2>/dev/null: "
echo 1>&2
./birken < shift.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < zuse.tofu 2>/dev/null: "
echo 1>&2
./birken < zuse.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < zuse2.tofu 2>/dev/null: "
echo 1>&2
./birken < zuse2.tofu 2>/dev/null
echo 1>&2
