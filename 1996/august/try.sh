#!/usr/bin/env bash
#
# try.sh - show IOCCC winner 1996/august
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

set -x
cat august.c test.oc | ./august > test.oo
./august < test.oo
cat august.c fac.oc | ./august > fac.oo
./august < fac.oo

cat august.c fac.oc | ./august | ./august

cat august.c parse.oc | ./august > parse.oo
cat parse.oo fac.oc | ./august | ./august

rm august.oc
make august.oc

# this next step is vital for some compilers! Not having it will make the
# compiler create code that enters an infinite loop. This is known to happen in
# macOS as one example.
sed -i'' '/^#/d' august.oc

cat august.c august.oc | ./august > august.oo
cat august.oo test.oo | ./august
cat august.oo august.oo fac.oo | ./august
cat august.oo august.oo august.oo fac.oo | ./august
