#!/usr/bin/env bash

make clobber
make addpadding
make bytecount
echo ./addpadding
./addpadding
./bytecount > strings.loc.txt
./bytecount -i data.asc.src > strings.asc.loc.txt
./bytecount -i data.scrnshot.src > strings.scrnshot.loc.txt
grep '<' strings.loc.txt > bytes.txt
while read byte ; do echo "V($(echo $byte|sed -e 's,<,,g' -e 's,>,,g'))"; done < bytes.txt  > V.c
make everything
