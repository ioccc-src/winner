#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1993/vanb
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

read -r -n 1 -p "Press any key to run: ./vanb '1+1': "
echo 1>&2
./vanb '1+1'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./vanb '4+4': "
echo 1>&2
./vanb '4+4'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./vanb '+(1777-x11)*d2': "
echo 1>&2
./vanb '+(1777-x11)*d2'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./vanb '-(1777-x11)*d2': "
echo 1>&2
./vanb '-(1777-x11)*d2'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./vanb '(1777-xfeed*xdead-xd00d+xf00d)*d2': "
echo 1>&2
./vanb '(1777-xfeed*xdead-xd00d+xf00d)*d2'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./vanb '777+777-111*111/123%155': "
echo 1>&2
./vanb '777+777-111*111/123%155'
echo 1>&2

read -r -n 1 -p "Press any key: ./vanb '777-8': "
echo 1>&2
./vanb '777-8'
echo "... what happened?" 1>&2

read -r -n 1 -p "Press any key to run: ./vanb '777*8': "
echo 1>&2
./vanb '777*8'
echo "... what happened?" 1>&2
exit 0
