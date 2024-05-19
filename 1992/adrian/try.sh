#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1992/adrian
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# don't redirect output to /dev/null so that they can see how it's done,
# assuming it's not already built
make CC="$CC" everything || exit 1
# DON'T clear the screen so they can see how the files are generated!

for f in adrian.grep.*; do
    echo 1>&2
    read -r -n 1 -p "Press any key to show: $f: "
    echo 1>&2
    cat "$f"
    echo 1>&2
    read -r -n 1 -p "Press any key to run: ./adrian $f < README.md: "
    echo 1>&2
    ./adrian "$f" < README.md
    echo 1>&2
done

read -r -n 1 -p "Press any key to run: ./adhead try.sh: "
echo 1>&2
./adhead try.sh
echo 1>&2

read -r -n 1 -p "Press any key to run: ./adecho 1992 IOCCC adrian: "
echo 1>&2
./adecho 1992 IOCCC adrian
echo 1>&2

rm -f wc.adwc.txt adwc.adwc.txt
echo "$ wc adwc.c | sed -e 's/^[[:space:]]//g' | tr -s '[:space:]' | \\" 1>&2
echo "    cut -d' ' -f1-3 | tee wc.adwc.txt" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
wc adwc.c | sed -e 's/^[[:space:]]//g' | tr -s '[:space:]' | cut -d' ' -f1-3 | tee wc.adwc.txt
echo 1>&2

echo "$ ./adwc adwc.c|tr -s ' '|sed -e 's/^[[:space:]]//g' | tee adwc.adwc.txt" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./adwc adwc.c|tr -s ' '|sed -e 's/^[[:space:]]//g' | tee adwc.adwc.txt
echo 1>&2

read -r -n 1 -p "Press any key to show diff between wc.adwc.txt and adwc.adwc.txt: "
echo 1>&2
diff -s wc.adwc.txt adwc.adwc.txt
echo 1>&2
rm -f wc.adwc.txt adwc.adwc.txt

echo "$ ./adsleep 10" 1>&2
read -r -n 1 -p "Press any key to make your computer take a 10 second nap (./adsleep 10): "
echo 1>&2
./adsleep 10
