#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2011/hou
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

read -r -n 1 -p "Observe how this one is in the code, both the equation and the answer: "
echo "$ ./hou '11/26+222/31'" 1>&2
./hou '11/26+222/31'
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo "$ ./hou 'log((21701-19937)-(23209-21701))/log(2)'" 1>&2
./hou 'log((21701-19937)-(23209-21701))/log(2)'
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo "$ ./hou 'sin(1.5708)+0.04321+log(sqrt(exp(1*1*1)))+(1+2*3)-0.4-0.6+(4+6)*(2-1+2*3)-tan(0.785398)+2*10/3*6*sqrt(16/2/2)*10+10000-1000'" 1>&2
./hou 'sin(1.5708)+0.04321+log(sqrt(exp(1*1*1)))+(1+2*3)-0.4-0.6+(4+6)*(2-1+2*3)-tan(0.785398)+2*10/3*6*sqrt(16/2/2)*10+10000-1000'
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo "$ ./hou '1+2*3'" 1>&2
./hou '1+2*3'
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo "$ ./hou '(1+2)*3'" 1>&2
./hou '(1+2)*3'
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo "$ ./hou 'a calculator expression -- see the C Code for details'" 1>&2
./hou 'a calculator expression -- see the C Code for details'
echo "Now answer: what does the last one mean? Can you get it to report something else?" 1>&2
