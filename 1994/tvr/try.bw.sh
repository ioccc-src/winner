#!/usr/bin/env bash
#
# try.bw.sh - demonstrate IOCCC entry 1994/tvr B&W mode
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

for mode in $(seq 0 12); do
    for size in 128 256; do
	read -r -n 1 -p "Press any key to run: ./tvr $mode $size < tvr.bw (q = quit, s = skip): "
	echo 1>&2
	if [[ "$REPLY" == "q" || "$REPLY" == "Q" ]]; then
	    exit 0
	elif [[ "$REPLY" == "s" || "$REPLY" == "S" ]]; then
	    continue
	fi
	echo 1>&2
	./tvr "$mode" "$size" < tvr.bw
	echo 1>&2
    done
done
