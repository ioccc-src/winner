#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2014/sinon
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

while :; do

    cp -f prog.c run.c; ./hecate.sh; ./glock.sh; sleep 3; ./glock.sh; sleep 1; ./hecate.sh

    read -r -p "Do you want to try again (Y/N)? "
    if [[ "$REPLY" != "y" && "$REPLY" != "Y" ]]; then
	exit 0
    fi
done

