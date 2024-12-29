#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 2006/monge alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear


read -r -n 1 -p "Press any key to run: ./monge.alt \"z = 0\" \"z = z*z*z + c; Abs2(z) < 4\": "
echo 1>&2
./monge.alt "z = 0" "z = z*z*z + c; Abs2(z) < 4"
echo 1>&2

read -r -n 1 -p "Press any key to change the width/height/iterations to 500/500/1024: "
echo 1>&2
make clobber WIDTH=500 HEIGHT=500 ITERATIONS=1024 alt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./monge.alt \"z = 0\" \"z = z*z*z + c; Abs2(z) < 4\": "
echo 1>&2
./monge.alt "z = 0" "z = z*z*z + c; Abs2(z) < 4"
echo 1>&2
