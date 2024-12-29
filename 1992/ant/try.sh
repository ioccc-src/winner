#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1992/ant
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make clobber CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "$ ./ant Makefile am    # build the tool itself" 1>&2
read -r -n 1 -p "Press any key to run: ./ant Makefile am: "
echo 1>&2
./ant Makefile am
echo 1>&2

echo "$ ./am Makefile am_clobber    # clobber everything except am" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./am Makefile am_clobber	# clobber everything except am
echo 1>&2

echo "$ ./am ant.test.mk    # run the test Makefile with am" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./am ant.test.mk		# run the test Makefile with am
