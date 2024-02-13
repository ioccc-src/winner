#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1994/schnitzi
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1


read -r -n 1 -p "Press any key to run: ./schnitzi < schnitzi.c > schnitzi2.c: "
echo 1>&2
./schnitzi < schnitzi.c > schnitzi2.c 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: make schnitzi2: "
echo 1>&2
make schnitzi2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./schnitzi2 < schnitzi2.c > schnitzi3.c: "
echo 1>&2
./schnitzi2 < schnitzi2.c > schnitzi3.c 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: make schnitzi3: "
echo 1>&2
make schnitzi3
echo 1>&2


read -r -n 1 -p "Press any key to run: diff3 schnitzi.c schnitzi2.c schnitzi3.c (space = next page, q = quit): "
echo 1>&2
diff3 schnitzi.c schnitzi2.c schnitzi3.c | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to show try.txt: "
echo 1>&2
cat try.txt
echo 1>&2

rm -f try1.txt try2.txt try3.txt
read -r -n 1 -p "Press any key to run: ./schnitzi < try.txt | tee try1.txt (space = next page, q = quit): "
echo 1>&2
./schnitzi < try.txt 2>/dev/null | tee try1.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./schnitzi2 < try.txt | tee try2.txt (space = next page, q = quit): "
echo 1>&2
./schnitzi2 < try.txt 2>/dev/null | tee try2.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./schnitzi3 < try.txt | tee try3.txt (space = next page, q = quit): "
echo 1>&2
./schnitzi3 < try.txt 2>/dev/null | tee try3.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: diff3 try1.txt try2.txt try3.txt: "
echo 1>&2
diff3 try1.txt try2.txt try3.txt && echo "All three files are the same!"
echo 1>&2
