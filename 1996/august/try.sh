#!/usr/bin/env bash
#
# try.sh - show IOCCC entry 1996/august
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

read -r -n 1 -p "Press any key to run: cat august.c test.oc | ./august > test.oo: "
echo 1>&2
cat august.c test.oc | ./august > test.oo
echo 1>&2

read -r -n 1 -p "Press any key to run: ./august < test.oo: "
echo 1>&2
./august < test.oo
echo 1>&2

read -r -n 1 -p "Press any key to run: cat august.c fac.oc | ./august > fac.oo: "
echo 1>&2
cat august.c fac.oc | ./august > fac.oo
echo 1>&2

read -r -n 1 -p "Press any key to run: ./august < fac.oo: "
echo 1>&2
./august < fac.oo
echo 1>&2

read -r -n 1 -p "Press any key to run: cat august.c fac.oc | ./august | ./august: "
echo 1>&2
cat august.c fac.oc | ./august | ./august
echo 1>&2

read -r -n 1 -p "Press any key to run: cat august.c parse.oc | ./august > parse.oo: "
echo 1>&2
cat august.c parse.oc | ./august > parse.oo
echo 1>&2

read -r -n 1 -p "Press any key to run: cat parse.oo fac.oc | ./august | ./august: "
echo 1>&2
cat parse.oo fac.oc | ./august | ./august
echo 1>&2

read -r -n 1 -p "Press any key to run: rm august.oc; make august.oc: "
echo 1>&2
rm august.oc; make august.oc
echo 1>&2

# this next step is vital for some compilers! Not having it will make the
# compiler create code that enters an infinite loop. This is known to happen in
# macOS as one example.
read -r -n 1 -p "Press any key to run: sed -i'' '/^#/d' august.oc: "
echo 1>&2
sed -i'' '/^#/d' august.oc
echo 1>&2

read -r -n 1 -p "Press any key to run: cat august.c august.oc | ./august > august.oo: "
echo 1>&2
cat august.c august.oc | ./august > august.oo
echo 1>&2

read -r -n 1 -p "Press any key to run: cat august.oo test.oo | ./august: "
echo 1>&2
cat august.oo test.oo | ./august
echo 1>&2

read -r -n 1 -p "Press any key to run: cat august.oo august.oo fac.oo | ./august: "
echo 1>&2
cat august.oo august.oo fac.oo | ./august
echo 1>&2

read -r -n 1 -p "Press any key to run: cat august.oo august.oo august.oo fac.oo | ./august: "
echo 1>&2
echo "This step may take more time: " 1>&2
cat august.oo august.oo august.oo fac.oo | ./august
echo 1>&2
