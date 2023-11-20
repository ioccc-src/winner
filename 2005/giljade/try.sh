#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2005/giljade
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

read -r -p "Do you wish to run the test suite (y/n) ? "
if [[ "$REPLY" == "y" ]]; then
    echo "$ make test" 1>&2
    make test
fi

echo 1>&2
echo "$ ./giljade > out" 1>&2
./giljade > out
echo "For this next step, make sure to keep pressing space (or hold it down) (q = quit)." 1>&2
echo "$ less out" 1>&2
read -r -n 1 -p "Press any key to continue: "
less out

echo "We've left the file 'out' for you in case you wish to open it in vi(m). If" 1>&2
echo "you do we recommend you try holding ctrl-f down in a similar way to how you held" 1>&2
echo "down space above. Of course you can open it in another editor if you wish." 1>&2
