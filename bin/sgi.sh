#!/usr/bin/env bash
#
# sgi.sh - sort .gitignore canonically from stdin to stdout
#
# We canonicalize .gitignore lines as follows:
#
# We print lines # in the order they appear, 1st.
# We dictionary sort with lines starting with * 2nd.
# We dictionary sort with lines starting with ! 3rd.
# We dictionary sort with lines starting with / 4th.
# We dictionary sort all other lines 5th.
#
# For each step past the 1st step, we remove duplicate lines.
#
# Example usage in vim with a keyboard macro <escape>f:
#
#	:map ^[f 1G!G../../bin/sgi.sh^M
#
#     or via .vimrc:
#
#	" sort the entire .gitignore file using ../../bin/sgi.sh
#	:map  ^[f 1G!G../../bin/sgi.sh^M
#
#     NOTE: The ^[ above is ((Escape)) and ^M is ((Control-M)).
#
# Example usage in shell:
#
#	rm -f t && ../../bin/sgi.sh < .gitignore > t && mv -f t .gitignore
#
# Copyright (c) 2024 by Landon Curt Noll.  All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright, this permission notice and text
# this comment, and the disclaimer below appear in all of the following:
#
#       supporting documentation
#       source copies
#       source works derived from this source
#       binaries derived from this source or from derived source
#
# LANDON CURT NOLL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO
# EVENT SHALL LANDON CURT NOLL BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
# USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
# chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# Share and enjoy! :-)


# IOCCC requires use of C locale
#
export LANG="C"
export LC_CTYPE="C"
export LC_NUMERIC="C"
export LC_TIME="C"
export LC_COLLATE="C"
export LC_MONETARY="C"
export LC_MESSAGES="C"
export LC_PAPER="C"
export LC_NAME="C"
export LC_ADDRESS="C"
export LC_TELEPHONE="C"
export LC_MEASUREMENT="C"
export LC_IDENTIFICATION="C"
export LC_ALL="C"


# load stdin into a temporary gitignore file
#
export VERSION="2.0.0 2025-03-13"
NAME=$(basename "$0")
export NAME
export TMP_GITIGNORE=".tmp.$NAME.GITIGNORE.$$.tmp"
trap 'rm -f $TMP_GITIGNORE; exit' 0 1 2 3 15
rm -f "$TMP_GITIGNORE"
if [[ -e $TMP_GITIGNORE ]]; then
    echo "$0: ERROR: cannot remove temporary gitignore file: $TMP_GITIGNORE" 1>&2
    exit 10
fi
cat > "$TMP_GITIGNORE"
if [[ ! -e $TMP_GITIGNORE ]]; then
    echo "$0: ERROR: cannot create temporary gitignore file: $TMP_GITIGNORE" 1>&2
    exit 11
fi


# step 0: print .gitignore comment lines in order
#
grep '^#' "$TMP_GITIGNORE"


# print unique lines from the following 5 steps to stdout
#
# These 5 types of .gitignore lines are printed in
# step order as part of our .gitignore canonization.
#
{
    # step 1: print * lines, sorted by dictionary
    #
    grep '^\*' "$TMP_GITIGNORE" | LC_ALL=C sort -d

    # step 2: print ! lines, sorted by dictionary
    #
    grep '^!' "$TMP_GITIGNORE" | LC_ALL=C sort -d

    # step 3: print . lines, sorted by dictionary
    #
    grep '^\.' "$TMP_GITIGNORE" | LC_ALL=C sort -d

    # step 4: print / lines, sorted by dictionary
    #
    grep '^/' "$TMP_GITIGNORE" | LC_ALL=C sort -d

    # step 5: print all other lines, sorted by dictionary
    #
    grep '^[^#*!./]' "$TMP_GITIGNORE" | LC_ALL=C sort -d
} | uniq


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
