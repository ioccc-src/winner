#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2020/yang
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

# remove code we generate and compile
rm -f decoded code.c encoded.c

# we will use hexdump later if it's installed
HEXDUMP="$(type -P hexdump)"

echo "Getting usage:"
echo "$ ./prog" 1>&2
./prog
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ echo \"International Obfuscated C Code Contest 2020\" | ./prog 23209 > code.c" 1>&2
echo "International Obfuscated C Code Contest 2020" | ./prog 23209 > code.c
echo 1>&2

read -r -n 1 -p "Press any key to show code.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK code.c
echo 1>&2

# compile without a PIN
read -r -n 1 -p "Press any key to compile without a PIN ($CC code.c -o decode): "
echo 1>&2
"$CC" code.c -o decode
echo 1>&2
echo "As you can see, you must compile with -DPIN=<number>" 1>&2

# if hexdump is installed we will use hexdump on the wrong code compiled
if [[ -n "$HEXDUMP" ]]; then
    echo 1>&2
    echo "Press any key to compile with wrong PIN 555 ($CC -DPIN=555 code.c -o wrongcoded): " 1>&2
    "$CC" -DPIN=555 code.c -o wrongcoded	 # wait for it ...
    read -r -n 1 -p "Press any key to run ./wrongcoded | $HEXDUMP -C: "
    echo 1>&2
    ./wrongcoded | "$HEXDUMP" -C
else
    echo 1>&2
    echo "Press any key to compile with wrong PIN 555 ($CC -DPIN=555 code.c -o wrongcoded): " 1>&2
    "$CC" -DPIN=555 code.c -o wrongcoded	 # wait for it ...
    read -r -n 1 -p "Press any key to run ./wrongcoded: "
    echo 1>&2
    ./wrongcoded
fi

echo 1>&2
# compile with a PIN
read -r -n 1 -p "Press any key to compile with good PIN 23209 ($CC -DPIN=23209 code.c -o decoded): "
echo 1>&2
"$CC" -DPIN=23209 code.c -o decoded
read -r -n 1 -p "Press any key to run: ./decoded: "
echo 1>&2
./decoded


echo 1>&2
read -r -n 1 -p "Press any key to run: echo \"Hello, world!\" | ./prog 56789 > encoded.c: "
echo 1>&2
echo "Hello, world!" | ./prog 56789 > encoded.c
echo 1>&2

read -r -n 1 -p "Press any key to show encoded.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK encoded.c
echo 1>&2

read -r -n 1 -p "Press any key to compile with good PIN 56789 ($CC -DPIN=56789 encoded.c -o decoded): "
echo 1>&2
"$CC" -DPIN=56789 encoded.c -o decoded
echo 1>&2

read -r -n 1 -p "Press any key to run ./decoded: "
echo 1>&2
./decoded
echo 1>&2

rm -f decoded code.c encoded.c
