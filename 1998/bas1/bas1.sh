#!/usr/bin/env bash
# 
# bas1.sh - run IOCCC entry 1998/bas1
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

echo "** Bemazing Modes **

(0) Use lpr (if lpr(1) can print PostScript)
(1) Use X11 (with gv(1))
(2) Use X11 (with gs(1) and xv(1))
"

read -rp "Make a selection (0 - 2 or any other key to exit): " mode
echo 1>&2

case "${mode}" in
    0)  ./bemazing | gunzip | lpr
	;;
    1)  ./bemazing | gunzip | gv -
	;;
    2)  ./bemazing | gunzip | gs -sDEVICE=pgmraw -sOutputFile='|xv -' -
	;;
    *)  exit 0
esac
