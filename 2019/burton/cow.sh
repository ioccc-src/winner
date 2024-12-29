#!/usr/bin/env bash

if test $# -eq 0; then
	./prog
	exit 0
fi

args=$*
for name in $args
do if test -r "$name"; then
	s=$(./prog < "$name")
	echo "$s" "$name"
	# We have to disable this warning to prevent ShellCheck from being a cow.sh
	# (or, to use Bart Simpson's advice, make it 'not have a cow.sh'), as we
	# actually need this to happen:
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# https://www.shellcheck.net/wiki/SC2086
	# shellcheck disable=SC2086
	set -- $s
	((a += $1))
	((b += $2))
	((c += $3))
	((d += 1))
fi; done
((d > 1)) && printf "%8d%8d%8d total\n" "$a" "$b" "$c"
