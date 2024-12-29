#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2013/cable2
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

read -r -n 1 -p "Press any key for OCR example that shows all 94 ASCII chars: "
echo 1>&2
echo "$ ./cable2 ascii.bmp" 1>&2
./cable2 ascii.bmp
echo 1>&2

read -r -n 1 -p "Press any key for OCR example with ASCII colours: "
echo 1>&2
echo "$ ./cable2 multi_color.bmp color" 1>&2
./cable2 multi_color.bmp color
echo 1>&2

read -r -n 1 -p "Press any key for OCR example of different character size/positions: "
echo 1>&2
echo "$ ./cable2 mixed_sizes.bmp" 1>&2
./cable2 mixed_sizes.bmp
echo 1>&2

read -r -n 1 -p "Press any key to extract and compile C code by OCR: "
echo 1>&2
echo "$ ./cable2 hello_world.bmp | gcc -xc -o hello -" 1>&2
./cable2 hello_world.bmp | gcc -xc -o hello -
read -r -n 1 -p "Press any key to run: ./hello: "
echo 1>&2
./hello
echo 1>&2

echo "Sometimes typeset text will work if the typeset has characters that are" 1>&2
echo "enough to support the handwritten shapes." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./cable2 typeset.bmp: "
echo 1>&2
./cable2 typeset.bmp
echo 1>&2

read -r -n 1 -p "Press any key for an added IOCCC bonus: "
echo 1>&2
echo "$ ./cable2 bonus.bmp" 1>&2
./cable2 bonus.bmp
