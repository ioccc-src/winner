#!/usr/bin/env bash
make clobber all || exit 1
clear
stty cbreak raw -echo min 0
if [[ -f hd.img ]]
then
    ./cable3 bios fd.img hd.img
else
    ./cable3 bios fd.img
fi
stty cooked echo
