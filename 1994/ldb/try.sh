#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 1994/ldb
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
    echo "$ printf \"The International Obfuscated C Code Contest\\nBest One-liner\\nby Laurion Burchall\" | ./ldb"
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    printf "The International Obfuscated C Code Contest\nBest One-liner\nby Laurion Burchall" | ./ldb | sed '/^$/d'
    echo 1>&2
}

for i in $(seq 1 5); do
    ldb_file /etc/passwd
    ldb_ioccc
    ldb_file ldb.c
    ldb_file README.md
done
