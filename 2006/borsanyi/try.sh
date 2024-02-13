#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2006/borsanyi
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "When using this script, ask yourself what happens if you put a string > 42" 1>&2
echo "characters long and what happens if you input characters not in the regexp:" 1>&2
echo "'a-z_A-Z0-9@.-'." 1>&2
echo 1>&2

while :; do
    read -r -p "Enter a target file name: " filename
    if [[ -n "$filename" ]]; then
	if [[ -f "$filename" ]]; then
	    echo "$0: ERROR: $filename already exists, will not overwrite." 1>&2
	    continue
	fi
    else
	echo "$0: ERROR: empty file name, try again." 1>&2
	continue
    fi
    read -r -p "Enter a string to write to the file: " email
    if [[ -n "$email" ]]; then
	./borsanyi "$email" > "$filename"
	if [[ -f "$filename" ]]; then
	    echo "Wrote image to $filename" 1>&2
	else
	    echo "$0: ERROR: failed to write to $filename" 1>&2
	fi
    fi
    read -r -n 1 -p "Do you wish to make another one (Y/N)? "
    echo 1>&2
    if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
	break
    fi
    echo 1>&2
done
