#!/usr/bin/env bash
#
# try.sh - script to show IOCCC winner 1992/westley
#
# This script runs westley on a variety of locations to show different cities in
# the world, based on the author's remarks and the judges' remarks.
#
# This script will first try compiling the code and alt code (alt = US only with
# higher resolution, based on the author's remarks) and then if all is OK it
# tries to make the whereami and whereami.alt programs. If that fails the
# programs used will be westley and westley.alt; otherwise the programs will be
# whereami and whereami.alt. One can pass CC=foo to set the compiler, defaulting
# to cc.
#
# The difference between whereami and westley is that the former first checks
# that the number of columns is at least 80. The programs whereami and
# whereami.alt can be deceived by way of doing:
#
#   COLUMNS=100 ./whereami lat long
#
# even if the number of columns is < 80 but there's nothing that can be done
# about that. This script does not have that problem, however, so it's nice to
# use for that purpose if nothing else.
#
# If westley or westley.alt cannot compile then it is an error and the script
# will exit 4, corresponding to the same code that whereami.c and whereami.alt.c
# exit with if westley.c or westley.alt.c cannot be compiled.
#
# If whereami or whereami.alt cannot compile or link, say because libcurses is
# not installed, then it is not an error as such but westley and westley.alt
# will be used instead unless of course there exists an executable of one or
# both called whereami or whereami.alt or westley.c or westley.alt.c cannot be
# compiled. It is an error in the script if either of westley.c or westley.alt.c
# cannot be compiled.
#
# This is the best way to protect against showing poor output. We can't get the
# environmental variable COLUMNS from a program or a script so it has to be done
# this way. Note that in curses the COLUMNS is called COLS.
#
# This script knows which version, the entry or alt code, to use based on what
# city is being shown.
#
# If whereami and whereami.alt can be built it is run once, ahead of time, and
# if it exits non-zero then we exit to prevent repeatedly showing the error
# message. Otherwise we will call westley or westley.alt directly.
#
# Usage: ./try.sh
#

WESTLEY=""
WESTLEY_ALT=""

# get CC
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" westley westley.alt >/dev/null || exit 4
make CC="$CC" whereami whereami.alt >/dev/null || exit 4

# get the path to the right programs
if [[ -x "whereami" ]]; then
    WESTLEY="whereami"
    CC="$CC" ./"$WESTLEY" 0 0 >/dev/null || exit 1
else
    WESTLEY="westley"
fi
if [[ -x "whereami.alt" ]]; then
    WESTLEY_ALT="whereami.alt"
    CC="$CC" ./"$WESTLEY_ALT" 0 0 >/dev/null || exit 1
else
    WESTLEY_ALT="westley.alt"
fi

echo "New York:" 1>&2
echo 1>&2
./"$WESTLEY_ALT" 41 -74
echo 1>&2

echo "London:" 1>&2
echo 1>&2
./"$WESTLEY" 52 0
echo 1>&2

echo "Moscow:" 1>&2
echo 1>&2
./"$WESTLEY" 56 38
echo 1>&2

echo "New Delhi:" 1>&2
echo 1>&2
./"$WESTLEY" 29 77
echo 1>&2

echo "Sydney:" 1>&2
echo 1>&2
./"$WESTLEY" -34 151
echo 1>&2

echo "Los Angeles:" 1>&2
echo 1>&2
./"$WESTLEY_ALT" 34 -118
echo 1>&2

echo "Paris:" 1>&2
echo 1>&2
./"$WESTLEY" 45 2
echo 1>&2

echo "Rio de Janeiro:" 1>&2
echo 1>&2
./"$WESTLEY" -23 -43
echo 1>&2

echo "Beijing:" 1>&2
echo 1>&2
./"$WESTLEY" 40 116
echo 1>&2

echo "Tokyo:" 1>&2
echo 1>&2
./"$WESTLEY" 36 140
echo 1>&2

echo "Approximate judging location:" 1>&2
echo 1>&2
./"$WESTLEY_ALT" 37 -122
