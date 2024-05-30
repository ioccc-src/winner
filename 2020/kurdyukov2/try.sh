#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2020/kurdyukov2
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
[[ -z "$CC" || ! -f "$CC" || ! -x "$CC" ]] && CC="cc"

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

# try finding convert(1) from ImageMagick if CONVERT not passed to script or is
# not an executable file
[[ -z "$CONVERT" || ! -f "$CONVERT" || ! -x "$CONVERT" ]] && CONVERT="$(type -P convert)"

convert_error()
{
    echo 1>&2
    echo "Warning: $CONVERT failed to generate out.gif. Is $CONVERT convert(1) from ImageMagick?" 1>&2
    echo "Tip: visit: https://www.ioccc.org/faq.html#imagemagick" 1>&2
    echo 1>&2
    echo "Tip: if you have it in a different path, try: CONVERT=path ./try.sh" 1>&2
    echo 1>&2
}

# remove ppm files that we create
rm -f random.ppm output.ppm
echo "$ (echo P6 1024 1024 255; dd if=/dev/urandom bs=3M count=1) > random.ppm" 1>&2
(echo P6 1024 1024 255; dd if=/dev/urandom bs=3M count=1) > random.ppm
echo "Look at random.ppm. Do you see any patterns?" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
# Look at random.ppm. Do you see any patterns?
read -r -n 1 -p "Press any key to run: ./prog_ppm 1000 random.ppm output.ppm: "
echo 1>&2
./prog_ppm 1000 random.ppm output.ppm
echo 1>&2
echo "Now open output.ppm. What patterns has the program found?" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2

echo "$ for i in 0001 0002 0004 0008 0016 0032 0064 0128
  0256 0512 1024 2048 4096 8192 ; do ./prog $i sample.jpg out$i.jpg; done" 1>&2
for i in 0001 0002 0004 0008 0016 0032 0064 0128 0256 0512 1024 2048 4096 8192 ; do
    read -r -n 1 -p "Press any key to run: ./prog $i sample.jpg out$i.jpg: "
    echo 1>&2
    ./prog "$i" sample.jpg "out$i".jpg; done
echo "Now flip through out*.jpg and see when you start to recognise the image." 1>&2

if [[ -n "$CONVERT" ]]; then
    echo 1>&2
    read -r -n 1 -p "Press any key to create GIF: "
    echo 1>&2
    echo "$ $CONVERT -delay 10 -dither none -loop 0 $(find . -maxdepth 1 -type f -name '*jpg' | sort -V) $(find . -maxdepth 1 -type f -name '*jpg' | sort -rV) +map out.gif" 1>&2
    # We want word splitting here so disable shellcheck warning SC2046.
    #
    # SC2046 (warning): Quote this to prevent word splitting.
    # https://www.shellcheck.net/wiki/SC2046
    # shellcheck disable=SC2046
    "$CONVERT" -delay 10 -dither none -loop 0 $(find . -maxdepth 1 -type f -name '*jpg' | sort -V) $(find . -maxdepth 1 -type f -name '*jpg' | sort -rV) +map out.gif
    if [[ ! -f out.gif ]]; then
	convert_error
    else
	echo 1>&2
	echo "Now look at out.gif with a graphics viewer that can show animated GIFs." 1>&2
	echo "Warning: includes flashing colours." 1>&2
    fi

    read -r -n 1 -p "Press any key to run: ./makegif.sh sample.jpg kurdyukov2.gif ./prog: "
    echo 1>&2
    ./makegif.sh sample.jpg kurdyukov2.gif ./prog
    echo 1>&2
else
    echo 1>&2
    echo "Could not fine convert(1) from ImageMagick." 1>&2
    echo "Tip: visit: https://www.ioccc.org/faq.html#imagemagick" 1>&2
    echo 1>&2
fi
