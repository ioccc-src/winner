#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2020/yang
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
less -rEXF code.c
echo 1>&2

# compile without a PIN
echo "Trying to compile without a PIN:"
echo 1>&2
echo "$ cc code.c -o decode" 1>&2
cc code.c -o decode
echo 1>&2
echo "As you can see, you must compile with -DPIN=<number>" 1>&2

if [[ -n "$HEXDUMP" ]]; then
    # compile with the wrong pin if hexdump is installed
    echo 1>&2
    echo "Compiling with wrong PIN: cc -DPIN=555 code.c -o wrongcoded" 1>&2
    cc -DPIN=555 code.c -o wrongcoded	 # wait for it ...
    read -r -n 1 -p "Press any key to run wrongcoded: "
    echo 1>&2
    ./wrongcoded | "$HEXDUMP" -C
fi

read -r -n 1 -p "Press any key to compile with a good PIN: "
echo 1>&2
# compile with a PIN
echo "$ cc -DPIN=23209 code.c -o decoded" 1>&2
cc -DPIN=23209 code.c -o decoded
read -r -n 1 -p "Press any key to run: ./decoded: "
echo 1>&2
./decoded


read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ echo \"Hello, world!\" | ./prog 56789 > encoded.c" 1>&2
echo "Hello, world!" | ./prog 56789 > encoded.c
echo 1>&2

read -r -n 1 -p "Press any key to show encoded.c (space = next page, q = quit): "
echo 1>&2
less -rEXF encoded.c
echo 1>&2

read -r -n 1 -p "Press any key to compile with PIN 56789: "
echo 1>&2
echo "$ cc -DPIN=56789 encoded.c -o decoded" 1>&2
cc -DPIN=56789 encoded.c -o decoded
echo 1>&2

read -r -n 1 -p "Press any key to run decoded: "
echo 1>&2
echo "$ ./decoded" 1>&2
./decoded

rm -f decoded code.c encoded.c
