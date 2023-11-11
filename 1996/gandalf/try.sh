#!/usr/bin/env bash

make all 1>/dev/null || exit 1

# remove temporary files to show later
rm -f hatcat.txt cathat.txt hatcat2.txt cathat2.txt hatcat3.txt cathat3.txt

trap 'rm -f hatcat.txt cathat.txt hatcat2.txt cathat2.txt hatcat3.txt cathat3.txt; exit' 0 1 2 3 15

delete_tmp_files()
{
    rm -f hatcat.txt cathat.txt hatcat2.txt cathat2.txt hatcat3.txt cathat3.txt
    return 0
}
press_any_key()
{
    echo 1>&2
    read -r -n 1 -p "Press any key to continue (q = quit): " 1>&2
    test "$REPLY" = "q" && delete_tmp_files && echo 1>&2 && exit
}

show_diff()
{
    if [[ "$#" -ne 2 ]]; then
	echo "$0: show_diff expects two args, got: $#" 1>&2
	exit 1
    fi
    echo "$ diff $1 $2" 1>&2
    diff "$1" "$2" && echo "$1 and $2 are identical"
}

echo "Notice how the programs are the same:" 1>&2
diff -s hatcat cathat
press_any_key

echo "Now notice how running both cathat and hatcat in different ways" 1>&2
echo "shows different output." 1>&2
press_any_key

echo "Running hatcat without a path:" 1>&2
echo "$ PATH=.:\$PATH" 1>&2
PATH=.:$PATH
echo "$ hatcat | tee hatcat.txt" 1>&2
hatcat | tee hatcat.txt
press_any_key

echo "Running cathat without a path:" 1>&2
echo "$ cathat | tee cathat.txt" 1>&2
cathat | tee cathat.txt
press_any_key

echo "Showing diff between the above two commands, 'hatcat' and './cathat':" 1>&2
show_diff hatcat.txt cathat.txt
press_any_key

echo "Now watch ./hatcat:" 1>&2
./hatcat | tee hatcat2.txt
press_any_key

echo "Now watch ./cathat:" 1>&2
./cathat | tee cathat2.txt
press_any_key

echo "Showing diff between running 'hatcat' and './hatcat':" 1>&2
show_diff hatcat.txt hatcat2.txt
press_any_key

echo "Now watch \$(pwd)/cathat" 1>&2
"$(pwd)"/cathat | tee cathat3.txt
press_any_key

echo "Finally, watch \$(pwd)/hatcat" 1>&2
"$(pwd)"/hatcat | tee hatcat3.txt
press_any_key

echo "Showing diff between running './hatcat' and './cathat':" 1>&2
show_diff hatcat2.txt cathat2.txt
press_any_key

echo "Showing diff between running '\$(pwd)/hatcat' and '\$(pwd)/cathat':" 1>&2
show_diff hatcat3.txt cathat3.txt
press_any_key

echo "Showing diff between running '\$(pwd)/hatcat' and 'hatcat':" 1>&2
show_diff hatcat3.txt hatcat.txt
press_any_key

echo "Showing diff between running '\$(pwd)/hatcat' and './hatcat':" 1>&2
show_diff hatcat3.txt hatcat2.txt
press_any_key

echo "Showing diff between running '\$(pwd)/cathat' and 'cathat':" 1>&2
show_diff cathat3.txt cathat.txt
press_any_key

echo "Showing diff between running '\$(pwd)/cathat' and './cathat':" 1>&2
show_diff cathat3.txt cathat2.txt
press_any_key

# remove temporary files
rm -f hatcat.txt cathat.txt hatcat2.txt cathat2.txt hatcat3.txt cathat3.txt

echo 1>&2
echo "Now answer: why did some of the same programs execute differently?" 1>&2
