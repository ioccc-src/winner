#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2014/vik
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

# remove target files for saving them
rm -f beep.raw chocolate.raw

write_to_raw()
{
    if [[ "$#" -ne 2 ]]; then
	echo "$0: usage: write_to_raw file arg" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: echo $2 | ./prog > $1.raw: "
    echo "$2" | ./prog > "$1".raw
}

# now determine if we have mplayer(1)
MPLAYER="$(type -P mplayer)"
if [[ -n "$MPLAYER" ]]; then
    read -r -n 1 -p "Press any key to play: 'Want to hear me beep?': "
    echo 1>&2
    echo "$ echo 'Want to hear me beep?' | ./prog | mplayer -demuxer rawaudio -" 1>&2
    echo 'Want to hear me beep?' | ./prog | mplayer -demuxer rawaudio -
    echo 1>&2
    read -r -n 1 -p "Press any key to run: ./prog e < beep.raw: "
    echo 1>&2
    ./prog e < beep.raw
    echo 1>&2

    read -r -n 1 -p "Press any key to play: 'No. I want chocolate!': "
    echo 1>&2
    echo "$ echo 'No. I want chocolate!' | ./prog | mplayer -demuxer rawaudio - | tee chocolate.raw" 1>&2
    echo 'No. I want chocolate!' | ./prog | mplayer -demuxer rawaudio - | tee chocolate.raw
    read -r -n 1 -p "Press any key to run: ./prog e < chocolate.raw: "
    echo 1>&2
fi

read -r -n 1 -p "Press any key to run: echo 'Want to hear me beep?' | ./prog > beep.raw: "
echo 1>&2
echo 'Want to hear me beep?' | ./prog > beep.raw
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog e < beep.raw: "
echo 1>&2
./prog e < beep.raw
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 'No. I want chocolate!' | ./prog > chocolate.raw: "
echo 1>&2
echo 'No. I want chocolate!' | ./prog > chocolate.raw
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog e < chocolate.raw: "
echo 1>&2
./prog e < chocolate.raw
