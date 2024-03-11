#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1986/stein
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

# With SC2016 shellcheck doesn't understand how to parse '"'"'.
# With SC2028 we want to output the literal \ character.
#
# SC2016 (info): Expressions don't expand in single quotes, use double quotes for that.
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2016
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2016,SC2028
echo '$ ./stein $(printf '"'"'\015\015'"'"'); echo' 1>&2
./stein "$(printf '\015\015')"; echo

# With SC2016 shellcheck doesn't understand how to parse '"'"'.
# With SC2028 we want to output the literal \ character.
#
# SC2016 (info): Expressions don't expand in single quotes, use double quotes for that.
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2016
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2016,SC2028
echo '$ ./stein $(printf '"'"'\014\015'"'"'); echo' 1>&2
./stein "$(printf '\014\015')"; echo

echo "$ ./stein" 1>&2
./stein
