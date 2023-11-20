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

GILJADE="giljade"
EXIT_CODE=0

rm -f out out.count

./"$GILJADE" > out
./"$GILJADE" out | tee out.count | grep '^Line'
COUNT="$(grep -c '^Line' out.count)"

if [[ "$COUNT" != 180 ]]; then
    echo "FAIL: expected 180 versions, got $COUNT" 1>&2
    EXIT_CODE=1
else
    echo "Found all 180 versions!" 1>&2
fi

rm -f out out.count

exit "$EXIT_CODE"

