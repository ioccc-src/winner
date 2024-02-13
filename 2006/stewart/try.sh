#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2006/stewart
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

# try and find convert(1) from ImageMagick
CONVERT="$(type -P convert)"
# keep track if we converted anything
CONVERTED=""
FAILED_CONVERT=""

stewart()
{
    if [[ "$#" != 3 ]]; then
	echo "$0: stewart() expects 3 args, got: $#" 1>&2
	return
    fi

    if [[ ! -f "$3" || ! -r "$3" ]]; then
	echo "$0: file does not exist or not readable: $3" 1>&2
	return
    fi

    if [[ -f "$3.xbm" ]]; then
	rm -f "$3.xbm"
    fi

    read -r -n 1 -p "Press any key to run: ./stewart $1 $2 $3 > $3.xbm: "
    echo 1>&2
    ./stewart "$1" "$2" "$3" > "$3.xbm"
    echo 1>&2

    if [[ -n "$CONVERT" ]]; then
	read -r -n 1 -p "Press any key to run: $CONVERT $3.xbm $3.png: "
	echo 1>&2
	"$CONVERT" "$3.xbm" "$3.png"
	if [[ "$?" = 0 && -f "$3.png" ]]; then
	    echo "Converted $3.xbm to $3.png for you to view." 1>&2
	    CONVERTED="true"
	else
	    FAILED_CONVERT="true"
	fi
	echo 1>&2
    fi
}

# we only warn them once if they do not have convert
if [[ -z "$CONVERT" ]]; then
    echo "$0: convert(1) not found: you will have to find a viewer of xbm images." 1>&2
fi

stewart 400 1000000 maze
stewart 1024 1000000 gasket
stewart 1024 1500000 dragon3

read -r -p "Do you want to run this on the remaining files (Y/N)? "
echo 1>&2
if [[ "$REPLY" = "Y" || "$REPLY" = "y" ]]; then
    for f in altar box box2 box3 carpet circles cross cross2 cross3 crystal curve \
	diamonds diamonds2 dragon dragon2 fern gasket_mod gasket_mod2 ioccc \
	octagon pentagon pentagons rings rings2 spirals spirals2 spirals3 spirals4 \
	squares stars stars2 tree tree2 tree3 tree4 triangle; do

	    stewart 1024 1000000 "$f"
    done
fi

if [[ -n "$FAILED_CONVERT" ]]; then
    echo "Failed to convert one or more files to png." 1>&2
fi

if [[ -n "$CONVERTED" ]]; then
    echo "The following png files exist: "
    ls -1 ./*.png
else
    echo "The following xbm files exist: "
    ls -1 ./*.xbm
fi
