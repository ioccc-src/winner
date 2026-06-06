#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/tompng

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

# try the program
#
echo "This program is a relaxation sound generator." 1>&2
echo 1>&2
echo "This might take 5 - 10 seconds to complete: " 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: time ./prog : "
echo 1>&2
time ./prog
echo 1>&2
echo "5 Minutes relaxation sound has been generated into the file: sound.wav" 1>&2
echo 1>&2
echo "ls -l sound.wav" 1>&2
ls -l sound.wav 1>&2
echo 1>&2

echo "You can set TIME, SEED and FILENAME." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog 15 1 sound-15sec-seed1.wav : "
echo 1>&2
echo 1>&2
./prog 15 1 sound-15sec-seed1.wav
echo "ls -l sound.wav" 1>&2
ls -l sound-15sec-seed1.wav 1>&2

export SOX_TOOL
SOX_TOOL=$(type -P sox)
export FFPLAY_TOOL
FFPLAY_TOOL=$(type -P ffplay)
export APLAY_TOOL
APLAY_TOOL=$(type -P aplay)
if [[ -x $SOX_TOOL ]]; then
    echo 1>&2
    echo "To stop, press ^C (control-C)" 1>&2
    echo 1>&2
    read -r -n 1 -p "Press any key to play the relaxation sound with: ./prog - | sox ... : "
    echo 1>&2
    echo 1>&2
    ./prog - | "$SOX_TOOL" --buffer 1024 -t s16 -r 48000 -c 1 - -d 2>/dev/null
elif [[ -x $FFPLAY_TOOL ]]; then
    echo 1>&2
    echo "To stop, press ^C (control-C)" 1>&2
    echo 1>&2
    read -r -n 1 -p "Press any key to play the relaxation sound with: ./prog - | ffplay - : "
    echo 1>&2
    echo 1>&2
    ./prog - | "$FFPLAY_TOOL" -
elif [[ -x $APLAY_TOOL ]]; then
    echo 1>&2
    echo "To stop, press ^C (control-C)" 1>&2
    echo 1>&2
    read -r -n 1 -p "Press any key to play the relaxation sound with: ./prog - | aplay - : "
    echo 1>&2
    echo 1>&2
    ./prog - | "$APLAY_TOOL" -
else
    echo 'You need either sox, or ffplay, or aplay installed to hear the output from: ./prog -' 1>&2
fi
echo 1>&2
