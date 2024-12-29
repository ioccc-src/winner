#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/deckmyn
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

read -r -n 1 -p "Press any key to show deckmyn.c (space = next page, q = quit): "
echo 1>&2
less -rEXF deckmyn.c
echo 1>&2

echo "$ ./deckmyn "\$\(cat deckmyn.c\)" "\$\(cat example_greensleeves\)" 2>/dev/null > greensleeves.pbm" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./deckmyn "$(cat deckmyn.c)" "$(cat example_greensleeves)" 2>/dev/null > greensleeves.pbm
echo 1>&2

echo "$ ./deckmyn "\$\(cat deckmyn.c\)" "\$\(cat example_beethoven\)" 2>/dev/null > beethoven.pbm" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./deckmyn "$(cat deckmyn.c)" "$(cat example_beethoven)" 2>/dev/null > beethoven.pbm
echo 1>&2

echo "$ ./deckmyn "\$\(cat deckmyn.c\)" \"sz sa x  s1 x  s1 x  s1 x  s1 x  s1 \" 2>/dev/null > blank.pbm" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./deckmyn "$(cat deckmyn.c)" "sz sa x  s1 x  s1 x  s1 x  s1 x  s1 " 2>/dev/null > blank.pbm
echo 1>&2

# Convert pbm files to png files if convert(1) is found in case the user does
# not have a viewer of pbm files. At the end we will check for png files to make
# sure that there was at least one conversion. If that does not happen as long
# as there are pbm files those will be listed instead. Otherwise something went
# wrong and we warn the user about it.
CONVERT="$(type -P convert)"
if [[ -n "$CONVERT" && -f "$CONVERT" && -x "$CONVERT" ]]; then
    if [[ -f "greensleeves.pbm" ]]; then
	if "$CONVERT" greensleeves.pbm greensleeves.png; then
	    echo "Converted greensleeves.pbm to greensleeves.png." 1>&2
	fi
    fi
    if [[ -f "beethoven.pbm" ]]; then
	if "$CONVERT" beethoven.pbm beethoven.png; then
	    echo "Converted beethoven.pbm to beethoven.png." 1>&2
	fi
    fi
    if [[ -f "blank.pbm" ]]; then
	if "$CONVERT" blank.pbm blank.png; then
	    echo "Converted blank.pbm to blank.png." 1>&2
	fi
    fi
fi

# Now tell the user to look at png files if any exist and otherwise any pbm
# files if any exist. If no files exist then something went wrong so show a
# warning message.
if [[ ! "$(find . -name '*.png')" ]]; then
    echo "Now open the following files with your image viewer of choice:" 1>&2
    echo 1>&2
    find . -name '*.png' -printf "   %p\n"
elif [[ ! "$(find . -name '*.pbm')" ]]; then
    echo "Now open the following files with your image viewer of choice:" 1>&2
    echo 1>&2
    find . -name '*.pbm' -printf "   %p\n"
else
    echo "-=-=-" 1>&2
    echo "Notice: failed to write any image files. Free free to fix and open a" 1>&2
    echo "pull request against the GitHub repo." 1>&2
    echo "-=-=-" 1>&2
fi
