#!/usr/bin/env bash

make everything || exit 1

run()
{
    local program="$1"
    echo "" 1>&2
    echo -n "$ ./${program}" 1>&2
    sleep 2
    "./${program}" | less -K -e
}
echo "running everything with $(type -P less): " 1>&2
echo 1>&2
run pi
run 314
run 3141
run 31415
run 314159
run 3141592
run 31415926
run 314159265
run 3141592653
run 31415926535
run e 271
run 2718
run 27182
run 271828
run 2718281
run 27182818
run 271828182
run 2718281828
run 27182818284
