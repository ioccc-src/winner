#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2018/algmyr
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

echo "$ ./prog -h | ./prog -d 1 0" 1>&2
./prog -h | ./prog -d 1 0
echo 1>&2

# Who needs cat? Answer: more people than you think.
read -r -n 1 -p "Press any key to run: ./prog prog.c | ./prog -d 1 0 (space = next page, q = quit): "
echo 1>&2
./prog prog.c | ./prog -d 1 0 | less -EXF
echo 1>&2

APLAY="$(type -P aplay)"
SOX="$(type -P sox)"

if [[ -z "$SOX" && -z "$APLAY" ]]; then
    echo "Missing both sox and aplay, cannot do this step."
elif [[ -n "$SOX" ]]; then
echo "$ echo -n ' MENE MENE TEKEL UPHARSIN ' | ./prog | \
sox -t raw -c 1 -r 44100 -L -e floating-point -b 32 \
- -n spectrogram -d 10 -X 300" 1>&2
    echo -n ' MENE MENE TEKEL UPHARSIN ' | ./prog |\
	sox -t raw -c 1 -r 44100 -L -e floating-point -b 32 - -n spectrogram -d 10 -X 300

    echo "Now open spectrogram.png in an image viewer or editor." 1>&2
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    echo "$ echo "IOCCC 2018" | ./prog | sox -t raw -c 1 -r 44100 -L -e floating-point -b 32 - ioccc.wav"
    echo "IOCCC 2018" | ./prog | sox -t raw -c 1 -r 44100 -L -e floating-point -b 32 - ioccc.wav
    echo "Now listen to ioccc.wav." 1>&2

else
echo '<<<<<<  /\_/\_/\  _-_-_-_  !!!!!  :.:.:.:  >>>>>> ****** ~~~~~~~' |
./prog | aplay -c1 -fFLOAT_LE -r44100
    echo '<<<<<<  /\_/\_/\  _-_-_-_  !!!!!  :.:.:.:  >>>>>> ****** ~~~~~~~' |
	./prog | aplay -c1 -fFLOAT_LE -r44100

echo "Now open spectrogram.png in an image viewer or editor." 1>&2
fi
echo 1>&2

echo "$ echo "IOCCC 2018!" | ./prog | ./prog -d 1 0" 1>&2
echo "IOCCC 2018!" | ./prog | ./prog -d 1 0


