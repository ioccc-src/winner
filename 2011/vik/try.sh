#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2011/vik
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# in this case we won't fail if we can't compile the code because we can still
# run the supplementary program.
make CC="$CC" all >/dev/null

# clear screen after compilation so that only the entry is shown
clear

# fine mplayer
MPLAYER="$(type -P mplayer)"

raw2wav()
{
    if [[ "$#" != 2 ]]; then
	echo "$0: raw2wav() expects two args, got: $#" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: ./vik $1 > $2: "
    echo 1>&2
    ./vik "$1" > "$2"
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./raw2wav $1 > $2: "
    echo 1>&2
    ./raw2wav "$1" > "$2"
    echo 1>&2
    echo "Converted $1 to $2." 1>&2
    echo 1>&2
}

if [[ -n "$MPLAYER" && -f "$MPLAYER" && -x "$MPLAYER" ]]; then
    # If we have mplayer we'll try playing the sounds directly. If however it
    # fails for some reason we will run the alternate procedure, creating WAV
    # files.
    read -r -n 1 -p "Press any key to run: ./vik randowan.mod | $MPLAYER -demuxer rawaudio -: "
    echo 1>&2
    ./vik randowan.mod | mplayer -demuxer rawaudio -
    raw2wav randowan.mod randowan.wav

    read -r -n 1 -p "Press any key to run: ./vik mad_world.mod | mplayer -demuxer rawaudio -: "
    echo 1>&2
    ./vik mad_world.mod | mplayer -demuxer rawaudio -
    raw2wav mad_world.mod mad_world.wav
    echo 1>&2
else
    raw2wav randowan.mod randowan.wav
    [[ -f randowan.wav ]] && echo "Now try playing randowan.wav with a program that can play WAV files." 1>&2

    raw2wav mad_world.mod mad_world.wav
    [[ -f mad_world.wav ]] && echo "Now try playing mad_world.wav with a program that can play WAV files." 1>&2
fi
