#!/usr/bin/env bash
# 
# run 2012/kang with English words for 1 through 13
#
# What does it get right and what does it get wrong? Why does it get what it
# gets wrong wrong?


# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

# set up path to program if not set
if [[ -z "$KANG" ]]; then
    KANG="kang"
fi

declare -a NUMBERS
j=0
for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13; do
    NUMBERS["$j"]="$i";
    ((j++))
done

j=0
for i in zero one two three four five six seven eight nine ten eleven twelve thirteen ; \
do
    read -r -n 1 -p "Press any key to run: echo $i | ./$KANG # ${NUMBERS[$j]}: "
    echo 1>&2
    echo "$i" | "./$KANG"
    ((j++))
done
