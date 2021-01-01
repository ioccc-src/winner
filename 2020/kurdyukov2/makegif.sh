#!/bin/bash
image=${1:-"input.jpg"}
output=${2:-"output.gif"}
prog=${3:-"./prog"}
ext="${image##*.}"
dir="gif"
[ $# -lt 3 ] && [ "$ext" = "png" -o "$ext" = "ppm" ] && prog="./prog_$ext"
[ -f "$image" ] || {
	echo "Usage: makegif.sh image.jpg output.gif ./prog"
	echo "Depends: ImageMagick, bc (basic calculator)"
	echo "Note: don't use large images (dimensions above 1000), ImageMagick may fail."
	echo "Uses \"gif\" directory for temporary files."
	exit 1
}
mkdir -p "$dir"
i=8 ; x=$i ; j=0
while [ $x -le 16000 ]; do
	x="$(echo "a=$i*e(l(2)/4*$j)+0.5;scale=0;a/1" | bc -l)"
	echo "### $j : $x"
	list[j]="$dir/out$j.$ext"
	"$prog" "$x" "$image" "$dir/out$j.$ext" ; j=$((j+1))
done
i=$j ; j=$((j-2))
while [ $j -ge 1 ]; do
### Uncomment the following line if you want to make a GIF in an image editor such as GIMP
#	cp "$dir/out$j.$ext" "$dir/out$i.$ext"
	list[i]="$dir/out$j.$ext"
	i=$((i+1)) ; j=$((j-1))
done
convert -delay 10 -dither none -loop 0 "${list[@]}" +map "$output"

