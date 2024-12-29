#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2000/bmeyer
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

# We need to have the column count for later on. It is not an error if it cannot
# be determined: we just use a default value.
#
# try getting the columns the simple way first: tput cols
if  COLUMNS="$(tput cols)"; then
    # if tput failed for any reason try stty(1) with cut(1).
    COLUMNS="$(stty size|cut -f2 -d' ')"

    # if however either stty size or cut fails, set to 150.
    if [[ "${PIPESTATUS[0]}" -ne 0 || "${PIPESTATUS[1]}" -ne 0 ]]; then
	COLUMNS=150
    fi
fi

echo "Warning: if you don't have white text on a black background the output" 1>&2
echo "might not be as correct or visually appealing." 1>&2
echo 1>&2

if [[ "$COLUMNS" -lt 81 ]]; then
    echo "Warning: your terminal is < 81 columns and this might cause output" 1>&2
    echo "issues." 1>&2
    echo 1>&2
fi


read -r -n 1 -p "Press any key to run: ./glicbawls < michael.pgm > michael.glic: "
echo 1>&2
./glicbawls < michael.pgm > michael.glic
echo "Now compare the michael.pgm to the screen output." 1>&2
echo 1>&2

echo "$ ./glicbawls < michael.pgm 2>/dev/null | ./glicbawls > new.pgm" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./glicbawls < michael.pgm 2>/dev/null | ./glicbawls > new.pgm
echo 1>&2

echo "Now compare the michael.pgm to the screen output." 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "Now compare the new.pgm file to the michael.pgm file."

read -r -n 1 -p "Press any key to continue: "
echo 1>&2

read -r -n 1 -p "Press any key to try and use your screen width on lava bus pic: "
echo 1>&2

read -r -n 1 -p "Press any key to run: ./glicbawls $COLUMNS < lavabus.pgm > lavabus.glic: "
echo 1>&2
./glicbawls "$COLUMNS" < lavabus.pgm > lavabus.glic
echo 1>&2

read -r -n 1 -p "Press any key to run: ./glicbawls -2 $COLUMNS < lavabus.pgm > lavabus.glic2: "
echo 1>&2
./glicbawls -2 "$COLUMNS" < lavabus.pgm > lavabus.glic2
echo 1>&2

read -r -n 1 -p "Press any key to decompress the smaller glic-file: "
echo 1>&2
echo "$ ./glicbawls -2 150 < lavabus.glic2 > new.pgm" 1>&2
./glicbawls -2 150 < lavabus.glic2 > new.pgm

echo "Now compare the new.pgm file to the lavabus.pgm file." 1>&2
