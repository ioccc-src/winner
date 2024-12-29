#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2006/grothe
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

resume()
{
    echo 1>&2
    read -r -n 1 -p "Do you wish to continue (Y/N)? "
    if [[ "$REPLY" != "y" && "$REPLY" != "Y" ]]; then
	exit 0
    fi
}

read -r -n 1 -p "Press any key to run: ./grothe 65000000 10000000 1344 < twinkle.txt: "
echo 1>&2
./grothe 65000000 10000000 1344 < twinkle.txt
resume
echo 1>&2

read -r -n 1 -p "Press any key to run: ./grothe 65000000 10000000 1344 < arabian.txt: "
echo 1>&2
./grothe 65000000 10000000 1344 < arabian.txt
resume
echo 1>&2

read -r -n 1 -p "Press any key to run: ./grothe 65000000 10000000 1344 < olympics.txt: "
echo 1>&2
./grothe 65000000 10000000 1344 < olympics.txt
resume
echo 1>&2

read -r -n 1 -p "Press any key to run: ./grothe 65000000 10000000 1344 < test.txt: "
echo 1>&2
./grothe 65000000 10000000 1344 < test.txt
echo 1>&2
