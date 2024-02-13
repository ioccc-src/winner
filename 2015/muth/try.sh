#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/muth
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


echo "$ make -B V=2 run" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
read -r -n 1 -p "Press any key to run: make CC=${CC} -B V=2 run (space = next page, q = quit): "
echo 1>&2
make CC="${CC}" -B V=2 run | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: strings prog | grep '(,)' (space = next page, q = quit): "
echo 1>&2
strings prog | grep '(,)' | less -EXF
echo 1>&2

for h in machine*.h; do
    for t in tape*.h; do
	echo "$ make CC=\"\${CC}\" -B MACHINE=$h TAPE=$t V=1 run" 1>&2
	read -r -n 1 -p "Press any key to continue (q to exit): "
	if [[ "$REPLY" == "q" || "$REPLY" == "Q" ]]; then
	    exit 0
	fi

	make CC="${CC}" -B MACHINE="$h" TAPE="$t" V=1 run
	echo 1>&2
    done
done

