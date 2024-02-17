#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2011/zucker
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


read -r -n 1 -p "Press any key to run: ./zucker > ioccc.ppm: "
echo 1>&2
./zucker > ioccc.ppm
echo 1>&2
echo "Now open ioccc.ppm in a graphics viewer." 1>&2

read -r -n 1 -p "Press any key to run: ./zucker \"Hello!!!\" > hello.ppm: "
echo 1>&2
./zucker "Hello\!\!\!" > hello.ppm
echo "Now open hello.ppm in a graphics viewer." 1>&2

read -r -n 1 -p "Press any key to run: ./zucker faster\! -preview > image2.ppm: "
echo 1>&2
./zucker faster\! -preview > image2.ppm
echo "Now open image2.ppm in a graphics viewer." 1>&2
echo 1>&2




