#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/yang
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


echo "$ echo IOCCC 2015 | ./prog | tee output.c | less" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
echo IOCCC 2015 | ./prog | tee output.c | less -EXF
echo "$ make CC=\"${CC}\" output" 1>&2
make CC="${CC}" output 2>/dev/null
read -r -n 1 -p "Press any key to run: ./output: "
echo 1>&2
./output

echo 1>&2
echo "$ echo IOCCC 2015 | ./prog_c90 | tee output.c | less" 1>&2
read -r -n 1 -p "Press any key to show sea star (space = next page, q = quit): "
echo 1>&2
echo IOCCC 2015 | ./prog_c90 | tee output.c | less -EXF
echo "$ make CC=\"${CC}\" output" 1>&2
make CC="${CC}" output 2>/dev/null
read -r -n 1 -p "Press any key to run: ./output: "
echo 1>&2
./output

echo 1>&2
echo "$ echo IOCCC 2015 | ./prog_c99 | tee output.c | less" 1>&2
read -r -n 1 -p "Press any key to show sea star with eyes (space = next page, q = quit): "
echo 1>&2
echo IOCCC 2015 | ./prog_c99 | tee output.c | less -EXF
echo "Did you notice the 'rabbit' in there?" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ make CC=\"${CC}\" output" 1>&2
make CC="${CC}" output 2>/dev/null
read -r -n 1 -p "Press any key to run: ./output: "
echo 1>&2
./output

echo "$ echo IOCCC 2015 | ./prog_cpp98 | tee output.c | less" 1>&2
read -r -n 1 -p "Press any key to show dango (space = next page, q = quit): "
echo IOCCC 2015 | ./prog_cpp98 | tee output.c | less -EXF
echo "$ make CC=\"${CC}\" output" 1>&2
make CC="${CC}" output 2>/dev/null
read -r -n 1 -p "Press any key to run: ./output: "
echo 1>&2
./output

echo "$ echo IOCCC 2015 | ./prog_cpp11 | tee output.c | less" 1>&2
read -r -n 1 -p "Press any key to show circles/Swiss cheese (space = next page, q = quit): "
echo IOCCC 2015 | ./prog_cpp11 | tee output.c | less -EXF
echo "$ make CC=\"${CC}\" output" 1>&2
make CC="${CC}" output 2>/dev/null
read -r -n 1 -p "Press any key to run: ./output: "
echo 1>&2
./output

echo 1>&2
echo "$ echo IOCCC 2015 | ./prog_c11 | tee output.c | less" 1>&2
read -r -n 1 -p "Press any key to show no extra pattern (space = next page, q = quit): "
echo 1>&2
echo IOCCC 2015 | ./prog_c11 | tee output.c | less -EXF
echo "$ make CC=\"${CC}\" output" 1>&2
make CC="${CC}" output 2>/dev/null
read -r -n 1 -p "Press any key to run: ./output: "
echo 1>&2
./output

read -r -n 1 -p "Press enter key repeatedly to get more output (send EOF to quit): "
./prog
exit 0
