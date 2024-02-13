#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2014/maffiodo2
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

echo "$ ./prog '  .,:;!$#@' < image.rgb" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog '  .,:;!$#@' < image.rgb | less -rEXFK
echo 1>&2

echo "$ ./prog \"  .:;Y0\" < image.rgb" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog "  .:;Y0" < image.rgb | less -rEXFK

echo "$ ./prog ' :1' < image.rgb" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog ' :1' < image.rgb | less -rEXFK

echo "$ ./prog '  .:;Y0' < image.rgb" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog '  .:;Y0' < image.rgb | less -rEXFK

echo "$ ./prog ' .:-=+*#%@' < image.rgb" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog ' .:-=+*#%@' < image.rgb | less -rEXFK

echo "$ ./prog '   .,:!-iots&8%#@$' < image.rgb" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog '   .,:!-iots&8%#@$' < image.rgb | less -rEXFK
