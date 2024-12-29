#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2018/bellard
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
[[ -z "$CC" ]] && CC="cc"

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

# find out if we have necessary tools
PNGTOPAM="$(type -P pngtopam)"
PNMSCALE="$(type -P pnmscale)"
PNGTOPNM="$(type -P pngtopnm)"
CJPEG="$(type -P cjpeg)"

rm -f small.jpg

if [[ -n "$PNGTOPAM" && -n "$PNMSCALE" && -n "$CJPEG" ]]; then
    echo "$ $PNGTOPAM < Lenna.png | $PNMSCALE 0.25 | $CJPEG -arithmetic -dct float -quality 14 > small.jpg" 1>&2
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    "$PNGTOPAM" < Lenna.png | "$PNMSCALE" 0.25 | "$CJPEG" -arithmetic -dct float -quality 14 > small.jpg
    if [[ -f small.jpg ]]; then
	echo "Now open small.jpg in your graphics viewer of choice." 1>&2
    fi
elif [[ -n "$PNGTOPNM" && -n "$PNMSCALE" && -n "$CJPEG" ]]; then
    echo "$ $PNGTOPNM < Lenna.png | $PNMSCALE 0.25 | $CJPEG -arithmetic -dct float -quality 14 > small.jpg" 1>&2
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    "$PNGTOPNM" < Lenna.png | "$PNMSCALE" 0.25 | "$CJPEG" -arithmetic -dct float -quality 14 > small.jpg
    if [[ -f small.jpg ]]; then
	echo "Now open small.jpg in your graphics viewer of choice." 1>&2
    fi
else
    if [[ -z "$PNGTOPAM" || -z "$PNGTOPNM" || "$PNMSCALE" ]]; then
	echo "Cannot find pngtopam(1) or pnmscale(1). Try installing netpbm first." 1>&2
	echo "Tip: visit: https://www.ioccc.org/faq.html#netpbm" 1>&2
	echo 1>&2
    fi
    if [[ -z "$CJPEG" ]]; then
	echo "Cannot find cjpeg. Try installing libjpeg-turbo." 1>&2
	echo "Tip: visit: https://www.ioccc.org/faq.html#libjpeg" 1>&2
	echo 1>&2
    fi
fi
