#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/codemeow

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
make CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
echo 1>&2
if [ "$(uname -s)" = "Darwin" ]; then
    # Hello, Apple
    # Most of the terminals process ANSI-sequences
    # wrongly without that. Also, apparently, this
    # affects `ioctl(STDOUT_FILENO, TIOCGWINSZ, &w)`
    # which can give wrong size (I've observed 80x
    # 300 in some cases, which contradicts the rea-
    # lity).

    #   I recommend  using `iTerm2` or `xterm` and
    # maximize the terminal window under Mac OS X

    export TERM=vt100
#   export TERM=xterm

#else
    # It perfectly works under any Linux terminal
    # No need to prepare anything

fi
./prog
echo 1>&2
