#!/usr/bin/env bash
#
# try.sh - show IOCCC entry 1996/gandalf
#
# BTW: it is absolutely perilous to 'try' the patience of Gandalf: go ahead,
# 'try it'! :-)
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

if [[ "$#" -gt 0 ]]; then
    if [[ "${1@L}" = "gandalf" ]]; then
	echo "It is perilous to try the patience of Gandalf!" 1>&2
	read -r -p "Are you sure you wish to do this (Y/N)? "
	echo 1>&2
	if [[ "$REPLY" != "y" && "$REPLY" != "Y" ]]; then
	    echo "Wise move, will not try Gandalf's patience!" 1>&2
	    exit 0
	else
	    echo "Fool of a ${USER@u}!" 1>&2
	    echo "Oh well, never mind that, moving on ..." 1>&2
	    echo 1>&2
	fi
    fi
fi

# remove temporary files to show later
rm -f hatcat.txt cathat.txt hatcat2.txt cathat2.txt hatcat3.txt cathat3.txt

trap 'rm -f hatcat.txt cathat.txt hatcat2.txt cathat2.txt hatcat3.txt cathat3.txt; exit' 0 1 2 3 15

show_diff()
{
    if [[ "$#" -ne 3 ]]; then
	echo "$0: show_diff expects two args, got: $#" 1>&2
	exit 1
    fi
    echo "$ diff $1 $2 ($3): " 1>&2
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    diff -C 1 "$1" "$2" && echo "$1 and $2 are identical"
    echo 1>&2
}

read -r -n 1 -p "Press any key to run: diff -s hatcat cathat: "
echo 1>&2
diff -s hatcat cathat
echo 1>&2

echo "Next notice how running both cathat and hatcat in different ways" 1>&2
echo "shows different output." 1>&2

read -r -n 1 -p "Press any key to run: PATH=.:\$PATH: "
echo 1>&2
PATH=.:$PATH
read -r -n 1 -p "Press any key to run: hatcat | tee hatcat.txt (no path): "
echo 1>&2
hatcat | tee hatcat.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: cathat | tee cathat.txt (no path): "
echo 1>&2
cathat | tee cathat.txt
echo 1>&2

show_diff hatcat.txt cathat.txt "diff between 'hatcat' and './cathat'"

read -r -n 1 -p "Press any key to run: ./hatcat | tee hatcat2.txt: "
echo 1>&2
./hatcat | tee hatcat2.txt

read -r -n 1 -p "Press any key to run: ./cathat | tee cathat2.txt: "
echo 1>&2
./cathat | tee cathat2.txt

show_diff hatcat.txt hatcat2.txt "diff between 'hatcat' and './hatcat'"

read -r -n 1 -p "Press any key to run: \$(pwd)/cathat | tee cathat3.txt: "
echo 1>&2
"$(pwd)"/cathat | tee cathat3.txt

read -r -n 1 -p "Press any key to run: \$(pwd)/hatcat | tee hatcat3.txt: "
echo 1>&2
"$(pwd)"/hatcat | tee hatcat3.txt

show_diff hatcat2.txt cathat2.txt "diff between './hatcat' and './cathat'"

show_diff hatcat3.txt cathat3.txt "diff between '\$(pwd)/hatcat' and '\$(pwd)/cathat'"

show_diff hatcat3.txt hatcat.txt "diff between '\$(pwd)/hatcat' and 'hatcat'"

show_diff hatcat3.txt hatcat2.txt "diff between '\$(pwd)/hatcat' and './hatcat'"

show_diff cathat3.txt cathat.txt "diff between \$(pwd)/cathat' and 'cathat'"

show_diff cathat3.txt cathat2.txt "diff between '\$(pwd)/cathat' and './cathat'"

# remove temporary files
rm -f hatcat.txt cathat.txt hatcat2.txt cathat2.txt hatcat3.txt cathat3.txt

echo 1>&2
echo "Now answer: why did some of the same programs execute differently?" 1>&2

rm -f hatcat.txt cathat.txt hatcat2.txt cathat2.txt hatcat3.txt cathat3.txt
