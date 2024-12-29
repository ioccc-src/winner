#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 2000/tomx alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: rm -v -f mkentry: "
echo 1>&2
rm -v -f mkentry
echo 1>&2

read -r -n 1 -p "Press any key to run: chmod +x tomx.alt.c: "
echo 1>&2
chmod +x tomx.alt.c
echo 1>&2

echo "Using tomx.alt.c as an executable to compile mkentry.c directly:" 1>&2
read -r -n 1 -p "Press any key to run: ./tomx.alt.c: "
echo 1>&2
./tomx.alt.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./mkentry -h | tee mkentry.help.txt: "
echo 1>&2
./mkentry | tee mkentry.help.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: rm -v -f mkentry: "
echo 1>&2
rm -v -f mkentry
echo 1>&2

echo "Using tomx.alt.c as a Makefile to compile mkentry.c:" 1>&2
read -r -n 1 -p "Press any key to run: make -f tomx.alt.c: "
echo 1>&2
make -f tomx.alt.c
echo 1>&2

echo 1>&2
read -r -n 1 -p "Press any key to run: ./tomx.alt (mkentry compiled from tomx.alt.c): "
echo 1>&2
./tomx.alt | tee tomx.help.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: diff -s mkentry.help.txt tomx.help.txt: "
echo 1>&2
diff -s mkentry.help.txt tomx.help.txt
echo 1>&2

read -r -n 1 -p "Press any key to remove mkentry.help.txt and tomx.help.txt: "
echo 1>&2
rm -v -f mkentry.help.txt tomx.help.txt
