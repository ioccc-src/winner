#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2012/deckmyn
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

read -r -n 1 -p "Press any key to run deckmyn.c through less (space = next page, q = quit): "
echo 1>&2
less deckmyn.c
echo 1>&2
echo "$ ./deckmyn "\$\(cat deckmyn.c\)" "\$\(cat example_greensleeves\)" 2>/dev/null > greensleeves.pbm" 1>&2
./deckmyn "$(cat deckmyn.c)" "$(cat example_greensleeves)" 2>/dev/null > greensleeves.pbm
echo 1>&2
echo "Now open greensleeves.pbm in your image viewer of choice." 1>&2
echo 1>&2

echo "$ ./deckmyn "\$\(cat deckmyn.c\)" "\$\(cat example_beethoven\)" 2>/dev/null > beethoven.pbm" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./deckmyn "$(cat deckmyn.c)" "$(cat example_beethoven)" 2>/dev/null > beethoven.pbm
echo "Now open beethoven.pbm in your image viewer of choice." 1>&2
echo 1>&2

echo "$ ./deckmyn "\$\(cat deckmyn.c\)" \"sz sa x  s1 x  s1 x  s1 x  s1 x  s1 \" 2>/dev/null > blank.pbm" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./deckmyn "$(cat deckmyn.c)" "sz sa x  s1 x  s1 x  s1 x  s1 x  s1 " 2>/dev/null > blank.pbm
echo "Now open blank.pbm in your image viewer of choice." 1>&2

