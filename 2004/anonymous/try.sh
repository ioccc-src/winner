#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2001/anonymous
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

# see if we have convert(1) 
#
CONVERT="$(type -P convert)"

echo "$ ./anonymous "ash nazg durhbatuluhk, ash nazg gimbatul, \
    ash nazg thrakatuluhk, agh burzhumh-ishi krimpatul." >ring.pgm" 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./anonymous "ash nazg durhbatuluhk, ash nazg gimbatul, \
    ash nazg thrakatuluhk, agh burzhumh-ishi krimpatul." >ring.pgm

if [[ -n "$CONVERT" ]]; then
    "$CONVERT" ring.pgm ring.jpg
    echo "Now open ring.jpg in a graphics viewer, editor or web browser." 1>&2
    echo "If you don't recognise it you should read The Lord of the Rings" 1>&2
    echo "immediately. Don't worry! It's not that long. It's only 1031 pages," 1>&2
    echo "my Precious, yes. :-)" 1>&2
else
    echo "Now open ring.pgm in a graphics viewer capable of reading Netpbm graphics." 1>&2
    echo "Alternatively, install ImageMagick and try running this script again." 1>&2
    echo "Once you've done so, if you don't recognise this image, you should read The" 1>&2
    echo "Lord of the Rings immediately. Don't worry! It's not that long. It's only 1031" 1>&2
    echo "pages, my Precious, yes. :-)" 1>&2
fi
echo 1>&2

read -r -n 1 -p "Press any key to run: ./anonymous \"My Precious. Yes, my Precious.\" > precious.pgm: "
echo 1>&2
./anonymous "My Precious. Yes, my Precious." > precious.pgm

if [[ -n "$CONVERT" ]]; then
    "$CONVERT" precious.pgm precious.jpg
    echo "Now open precious.jpg in a graphics viewer, editor or web browser." 1>&2
else
    echo "Now open precious.pgm in a graphics viewer capable of reading Netpbm graphics." 1>&2
    echo "Alternatively, install ImageMagick and try running this script again." 1>&2
fi
