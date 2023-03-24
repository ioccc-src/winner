#!/bin/sh
awk '/^[^$]/{l=length;m=m>l?m:l;a[l]=a[l]$1}
     END{printf"\"";for(i=1;i<=m;++i)printf" "a[i];print"\""}' $*
