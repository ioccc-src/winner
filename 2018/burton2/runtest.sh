#!/bin/sh

: ${prog:=./prog}
: ${opt:=crs}

exec 2>&1
for name in test*c fixed_iocccsize.c ioc_without_quote; do
	/bin/echo -n "$name: "; $prog -$opt < $name
done
