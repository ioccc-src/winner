#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2011/hou
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
[[ -z "$CC" ]] && CC="cc"

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: grep #define calculator hou.c|cut -f3 -d' ': "
echo 1>&2
grep '#define calculator' hou.c|cut -f3 -d' '
echo 1>&2
read -r -n 1 -p "Press any key to run: grep '11/26+222/31' hou.c: "
echo 1>&2
grep '11/26+222/31' hou.c
echo 1>&2
read -r -n 1 -p "Press any key to run: ./hou '11/26+222/31': "
echo 1>&2
./hou '11/26+222/31'
echo 1>&2
echo "What relation does the equation in the code have to do with the above" 1>&2
echo "command?" 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hou 'log((21701-19937)-(23209-21701))/log(2)': "
echo 1>&2
./hou 'log((21701-19937)-(23209-21701))/log(2)'
echo 1>&2

echo "$ ./hou 'sin(1.5708)+0.04321+log(sqrt(exp(1*1*1)))+(1+2*3)-0.4-0.6+(4+6)*(2-1+2*3)-tan(0.785398)+2*10/3*6*sqrt(16/2/2)*10+10000-1000'" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./hou 'sin(1.5708)+0.04321+log(sqrt(exp(1*1*1)))+(1+2*3)-0.4-0.6+(4+6)*(2-1+2*3)-tan(0.785398)+2*10/3*6*sqrt(16/2/2)*10+10000-1000'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hou '1+2*3': "
echo 1>&2
./hou '1+2*3'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hou '(1+2)*3': "
echo 1>&2
./hou '(1+2)*3'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hou 'a calculator expression -- see the C Code for details': "
echo 1>&2
./hou 'a calculator expression -- see the C Code for details'
echo "Now answer: what does the last one mean? Can you get it to report" 1>&2
echo "something else?" 1>&2
