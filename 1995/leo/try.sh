#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1995/leo
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


# try finding gs
GS="$(type -P gs)"

rm -f foo.ps
read -r -n 1 -p "Press any key to run: ./leo 1 | cat - > foo.ps: "
echo "" | ./leo 1 | cat - > foo.ps
echo 1>&2
# if they have gs open foo.ps with it
if [[ -n "$GS" ]]; then
    read -r -n 1 -p "Press any key to run: $GS foo.ps: "
    echo 1>&2
    "$GS" foo.ps
else
    echo "Now send foo.ps to your local postscript printer or open it in an appropriate" 1>&2
    echo "application (e.g. GIMP)." 1>&2
fi
