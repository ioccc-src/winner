#!/usr/bin/env sed
#
# bin/html.sed - translate certain characters to HTML & entities
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
# to their respective html entity, for instance '&lt;', so that html lints do
# not complain.
#
# For a list of the other html entities, should others be needed, see:
#
#       https://www.w3schools.com/html/html_entities.asp
#
# usage:
#
#	cmd | sed -f bin/html.sed
#
#	sed -f bin/html.sed file > output
#
#	sed -i -f bin/html.sed file
#
# VERSION="1.0 2024-11-04"

# IMPORTANT NOTE: the '&amp;' substitution MUST come first! This is because the
# other substitutions have '&'s in them and if the '&amp;' came after it would
# corrupt the '&'s in the string.
s/&/\\\&amp;/g
s/</\\\&lt;/g
s/>/\\\&gt;/g
