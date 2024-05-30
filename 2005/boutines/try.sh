#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2005/boutines
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

# see if the user has ruby installed
#
RUBY="$(type -P ruby)"

# see if convert(1) is available (hopefully from ImageMagick :-) )
#
CONVERT="$(type -P convert)"

if [[ -n "$RUBY" ]]; then
    echo "$ $RUBY -e '20.times{puts \"\#{rand} \#{rand}\"}' | ./boutines > test.svg" 1>&2
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    "$RUBY" -e '20.times{puts "#{rand} #{rand}"}' | ./boutines > test.svg
else
    echo "ruby not installed, skipping generation of an SVG file via ruby." 1>&2
fi

read -r -n 1 -p "Press any key to run: ./boutines < input.txt > result.svg: "
echo 1>&2
./boutines < input.txt > result.svg
echo 1>&2

if [[ ! -f result.svg && ! -f test.svg ]]; then
    echo "failed to create any SVG file, exiting." 1>&2
    exit 1
fi

if [[ -n "$CONVERT" ]]; then
    read -r -n 1 -p "Press any key to run: convert test.svg test.png: "
    echo 1>&2
    if ! convert test.svg test.png; then
	echo "Failed to convert test.svg to test.png, try a graphics viewer that" 1>&2
	echo "can view SVG files." 1>&2
    else
	echo "Now try viewing test.png with your favourite graphics viewer." 1>&2
    fi

    echo 1>&2
    read -r -n 1 -p "Press any key to run: convert result.svg result.png: "
    echo 1>&2
    if ! convert result.svg result.png; then
	echo "Failed to convert result.svg to result.png, try a graphics viewer that" 1>&2
	echo "can view SVG files." 1>&2
    else
	echo "Now try viewing result.png with your favourite graphics viewer." 1>&2
    fi
else
    echo 1>&2
    echo "convert not found (ImageMagick not installed?)" 1>&2
    echo "Try viewing *.svg with a graphics viewer that can view SVG files." 1>&2
    echo "Tip: visit: https://www.ioccc.org/faq.html#imagemagick" 1>&2
fi
