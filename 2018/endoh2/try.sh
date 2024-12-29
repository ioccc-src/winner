#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2018/endoh2
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

read -r -n 1 -p "Press any key to continue (ctrl-c/intr = skip to next step early, runs 20 seconds): "
echo 1>&2
./run.sh
echo 1>&2

read -r -n 1 -p "Press any key to run a few times: "
echo 1>&2
./prog | tee prog_next.c
make prog_next
./prog_next | tee prog_next.c
make prog_next
./prog_next | tee prog_next.c

read -r -n 1 -p "Press any key to sleep 1 sec between runs (intr/ctrl-c to stop): "
echo 1>&2
./python.sh
echo 1>&2

read -r -n 1 -p "Press any key run without sleeping (intr/ctrl-c to stop): "
echo 1>&2
./python3.sh

exit 0
