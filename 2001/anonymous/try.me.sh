#!/usr/bin/env bash

make clobber
make all 2>/dev/null
echo "$ cp anonymous.ten anonymous.ten.bak" 1>2
cp anonymous.ten anonymous.ten.bak
echo "$ ./anonymous anonymous.ten" 1>&2
./anonymous anonymous.ten
echo "$ ./anonymous.ten" 1>&2
./anonymous.ten
echo "$ diff -s anonymous.ten anonymous.ten.bak" 1>&2
diff -s anonymous.ten anonymous.ten.bak
echo "$ od anonymous.ten > ten.od" 1>&2
od anonymous.ten > ten.od
echo "$ od anonymous.ten.bak > ten.bak.od" 1>&2
od anonymous.ten.bak > ten.bak.od
echo "$ diff ten.bak.od ten.od" 1>&2
diff ten.bak.od ten.od
echo "$ ./anonymous.ten > ten.txt" 1>&2
./anonymous.ten > ten.txt
echo "$ ./anonymous.ten.bak > ten.bak.txt" 1>&2
./anonymous.ten.bak > ten.bak.txt
echo "$ diff -s ten.txt ten.bak.txt" 1>&2
diff -s ten.txt ten.bak.txt
