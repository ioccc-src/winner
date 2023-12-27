#!/usr/bin/env bash
#
# format-headers.sh - script that formats headers in README.md files so that
# before a line that starts with '##' (as in '^##') that have specific names
# there are two blank lines (\n\n).
#
# Script written by Landon with minor improvements by Cody Boone Ferguson where
# now it only acts on files under git control rather than any README.md file in
# the [0-9]{4} directories.
#

for i in $(git ls-files '[0-9][0-9][0-9][0-9]/*README.md'); do
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(To build):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Bugs and \(Mis\)features):?\n\n*([^\n])?/$1\n\n### $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(To use):?\n\n*([^\n])?/$1\n\n## $2:\n\n$3/' "$i"
    perl -0777 -p -i -e 's/([^\n]\n)\n*##*[[:space:]]*(Try):?\n\n*([^\n])?/$1\n\n### $2:\n\n$3/' "$i"
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
