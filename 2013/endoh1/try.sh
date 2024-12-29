#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2013/endoh1
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

read -r -n 1 -p "Press any key to run: less endoh1.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK endoh1.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./endoh1 hello.lazy (space = next page, q = quit): "
echo 1>&2
./endoh1 hello.lazy | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hello: "
echo 1>&2
./hello
echo 1>&2

read -r -n 1 -p "Press any key to run: echo Hello | ./echo: "
echo 1>&2
# ShellCheck gets this wrong, thinking ./echo is the shell built-in or system
# command so we disable the warning.
#
# SC2216 (warning): Piping to 'echo', a command that doesn't read stdin. Did you want 'cat' instead?
# https://www.shellcheck.net/wiki/SC2216
# shellcheck disable=SC2216
echo Hello | ./echo
echo 1>&2

read -r -n 1 -p "Press any key to run: ./tac < endoh1.c (space = next page, q = quit): "
echo 1>&2
./tac < endoh1.c | less -rEXFK
echo 1>&2
