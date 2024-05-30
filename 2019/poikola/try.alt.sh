#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 2019/poikola alternate code
#
# 'I will move to Copenhagen and apply for Swedish citizenship.'
#
# -- Matti Ensio Nykänen
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make clobber CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: ./prog.alt 512 ./prog.alt (space = next page, q = quit): "
echo 1>&2
./prog.alt 512 ./prog.alt | less -rEXFK
echo 1>&2

echo "$ TZ=UTC24 make CC=$CC clobber prog.alt" 1>&2
TZ=UTC24 make CC="$CC" clobber prog.alt || exit 1
read -r -n 1 -p "Press any key to run: ./prog.alt 512 ./prog.alt (space = next page, q = quit): "
echo 1>&2
./prog.alt 512 ./prog.alt | less -rEXFK
echo 1>&2

echo "$ TZ=UTC48 make CC=$CC clobber prog.alt" 1>&2
TZ=UTC48 make CC="$CC" clobber prog.alt || exit 1
read -r -n 1 -p "Press any key to run: ./prog.alt 512 ./prog.alt: "
echo 1>&2
./prog.alt 512 ./prog.alt
echo 1>&2
