#!/usr/bin/env bash
# 
# run 2012/kang with English words for 1 through 13
#
# What does it get right and what does it get wrong? Why does it get what it
# gets wrong wrong?

make everything || exit 1

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
    echo -n "$i (${NUMBERS[$j]}): "
    echo "$i"|"./$KANG"
    ((j++))
done
