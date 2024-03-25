#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2004/sds
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

read -r -n 1 -p "Press any key to show sds.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK sds.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./sds < sds.c | tee encoder.c (space = next page, q = quit): "
echo 1>&2
./sds < sds.c | tee encoder.c | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: make encoder 2>/dev/null: "
echo 1>&2
make encoder 2>/dev/null
echo 1>&2

echo "$ ./encoder README_sds.txt <sds.c | tee sds_msg.c" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./encoder README_sds.txt <sds.c | tee sds_msg.c | less -rEXFK

read -r -n 1 -p "Press any key to run: make sds_msg 2>/dev/null: "
echo 1>&2
make sds_msg 2>/dev/null
echo 1>&2

echo "$ ./sds_msg < sds.c | tee sds2_msg.c | less -rEXF" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./sds_msg < sds.c | tee sds2_msg.c | less -rEXFK

read -r -n 1 -p "Press any key to run: diff -s sds2_msg.c encoder.c: "
echo 1>&2
diff -s sds2_msg.c encoder.c
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 'Hello, World!' > message: "
echo 1>&2
echo 'Hello, World!' > message
echo 1>&2

echo "$ ./encoder message < README_sds.txt | tee remarks.md" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./encoder message < README_sds.txt | tee remarks.md | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: diff remarks.md README_sds.txt (space = next page, q = quit): "
echo 1>&2
diff remarks.md README_sds.txt | less -rEXFK
echo "Did you notice how similar they are?" 1>&2
echo 1>&2

# and then observe:
read -r -n 1 -p "Press any key to run: ./sds < remarks.md: "
echo 1>&2
./sds < remarks.md
echo 1>&2
