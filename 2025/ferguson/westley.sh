#!/usr/bin/env bash
#
# westley.sh - a homage to 1992/westley by use of the coordinates calculated
# from this submission. This is based on the try.sh script btw.

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# first fetch 1992/westley!
#
${MAKE} westley 2>/dev/null 2>&1 || exit 1

# try the program
#
SRC_LAT=40
SRC_LON=117
echo 1>&2
read -r -n 1 -p "Press any key to show coords $SRC_LAT $SRC_LON (China) on the map (from 1992/westley): "
echo 1>&2
echo 1>&2
./westley "$SRC_LAT" "$SRC_LON"
read -r -n 1 -p "Press any key to run: ./prog $SRC_LAT $SRC_LON: "
echo 1>&2
TARGET="$(./prog "$SRC_LAT" "$SRC_LON")"
echo 1>&2
echo "$TARGET"
echo 1>&2
read -r -n 1 -p "Press any key to run: ./westley $TARGET (show Argentina): "
echo 1>&2
echo 1>&2
# We need word splitting for this to work as 1992/westley requires two args, not
# one.
#
# SC2086 (info): Double quote to prevent globbing and word splitting.
# shellcheck disable=SC2086
./westley $TARGET

# now let us reverse the process
#
DST_LAT=-40
DST_LON=-63
read -r -n 1 -p "Press any key to show coords $DST_LAT $DST_LON (Argentina) on the map (from 1992/westley): "
echo 1>&2
echo 1>&2
./westley "$DST_LAT" "$DST_LON"
read -r -n 1 -p "Press any key to run: ./prog $DST_LAT $DST_LON: "
echo 1>&2
TARGET="$(./prog "$DST_LAT" "$DST_LON")"
echo 1>&2
echo "$TARGET"
echo 1>&2
read -r -n 1 -p "Press any key to run: ./westley $TARGET (show China): "
echo 1>&2
echo 1>&2
# We need word splitting for this to work as 1992/westley requires two args, not
# one.
#
# SC2086 (info): Double quote to prevent globbing and word splitting.
# shellcheck disable=SC2086
./westley $TARGET
echo 1>&2
