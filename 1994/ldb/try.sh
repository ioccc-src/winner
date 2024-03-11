#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1994/ldb
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

ldb_file()
{
    if [[ "$#" != 1 ]]; then
	echo "$0: ldb_file() expects 1 arg, got $#" 1>&2
	return
    fi
    read -r -n 1 -p "Press any key to run: ./ldb < $1: "
    echo 1>&2
    ./ldb < "$1" | sed '/^$/d'
    echo 1>&2
}

ldb_ioccc()
{
    # This warning from ShellCheck is incorrect because we deliberately have \\n to show
    # that there will be a newline printed WITH printf(1). Thus this does show correct output.
    #
    # SC2028 (info): echo may not expand escape sequences. Use printf.
    # https://www.shellcheck.net/wiki/SC2028
    # shellcheck disable=SC2028
    echo "$ printf \"The International Obfuscated C Code Contest\\nBest One-liner\\nby Laurion Burchall\" | ./ldb"
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    printf "The International Obfuscated C Code Contest\nBest One-liner\nby Laurion Burchall" | ./ldb | sed '/^$/d'
    echo 1>&2
}

# This warning from ShellCheck is irrelevant as we only use 'i' as an iterator
# to do the commands a number of times:
#
# SC2034 (warning): i appears unused. Verify use (or export if used externally).
# https://www.shellcheck.net/wiki/SC2034
# shellcheck disable=SC2034
for i in $(seq 1 5); do
    ldb_file /etc/passwd
    ldb_ioccc
    ldb_file ldb.c
    ldb_file README.md
done
