#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1992/ant alt code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "$ ./ant.alt Makefile am.alt    # build the tool itself" 1>&2
read -r -n 1 -p "Press any key to run: ./ant Makefile am: "
echo 1>&2
./ant.alt Makefile am.alt
echo 1>&2



echo "$ ./am.alt Makefile am_clobber    # clobber everything except am" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./am.alt Makefile am_clobber	# clobber everything except am
echo 1>&2

echo "$ ./am.alt ant.test.alt.mk    # run the test Makefile with am" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./am.alt ant.test.alt.mk		# run the test Makefile with am.alt
