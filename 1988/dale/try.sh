#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 1988/dale
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

read -r -n 1 -p "Press any key to run: ./dale hello world: "
echo 1>&2
./dale "hello world"
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dale these files are in this directory: *: "
echo 1>&2
# SC2035 (info): Use ./*glob* or -- *glob* so names with dashes won't become options.
# shellcheck disable=SC2035
./dale these files are in this directory: *
echo 1>&2

echo "For the next two commands, ask yourself what they do and why they do it." 1>&2
echo "Why do they differ in the format from the above command? Finally how can you" 1>&2
echo "get the more likely desired behaviour?" 1>&2
echo 1>&2
echo 1>&2
echo "$ ./dale \$(printf "the following files exist in this directory:\\n%s\\n" *)"
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
# SC2046 (warning): Quote this to prevent word splitting.
# shellcheck disable=SC2046
./dale $(printf "the following files exist in this directory:\n%s\n" *)
echo 1>&2

echo "$ ./dale \"\$(printf \"the following files exist in this directory:\\n%s\\n\" *)\""
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./dale "$(printf "the following files exist in this directory:\n%s\n" *)"
echo 1>&2

