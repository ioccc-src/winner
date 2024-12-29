#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/grothe
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

echo "$ ./grothe -cookie_recipe.txt 1-/dev/urandom 2-/dev/urandom \\
    1+cookie_piece1.dat 2+cookie_piece2.dat 3+cookie_piece3.dat 4+cookie_piece4.dat"
read -r -n 1 -p "Press any key to continue (break recipe into crumbs): "
echo 1>&2
./grothe -cookie_recipe.txt 1-/dev/urandom 2-/dev/urandom \
    1+cookie_piece1.dat 2+cookie_piece2.dat 3+cookie_piece3.dat 4+cookie_piece4.dat
echo 1>&2

echo "$ ./grothe 1-cookie_piece1.dat 2-cookie_piece2.dat 4-cookie_piece4.dat +cookie_recipe_restore.txt" 1>&2
./grothe 1-cookie_piece1.dat 2-cookie_piece2.dat 4-cookie_piece4.dat +cookie_recipe_restore.txt
read -r -n 1 -p "Press any key to continue (restore cookie recipe): "
echo 1>&2

read -r -n 1 -p "Press any key to run: diff -s cookie_recipe.txt cookie_recipe_restore.txt: "
echo 1>&2
diff -s cookie_recipe.txt cookie_recipe_restore.txt
echo 1>&2

read -r -n 1 -p "Press any key to see the recipe file, restored (space = next page, q = quit): "
echo 1>&2
less -rEXFK cookie_recipe_restore.txt
