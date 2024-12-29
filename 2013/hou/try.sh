#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2013/hou
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

echo "2013/hou menu" 1>&2
echo 1>&2
echo "(0) BIG (luna.ppm)" 1>&2
echo "(1) old_default.scene BIG (old_default.ppm)" 1>&2
echo "(2) otherroom (otherroom.ppm)" 1>&2
echo "(3) NAIVE otherroom (otherroom.ppm)" 1>&2
echo 1>&2
read -rp "Make your selection (0 - 3, anything else to quit): " mode

case "$mode" in
    0)  # BIG
	echo "$ ./hou BIG" 1>&2
	./hou BIG
	;;
    1)  # old_default BIG
	echo "$ ./hou old_default.scene BIG" 1>&2
	./hou old_default.scene BIG
	;;
    2)  # otherroom
	echo "$ ./hou otherroom.scene" 1>&2
	./hou otherroom.scene
	;;
    3)  # otherroom NAIVE
	echo "$ ./hou otherroom.scene NAIVE" 1>&2
	./hou otherroom.scene NAIVE
	;;
    *)	exit 0	
	;;
esac
