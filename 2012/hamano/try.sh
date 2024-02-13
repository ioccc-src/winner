#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/hamano
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

# delete hint.pdf
rm -f hint.pdf

echo "Will obfuscate README.md like:" 1>&2
echo 1>&2
echo "    ./hamano < README.md > hint.pdf" 1>&2
echo 1>&2
echo "and then compile it as C like:" 1>&2
echo 1>&2
echo "    ${CC} -xc hint.pdf -o hint" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: make hint: "
echo 1>&2
make hint
echo 1>&2
echo "Now try opening hint.pdf in a pdf viewer before proceeding." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./hint (space = next page, q = quit): "
echo 1>&2
./hint | less -rEXFK
echo 1>&2

echo "Will obfuscate the following code: " 1>&2
echo 1>&2
echo "    int main(){puts("Hello World!");}"
echo 1>&2
echo "writing it to hello.pdf via:" 1>&2
echo 1>&2
echo "     echo 'int main(){puts("Hello World!");}' | ./hamano > hello.pdf"
echo 1>&2
echo "and then execute the following commands:" 1>&2
echo 1>&2
echo "    ${CC} -xc hello.pdf -o hello" 1>&2
echo "    ./hello | ${CC} -xc - -o hello2" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: make hello: "
echo 1>&2
make hello
echo 1>&2
echo "Now open hello.pdf in a pdf viewer to see the obfuscated source." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./hello2: "
echo 1>&2
./hello2
