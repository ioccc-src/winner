#!/usr/bin/env bash

x=$1
: "${x:=./prog}"

if [[ ! -x "$x" ]]; then
    x="./prog"
fi

: "${out:="diff - correct"}"

(
/bin/echo -n | $x
$x < /dev/null
echo | $x
/bin/echo -n a | $x
echo a | $x
$x < newlines
# 256 is a file so it is supposed to be file redirection. Thus we have to
# disable this warning:
#
# SC2210 (warning): This is a file redirection. Was it supposed to be a comparison or fd operation?
# https://www.shellcheck.net/wiki/SC2210
# shellcheck disable=SC2210
$x < 256
$x < remarks
) | $out
