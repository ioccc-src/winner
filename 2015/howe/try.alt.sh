#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/howe alt code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear


read -r -n 1 -p "Press any key to run: ./prog.alt prog.alt.c prog.c: "
echo 1>&2
./prog.alt prog.alt.c prog.c
echo 1>&2

read -r -n 1 -p "Press any key to run: make test (space = next page, q = quit): "
echo 1>&2
make test | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog.alt -d ABXYEFCD.tmp ACDBECFD.tmp: "
echo 1>&2
./prog.alt -d ABXYEFCD.tmp ACDBECFD.tmp
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog.alt ABXYEFCD.tmp ACDBECFD.tmp: "
echo 1>&2
./prog.alt ABXYEFCD.tmp ACDBECFD.tmp
echo 1>&2

rm -f curds.tmp whey.tmp
read -r -n 1 -p "Press any key to run: cp -vf cc.1 curds.tmp: "
echo 1>&2
cp -vf cc.1 curds.tmp
echo 1>&2
read -r -n 1 -p "Press any key to run: cp -vf cc.1 whey.tmp: "
echo 1>&2
cp -vf cc.1 whey.tmp

read -r -n 1 -p "Press any key to run: chmod -v 666 whey.tmp: "
echo 1>&2
chmod -v 666 whey.tmp
echo 1>&2

if [[ ! -x makeholes ]]; then
    read -r -n 1 -p "Press any key to run: make makeholes: "
    echo 1>&2
    make makeholes
    echo 1>&2
fi

read -r -n 1 -p "Press any key to run: ./makeholes -n 1000 whey.tmp: "
echo 1>&2
./makeholes -n 1000 whey.tmp
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog.alt curds.tmp whey.tmp (space = next page, q = quit): "
echo 1>&2
./prog.alt curds.tmp whey.tmp | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./avgtime.sh 100 ./prog.alt curds.tmp whey.tmp: "
echo 1>&2
./avgtime.sh 100 ./prog.alt curds.tmp whey.tmp
echo 1>&2

read -r -n 1 -p "Press any key to run: cp -vf war-and-peace.txt nuked.tmp: "
echo 1>&2
cp -vf war-and-peace.txt nuked.tmp
echo 1>&2

read -r -n 1 -p "Press any key to run: ./makeholes -c'~' -n 1000 nuked.tmp: "
echo 1>&2
./makeholes -c'~' -n 1000 nuked.tmp
echo 1>&2

echo "$ ./prog.alt war-and-peace.txt nuked.tmp" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog.alt war-and-peace.txt nuked.tmp | less -rEXFK
echo 1>&2

echo "$ ./avgtime.sh 100 ./prog.alt war-and-peace.txt nuked.tmp" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./avgtime.sh 100 ./prog.alt war-and-peace.txt nuked.tmp
echo 1>&2
