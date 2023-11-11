#!/usr/bin/env bash

make clobber all
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
sed -i'' '/^#/d' august.oc
cat august.c august.oc | ./august > august.oo
cat august.oo test.oo | ./august
cat august.oo august.oo fac.oo | ./august
cat august.oo august.oo august.oo fac.oo | ./august
