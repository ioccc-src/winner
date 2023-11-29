#!/usr/bin/env bash
#
# test.sh - demonstrate IOCCC winner 2005/giljade test suite feature
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

# redirect stdout to 'out' so that we can run the test suite of giljade
./"$GILJADE" > out
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
elif [[ "$(grep -c '[^-]error' out.count)" -ne 0 ]]; then
    # we have to check for '[^-]error' because the CFLAGS contain '-Wno-error'
    # which would be a false positive.
    echo "FAIL: Error compiling one or more versions!" 1>&2
    echo "Try the following command to find out what problems occurred:" 1>&2
    echo 1>&2
    echo "	grep -C10 -E '[^-]error' out.count" 1>&2
    echo 1>&2
    echo "and feel free to report or fix it and make a GitHub pull request." 1>&2
    EXIT_CODE=2
else
    # all good: every version could be compiled
    echo "Found and successfully compiled all 180 versions!" 1>&2
    # set EXIT_CODE to 0 even though it should be already
    EXIT_CODE=0
fi

# delete temporary files but only if no failure

if [[ "$EXIT_CODE" = 0 ]]; then
    rm -f out out.count
fi

# exit :-)
exit "$EXIT_CODE"
