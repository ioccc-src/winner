#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2019/giles
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

# find out if SoX is installed
PLAY="$(type -P play)"

if [[ -n "$PLAY" ]]; then
    read -r -n 1 -p "Press any key to run: $PLAY MonodyVocals.wav: "
    echo 1>&2
    "$PLAY" MonodyVocals.wav
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./prog MonodyVocals.wav: "
    echo 1>&2
    ./prog MonodyVocals.wav
    echo 1>&2

    read -r -n 1 -p "Press any key to run: $PLAY MonodyVocals.wav: "
    echo 1>&2
    "$PLAY" MonodyVocals.wav
    echo 1>&2
else
    echo "play(1) from SoX not installed." 1>&2
    echo "NOTE: see https://github.com/ioccc-src/temp-test-ioccc/blob/master/faq.md#sox." 1>&2
fi

