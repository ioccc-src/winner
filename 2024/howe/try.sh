#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/howe

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

MAKE=$(which gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

read -r -n 1 -p "Press any key to form foo: "
echo 1>&2
rm -f foo
cp prog.c foo
echo 1>&2

echo 'NOTE: To update file, press W' 1>&2
echo 'NOTE: To exit, press Q or press CTRL+C' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./eh foo "
echo 1>&2
./eh foo
echo 1>&2
