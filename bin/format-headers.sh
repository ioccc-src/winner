#!/usr/bin/env bash
#
# format-headers.sh - format select headers and preceding empty lines in entry README.md files
#
# We formats headers in README.md files so that before a line that starts with
# '##' (as in '^##') that have specific names there are two blank lines (\n\n).
#
# Script written by Landon with minor improvements by Cody Boone Ferguson where
# now it only acts on files under git control rather than any README.md file in
# the [0-9]{4} directories.
#
# Copyright (c) 2023-2024 by Landon Curt Noll.  All Rights Reserved.
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

for i in $(git ls-files '[0-9][0-9][0-9][0-9]/*README.md'); do
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(To build):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Bugs and \(Mis\)features):?\n\n*([^\n])?/$1\n\n### $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(To use):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Try):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Original code):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Original build):?\n\n*([^\n])?/$1\n\n### $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Original try):?\n\n*([^\n])?/$1\n\n### $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Original use):?\n\n*([^\n])?/$1\n\n### $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Alternate code):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Alternate build):?\n\n*([^\n])?/$1\n\n### $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Alternate try):?\n\n*([^\n])?/$1\n\n### $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Alternate use):?\n\n*([^\n])?/$1\n\n### $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Judges. remarks):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Author.s remarks):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Authors. remarks):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Copyright and CC BY-SA 4.0 License):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
done
