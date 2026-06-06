#!/usr/bin/env bash

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"


# make sure the program has been built
#
MAKE=$(command -v gmake)
# I run make clobber first so that temporary image files are wiped out (this
# means that if the program fails to allocate memory due to the user having
# facebook open :-) the output image will not exist so the script will exit).
# Okay so I also do || exit 1 on the lines of ./prog but in case I missed an
# example or the judges add to it (and forget to add the '|| exit 1' because
# they're human and we all make mistakes :-) ) this will solve the problem of
# 'image file already exists' so there's something to diff.
#
# Another reason I do clobber is so that the source maps are not incorrect (in
# diff -s - though I do it via a function as -s is not mandated by the standard)
# if someone reconfigures the colours.
#
# Of course since not every run of the program is to diff the || exit 1 on the
# ./prog runs is also useful. Maybe would be nice if I could do a diff on all
# images here but I ran into the problem of max submission size so I had to not
# include another map (which was really unfortunate as it was a nice and
# different equirectangular map of our Flat Hollow Earth! - a pretty amazing
# feat I should say) and I even got rid of another image that I had done diff
# with before just to make sure I didn't have any other problems.
#
# If you don't understand this then this might help you out. On macOS 26.0.0 on
# 16 January 2026 at 13.11.24 UTC:
#
#   $ du -hc *.ppm
#   2.1M	argentina.ppm
#   2.1M	china.ppm
#   2.1M	earth.ppm
#   1.5M	earth2.ppm
#   7.7M	total
#
# and 'earth2.ppm' was not included due to hitting the limit. In other words PPM
# images are rather big. This is why I converted some to PNG. Later on though I
# got rid of some images so I could fit more in as I wanted actual maps
# (earth2.ppm which became earth.ppm and earth.ppm became noclouds.ppm as what
# was above was omitted as I found an even better image).
#
${MAKE:=make} CC="$CC" clobber all >/dev/null || exit 1

do_diff()
{
    if [[ "$#" != 2 ]]; then
        echo "$0: error: expected two args, got $#" 1>&2
        exit 1
    fi
    if diff "$1" "$2"; then
        echo "Files $1 and $2 are identical" 1>&2
        return 0
    else
        echo "Files $1 and $2 are not identical" 1>&2
        exit 1
    fi
}


./prog 40.0 117.0 earth.ppm argentina_out.ppm || exit 1
do_diff argentina.ppm argentina_out.ppm
./prog -40.0 -63.0 earth.ppm china_out.ppm || exit 1
do_diff china.ppm china_out.ppm
