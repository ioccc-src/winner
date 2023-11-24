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
./birken < adder.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < buffer.tofu 2>/dev/null: "
./birken < buffer.tofu 2>/dev/null
echo 1>&2

echo "NOTE: the next one has longer output." 1>&2
read -r -n 1 -p "Press any key to run: ./birken < computer.tofu 2>/dev/null: "
./birken < computer.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < counter.tofu 2>/dev/null: "
./birken < counter.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < divider.tofu 2>/dev/null: "
./birken < divider.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < lfsr.tofu 2>/dev/null: "
./birken < lfsr.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < memory.tofu 2>/dev/null: "
./birken < memory.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < multiplier.tofu 2>/dev/null: "
./birken < multiplier.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < multiplier2.tofu 2>/dev/null: "
./birken < multiplier2.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < oneline.tofu 2>/dev/null: "
./birken < oneline.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < shift.tofu 2>/dev/null: "
./birken < shift.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < zuse.tofu 2>/dev/null: "
./birken < zuse.tofu 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: ./birken < zuse2.tofu 2>/dev/null: "
./birken < zuse2.tofu 2>/dev/null
