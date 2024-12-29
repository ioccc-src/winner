#!/usr/bin/env bash
#
# format-headers.sh - format select headers and preceding empty lines in entry README.md files
#
# We formats headers in README.md files so that before a line that starts with
# '##' (as in '^##') that have specific names there are two blank lines (\n\n).
#
# This script was written sometime in 2023 or 2024 by:
#
#	@xexyl
#	https://xexyl.net		Cody Boone Ferguson
#	https://ioccc.xexyl.net
#
# which uses Perl code by Landon Curt Noll, with the improvement that instead of
# acting on all README.md files, it only acts on README.md files under git
# control.
#
# "Because sometimes even the IOCCC Judges need some help." :-)
#
# The Perl code makes sure that for certain headers in the README.md files,
# there are the correct number of blank lines before/after.
#
#
# Share and enjoy! :-)


# modify well known markdown headers that are not in canonical form
#
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
