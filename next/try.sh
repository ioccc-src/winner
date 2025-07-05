#!/usr/bin/env bash
#
# try.sh - demonstrate YYYY/XXX	    <<=== The IOCCC Judges will replace this line

# XXX - try.sh example version: 28.1.0 2024-07-05                           - XXX
# XXX -                                                                     - XXX
# XXX - NOTE: please remove the XXX lines in this file, including this one  - XXX

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
# XXX - if you need CC to be something else, say clang, then change cc      - XXX
# XXX - to whatever you need.                                               - XXX
# XXX - If you need other variables you can also set them in whatever way   - XXX
# XXX - you need; this is a good method, however, in cases where it's OK    - XXX
# XXX - to let the user redefine it.                                        - XXX
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
# XXX - make sure to compile the program, using make all!                   - XXX
# XXX - if you need to build the alt code for the try.sh script,            - XXX
# XXX - then change the 'all' to 'all alt' in the below command.            - XXX
# XXX - Later, if the submission wins, it can be changed to 'everything'.   - XXX
make CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear
zsh:1: command not found: :w

# XXX - NOTE: you can include more than one command line and you    - XXX
# XXX - certainly can include pipelines.                            - XXX

# XXX - It is good to use the shell built-in read(1) to             - XXX
# XXX - let the user know what is about to be done, as              - XXX
# XXX - shown below, so they can proceed when ready.                - XXX

# XXX - You may modify the command based on your program and you    - XXX
# XXX - may provide more than one invocation.                       - XXX

# XXX - Examples follow.                                            - XXX

# XXX - if the prompt will not be too long, say no more than 80-100 - XXX
# XXX - chars or so:                                                - XXX

# try the program
#
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
echo 1>&2
./prog
echo 1>&2

# XXX - Remove or expand sections as needed.                       - XXX

# try the program with args
#
read -r -n 1 -p "Press any key to run: ./prog some long command line < data: "
echo 1>&2
echo 1>&2
./prog some long command line < data
echo 1>&2
