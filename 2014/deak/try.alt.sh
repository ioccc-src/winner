#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 2014/deak alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# compile the alternate code with various parameters and run it to show different
# output

read -r -n 1 -p "Press any key to change X1 to 2, X2 to -1 and Y1 to -2.3: "
echo 1>&2
make -B X1=2 X2=-1 Y1=-2.3 alt >/dev/null || exit
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog.alt | less -rEXFK

read -r -n 1 -p "Press any key to change X1 to 3, X2 to -2 and Y1 to -3.3: "
echo 1>&2
make -B X1=3 X2=-2 Y1=-3.3 alt >/dev/null || exit
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog.alt | less -rEXFK

read -r -n 1 -p "Press any key to change X1 to 1, X2 to -1 and Y1 to -0.3: "
echo 1>&2
make -B X1=1 X2=-1 Y1=-0.3 alt >/dev/null || exit
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog.alt | less -rEXFK

read -r -n 1 -p "Press any key to change X1 to 1, X2 to -1, Y1 to -0.3 and Y2 to -1.3: "
echo 1>&2
make -B X1=1 X2=-1 Y1=-0.3 Y2=-1.3 alt >/dev/null || exit
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog.alt | less -rEXFK

read -r -n 1 -p "Press any key to try the original configuration: "
echo 1>&2
make clobber alt >/dev/null || exit 1
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog.alt | less -rEXFK
