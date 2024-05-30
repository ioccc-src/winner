#!/usr/bin/env bash
#
# try.sh - script to show IOCCC entry 1992/westley
#
# This script runs westley on a variety of locations to show different cities in
# the world, based on the author's remarks and the judges' remarks.
#
# This script will first try compiling the code and alternate code (alt = US only with
# higher resolution, based on the author's remarks) and then if all is OK it
# will continue.
#
# The whereami.sh and whereami.alt.sh scripts correspond to westley.c and
# westley.alt.c but they check that the number of columns is at least 80. If
# it's not at least 80 then it's an error. The scripts can be deceived by doing
# something like:
#
#   COLUMNS=100 ./whereami.sh lat long
#
# even if the number of columns is < 80 but there's nothing that can be done
# about that.
#
# If westley or westley.alt cannot compile then it is an error and the script
# will exit.
#
# If by chance westley.sh or westley.alt.sh are not executable files then it
# will try chmod +x on them and then try again. Otherwise it'll just use westley
# and westley.alt.
#
# This script knows which version, the entry or alternate code, to use based on what
# city is being shown (based on the author's remarks).
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

# get the path to the right programs
if [[ -x "whereami.sh" ]]; then
    WESTLEY="whereami.sh"
else
    chmod +x whereami.sh
    if [[ -x "whereami.sh" ]]; then
	WESTLEY="whereami.sh"
    else
	WESTLEY="westley"
    fi
fi

if [[ -x "whereami.alt.sh" ]]; then
    WESTLEY_ALT="whereami.alt.sh"
else
    chmod +x whereami.alt.sh
    if [[ -x "whereami.alt.sh" ]]; then
	WESTLEY_ALT="whereami.alt.sh"
    else
	WESTLEY_ALT="westley.alt"
    fi
fi

read -r -n 1 -p "Press any key to show New York (41,-74): "
echo 1>&2
./"$WESTLEY_ALT" 41 -74
echo 1>&2

read -r -n 1 -p "Press any key to show London (52,0): "
echo 1>&2
./"$WESTLEY" 52 0
echo 1>&2

read -r -n 1 -p "Press any key to show Moscow (56,38): "
echo 1>&2
./"$WESTLEY" 56 38
echo 1>&2

read -r -n 1 -p "Press any key to show New Delhi (29,77): "
echo 1>&2
./"$WESTLEY" 29 77
echo 1>&2

read -r -n 1 -p "Press any key to show Sydney (-34,151): "
echo 1>&2
./"$WESTLEY" -34 151
echo 1>&2

read -r -n 1 -p "Press any key to show Los Angeles (34,-118): "
echo 1>&2
./"$WESTLEY_ALT" 34 -118
echo 1>&2

read -r -n 1 -p "Press any key to show Paris (45,2): "
echo 1>&2
./"$WESTLEY" 45 2
echo 1>&2

read -r -n 1 -p "Press any key to show Rio de Janeiro (-23,-43): "
echo 1>&2
./"$WESTLEY" -23 -43
echo 1>&2

read -r -n 1 -p "Press any key to show Beijing (40,116): "
echo 1>&2
./"$WESTLEY" 40 116
echo 1>&2

read -r -n 1 -p "Press any key to show Tokyo (36,140): "
echo 1>&2
./"$WESTLEY" 36 140
echo 1>&2

read -r -n 1 -p "Press any key to show approximate judging location (37,-122): "
echo 1>&2
./"$WESTLEY_ALT" 37 -122
