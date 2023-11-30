#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2012/hamano
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

read -r -n 1 -p "Press any key to obfuscate README.md, writing to hint.pdf: "
echo 1>&2
echo "$ ./hamano < README.md > hint.pdf" 1>&2
./hamano < README.md > hint.pdf

echo "Now try opening it in a pdf viewer before proceeding." 1>&2
read -r -n 1 -p "Press any key to continue: "

echo 1>&2
echo "$ ${CC} -xc hint.pdf -o hint" 1>&2
${CC} -xc hint.pdf -o hint
echo 1>&2
read -r -n 1 -p "Press any key to run: ./hint | less (space = next page, q = quit): "
./hint | less

echo 1>&2

echo "Will obfuscate the following code: " 1>&2
echo 1>&2
echo "	    int main(){puts("Hello World!");}"
echo 1>&2
echo "writing to hello.pdf" 1>&2
echo 'int main(){puts("Hello World!");}' | ./hamano > hello.pdf
echo 1>&2
echo "Now open hello.pdf in a pdf viewer before continuing." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue to deobfuscate and compile hello.pdf: "
echo 1>&2
echo "$ ${CC} -Wno-implicit-function-declaration -xc hello.pdf -o hello2" 1>&2
${CC} -Wno-implicit-function-declaration -xc hello.pdf -o hello2
echo "$ ./hello2 | ${CC} -Wno-implicit-function-declaration -xc - -o ./hello3" 1>&2
./hello2 | ${CC} -Wno-implicit-function-declaration -xc - -o ./hello3
echo "$ ./hello3" 1>&2
./hello3
