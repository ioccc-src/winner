#!/usr/bin/env bash
#
# sgi.sh - sort .gitignore content from stdin to stdout
#
# We sort with lines starting with # first.
# We sort with lines starting with * second.
# We sort with lines that do not start with [#!*] third.
# We sort with lines starting with ! fourth.
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


# sort .gitignore content on stdin to stdout
#
sed -e '/^#/s/.*/0 &/' -e '/^*/s/.*/1 &/' -e '/^[^01*!]/s/.*/2 &/' -e '/^!/s/.*/3 &/' |
    LC_ALL=C sort -u -k 1n -k 2d |
    sed 's/[0123] //'
