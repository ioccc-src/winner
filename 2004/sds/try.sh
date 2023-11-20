#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2004/sds
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

echo "$ ./sds < sds.c > encoder.c" 1>&2
./sds < sds.c > encoder.c
echo 1>&2

echo "$ make encoder 2>/dev/null" 1>&2
make encoder 2>/dev/null
echo 1>&2

echo "$ ./encoder README.md <sds.c >sds_msg.c"
./encoder README.md <sds.c >sds_msg.c

echo "$ make sds_msg 2>/dev/null" 1>&2
make sds_msg 2>/dev/null
echo 1>&2

echo "$ ./sds_msg < sds.c > sds2_msg.c" 1>&2
./sds_msg < sds.c > sds2_msg.c

echo "$ diff sds2_msg.c encoder.c" 1>&2
diff sds2_msg.c encoder.c

echo "$ echo 'Hello, World!' > message" 1>&2
echo 'Hello, World!' > message

echo "$ ./encoder message < README.md > remarks.md" 1>&2
./encoder message < README.md > remarks.md

read -r -n 1 -p "Press any key to show diff remarks.md README.md: "
echo "$ diff remarks.md README.md" 1>&2
diff remarks.md README.md # notice how similar they are
echo "Did you notice how similar they are?" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "

echo 1>&2
# and then observe:
echo "$ ./sds < remarks.md" 1>&2
./sds < remarks.md
