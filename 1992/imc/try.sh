#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1992/imc
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

read -r -n 1 -p "Press any key to run: ./imc -text: "
echo 1>&2
./imc -text
echo 1>&2

echo "$ ./imc -text -size 40 40 -limit 256 -julia 0.5 -0.5"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./imc -text -size 40 40 -limit 256 -julia 0.5 -0.5 | less -rEXF

echo "$ ./imc -text -size 40 40 -limit 1024 -julia 2 -2.5"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./imc -text -size 40 40 -limit 1024 -julia 2 -2.5 | less -rEXF

echo "$ ./imc -text -size 40 40 -limit 1024 -centre 1 2 -julia 2 -2.5"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./imc -text -size 40 40 -limit 1024 -centre 1 2 -julia 2 -2.5 | less -rEXF

echo "$ ./imc -text -size 40 40 -limit 256"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./imc -text -size 40 40 -limit 256 | less -rEXF

echo "$ ./imc -text -size 40 40 -limit 1024"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./imc -text -size 40 40 -limit 1024 | less -rEXF
