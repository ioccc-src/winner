#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2012/omoikane alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

# remove temporary files before writing to them
rm -f output output.2 output.c data data.c key.c

# we need to find out if perl is installed
PERL="$(type -P perl)"

echo "$ echo \"A quick brown fox jumps over the lazy dog\" | ./nyaruko.alt > output.c" 1>&2
echo "A quick brown fox jumps over the lazy dog" | ./nyaruko.alt > output.c
read -r -n 1 -p "Press any key to run: less -EX output.c (space = next page, q = quit): "
echo 1>&2
less -EX output.c

# perl specific stuff
if [[ -n "$PERL" ]]; then
    read -r -n 1 -p "Press any key to run: ${PERL} output.c > data.c: " 1>&2
    echo 1>&2
    "${PERL}" output.c > data.c
    read -r -n 1 -p "Press any key to run: less -EX data.c (space = next page, q = quit): "
    echo 1>&2
    less -EX data.c
    echo "$ cc -o data data.c" 1>&2
    cc -o data data.c
    read -r -n 1 -p "Press any key to run: ./data: "
    echo "$ ./data" 1>&2
    echo 1>&2
    ./data
fi

echo "$ cc -o output output.c" 1>&2
cc -o output output.c
read -r -n 1 -p "Press any key to run: ./output: "
echo 1>&2
echo "$ ./output" 1>&2
./output

read -r -n 1 -p "Press any key to run: ./nyaruko.alt < output > output.c: "
echo 1>&2
./nyaruko.alt < output > output.c
read -r -n 1 -p "Press any key to run: less -EX output.c (space = next page, q = quit): "
echo 1>&2
less -EX output.c

read -r -n 1 -p "Press any key to run: bash output.c > key.c: "
bash output.c > key.c
echo 1>&2
read -r -n 1 -p "Press any key to run: less -EX key.c (space = next page, q = quit): "
less -EX key.c

# more perl stuff
if [[ -n "${PERL}" ]]; then
    read -r -n 1 -p "Press any key to run: ${PERL} output.c > data.c: "
    echo 1>&2
    "${PERL}" output.c > data.c
    read -r -n 1 -p "Press any key to run: less -EX data.c (space = next page, q = quit): "
    echo 1>&2
    less -EX data.c
    read -r -n 1 -p "Press any key to run: cat key.c data.c > output.c: "
    echo 1>&2
    cat key.c data.c > output.c
    read -r -n 1 -p "Press any key to run: less -EX output.c (space = next page, q = quit): "
    echo 1>&2
    less -EX output.c
    echo "$ cc output.c -o output" 1>&2
    cc output.c -o output
    read -r -n 1 -p "Press any key to run: ./output > output.2: "
    echo 1>&2
    ./output > output.2
    echo "$ chmod +x output.2" 1>&2
    chmod +x output.2
    read -r -n 1 -p "Press any key to run: ./output.2: "
    ./output.2
fi
