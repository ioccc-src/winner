#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1988/dale
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
# We need * and do not care about dashes
#
# SC2035 (info): Use ./*glob* or -- *glob* so names with dashes won't become options.
# https://www.shellcheck.net/wiki/SC2035
# shellcheck disable=SC2035
./dale these files are in this directory: *
echo 1>&2

echo "For the next two commands, ask yourself what they do and why they do it." 1>&2
echo "Why do they differ in the format from the above command? Finally how can you" 1>&2
echo "get the more likely desired behaviour?" 1>&2
echo 1>&2
echo 1>&2
# This warning from ShellCheck is incorrect because we deliberately have \\n to show that
# there will be a newline printed WITH printf(1). Thus this does show correct output.
#
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2028
echo "$ ./dale \$(printf "the following files exist in this directory:\\n%s\\n" *)"
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
# We do not care about word splitting in this case.
#
# SC2046 (warning): Quote this to prevent word splitting.
# https://www.shellcheck.net/wiki/SC2046
# shellcheck disable=SC2046
./dale $(printf "the following files exist in this directory:\n%s\n" *)
echo 1>&2

# This warning from ShellCheck is incorrect because we deliberately have \\n to show that
# there will be a newline printed WITH printf(1). Thus this does show correct output.
#
#SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2028
echo "$ ./dale \"\$(printf \"the following files exist in this directory:\\n%s\\n\" *)\""
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./dale "$(printf "the following files exist in this directory:\n%s\n" *)"
echo 1>&2

