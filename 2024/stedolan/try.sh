#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/stedolan

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
read -r -n 1 -p "Press any key to run: md5sum prog.c | ./prog > prog.pbm: "
echo 1>&2
echo 1>&2
rm -f prog.pbm
md5sum prog.c | ./prog > prog.pbm
echo "Now open prog.pbm in a graphics viewer in a separate window." 1>&2
echo 1>&2

# try the program again
#
read -r -n 1 -p "Press any key to run: md5sum try.sh | ./prog > try.pbm: "
echo 1>&2
echo 1>&2
rm -f try.pbm
md5sum try.sh | ./prog > try.pbm
echo "Now open try.pbm in a graphics viewer in a separate window." 1>&2
echo 1>&2
