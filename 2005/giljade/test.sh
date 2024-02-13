#!/usr/bin/env bash
#
# test.sh - demonstrate IOCCC entry 2005/giljade test suite feature
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the test is shown
clear

# binary is giljade
GILJADE="giljade"

# assume we will succeed
EXIT_CODE=0

# delete temporary files first to make sure that they're clean
rm -f out out.count

# redirect stdout to 'out' (but show it to output via tee(1)) so that we can run
# the test suite of giljade.
./"$GILJADE" | tee out
echo 1>&2
echo 1>&2
# warn user that this will take a while
echo "This may take a while: please be patient:" 1>&2
# here we want to show only the lines matching the regexp '^Line' but write
# everything to out.count for checking (after running it all) for errors and how
# many versions were found.
./"$GILJADE" out 2>&1 | tee out.count | grep '^Line'

# there should be 180 lines matching the regexp '^Line'.
COUNT="$(grep -c '^Line' out.count)"

if [[ "$COUNT" != 180 ]]; then
    # if we failed to get exactly 180 versions there is a problem
    echo "FAIL: Expected 180 versions, got $COUNT" 1>&2
    EXIT_CODE=1
    if [[ "$(grep -c '[^-]error' out.count)" != 0 ]]; then
	# we have to check for '[^-]error' because the CFLAGS contain '-Wno-error'
	# which would be a false positive.
	echo "FAIL: Error compiling one or more versions!" 1>&2
	echo "Try the following command to find out what problems occurred:" 1>&2
	echo 1>&2
	echo "	grep -C 10 -E '[^-]error' out.count | less" 1>&2
	echo 1>&2
	echo "and feel free to report or fix it and then make a GitHub pull request." 1>&2
	EXIT_CODE=2
    fi
else
    # all good: every version could be compiled
    echo "Found and successfully compiled all 180 versions!" 1>&2
    # set EXIT_CODE to 0 even though it should be already
    EXIT_CODE=0
fi

# delete temporary files but only if no failure and the user doesn't want to
# look at them
if [[ "$EXIT_CODE" = 0 ]]; then
    read -r -p "Do you wish to keep the 'out' and 'out.count' files (Y/N)? "
    echo 1>&2
    if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
	rm -vf out out.count
    else
	echo "Leaving 'out' and 'out.count' for you to look at. Remove them manually" 1>&2
	echo "when you wish to or run 'make clobber' to remove them automatically." 1>&2
    fi
else
    echo "Leaving 'out' and 'out.count' for you to look at. Remove them manually" 1>&2
    echo "when you wish to or run 'make clobber' to remove them automatically." 1>&2
    echo 1>&2
fi

# exit :-)
exit "$EXIT_CODE"
