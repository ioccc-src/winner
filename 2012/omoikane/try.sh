#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/omoikane
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

# remove temporary files before writing to them
rm -f output output.2 output.c data data.c key.c

# we need to find out if perl is installed
PERL="$(type -P perl)"

echo "$ echo \"A quick brown fox jumps over the lazy dog\" | ./nyaruko > output.c" 1>&2
echo "A quick brown fox jumps over the lazy dog" | ./nyaruko > output.c
read -r -n 1 -p "Press any key to show output.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK output.c

# perl specific stuff
if [[ -n "$PERL" && -f "$PERL" && -x "$PERL" ]]; then
    read -r -n 1 -p "Press any key to run: ${PERL} output.c > data.c: " 1>&2
    echo 1>&2
    "${PERL}" output.c > data.c
    read -r -n 1 -p "Press any key to show data.c (space = next page, q = quit): "
    echo 1>&2
    less -rEXFK data.c
    echo 1>&2
    read -r -n 1 -p "Press any key to run: cc -o data data.c: "
    echo 1>&2
    cc -o data data.c
    read -r -n 1 -p "Press any key to run: ./data: "
    echo 1>&2
    ./data
fi

read -r -n 1 -p "Press any key to run: cc -o output output.c: "
echo 1>&2
cc -o output output.c
read -r -n 1 -p "Press any key to run: ./output: "
echo 1>&2
echo "$ ./output" 1>&2
./output

read -r -n 1 -p "Press any key to run: ./nyaruko < output > output.c: "
echo 1>&2
./nyaruko < output > output.c
read -r -n 1 -p "Press any key to show output.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK output.c

read -r -n 1 -p "Press any key to run: bash output.c > key.c: "
echo 1>&2
bash output.c > key.c
echo 1>&2
read -r -n 1 -p "Press any key to run: show key.c (space = next page, q = quit): "
less -rEXFK key.c

# more perl stuff
if [[ -n "${PERL}" && -f "$PERL" && -x "$PERL" ]]; then
    read -r -n 1 -p "Press any key to run: ${PERL} output.c > data.c: "
    echo 1>&2
    "${PERL}" output.c > data.c
    read -r -n 1 -p "Press any key to show data.c (space = next page, q = quit): "
    echo 1>&2
    less -rEXFK data.c
    read -r -n 1 -p "Press any key to run: cat key.c data.c > output.c: "
    echo 1>&2
    cat key.c data.c > output.c
    read -r -n 1 -p "Press any key to show output.c (space = next page, q = quit): "
    echo 1>&2
    less -rEXFK output.c
    read -r -n 1 -p "Press any key to run: cc output.c -o output: "
    echo 1>&2
    cc output.c -o output
    read -r -n 1 -p "Press any key to run: ./output > output.2: "
    echo 1>&2
    ./output > output.2
    read -r -n 1 -p "Press any key to run: chmod +x output.2: "
    echo 1>&2
    chmod +x output.2
    read -r -n 1 -p "Press any key to run: ./output.2: "
    echo 1>&2
    ./output.2
fi
