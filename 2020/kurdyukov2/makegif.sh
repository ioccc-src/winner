#!/bin/bash
image=${1:-"input.jpg"}
output=${2:-"output.gif"}
prog=${3:-"./prog"}
ext="${image##*.}"
dir="gif"
[[ $# -lt 3 ]] && [[ "$ext" = "png" || "$ext" = "ppm" ]] && prog="./prog_$ext"
[[ -f "$image" ]] || {
	echo "Usage: $0 image.jpg output.gif ./prog"
	echo "Dependencies: ImageMagick, bc (basic calculator)"
	echo "Note: don't use large images (dimensions above 1000), ImageMagick may fail."
	echo "Uses \"gif\" directory for temporary files."
	exit 1
}
# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
[[ -z "$CC" || ! -f "$CC" || ! -x "$CC" ]] && CC="cc"
make CC="$CC" all >/dev/null || exit 1

mkdir -p "$dir"

i=8 ; x=$i ; j=0
while [[ $x -le 16000 ]]; do
	x="$(echo "a=$i*e(l(2)/4*$j)+0.5;scale=0;a/1" | bc -l)"
	echo "### $j : $x"
	list[j]="$dir/out$j.$ext"
	"$prog" "$x" "$image" "$dir/out$j.$ext" ; j=$((j+1))
done
i=$j ; j=$((j-2))
while [[ $j -ge 1 ]]; do
    ### Uncomment the following line if you want to make a GIF in an image editor such as GIMP
    # cp "$dir/out$j.$ext" "$dir/out$i.$ext"

    list[i]="$dir/out$j.$ext"
    i=$((i+1)) ; j=$((j-1))
done

# try finding convert(1) from ImageMagick if CONVERT not passed to script or is
# not an executable file
convert_error()
{
    echo 1>&2
    echo "Warning: $CONVERT failed to generate out.gif. Is $CONVERT convert(1) from ImageMagick?" 1>&2
    echo "Tip: visit: https://www.ioccc.org/faq.html#imagemagick" 1>&2
    echo 1>&2
    echo "Tip: if you have it in a different path, try: CONVERT=path ./try.sh" 1>&2
    echo 1>&2
}
[[ -z "$CONVERT" || ! -f "$CONVERT" || ! -x "$CONVERT" ]] && CONVERT="$(type -P convert)"
if [[ -z "$CONVERT" || ! -f "$CONVERT" || ! -x "$CONVERT" ]]; then
    echo 1>&2
    echo "Could not fine convert(1) from ImageMagick." 1>&2
    echo "Tip: visit: https://www.ioccc.org/faq.html#imagemagick" 1>&2
    echo 1>&2
else
    "$CONVERT" -delay 10 -dither none -loop 0 "${list[@]}" +map "$output"
    if [[ ! -f "$output" ]]; then
	convert_error
    else
	echo 1>&2
	echo "Now look at $output with a graphics viewer that can show animated GIFs." 1>&2
	echo "Warning: includes flashing colours." 1>&2
	echo 1>&2
    fi
fi
