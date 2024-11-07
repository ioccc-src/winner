#!/usr/bin/env sed
#
# html.sed - translate certain characters to HTML & entities
#
# This script was written in 2024 November by:
#
#	@xexyl
#	https://xexyl.net		Cody Boone Ferguson
#	https://ioccc.xexyl.net
#
# "Because sometimes even the IOCCC Judges need some help." :-)
#
# This script will take certain characters, for instance '<', and convert them
# to their respective HTML entity, for instance '&lt;', so that HTML lints do
# not complain.
#
# For a list of the other HTML entities, should others be needed, see:
#
#       https://www.webnots.com/using-symbols-and-special-characters-in-html/
#
# usage:
#
#	cmd | sed -f bin/html.sed
#
#	sed -f bin/html.sed file > output
#
#	sed -i -f bin/html.sed file
#
# VERSION="1.1 2024-11-07"

# IMPORTANT NOTE: the '&amp;' substitution MUST come first! This is because the
# other substitutions have '&'s in them and if the '&amp;' came after it would
# corrupt the '&'s in the string.
s/&/\\\&amp;/g
s/</\\\&lt;/g
s/>/\\\&gt;/g
s/|/\\\&verbar;/g
s/=/\\\&equals;/g
s/%/\\\&percnt;/g
