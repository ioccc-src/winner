#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry YYYY/foo
# XXX - try.sh example version: 1.0.0-1 11-28-2024                          - XXX

# XXX - NOTE: if your submission wins and becomes an entry, then            - XXX
# XXX - YYYY/foo will be changed to the 4 digit year and directory          - XXX
# XXX - name.                                                               - XXX
# XXX - NOTE: please remove the XXX lines in this file, including this one  - XXX
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
# XXX - if you need CC to be something else, say clang, then change cc      - XXX
# XXX - to whatever you need.                                               - XXX
# XXX - If you need other variables you can also set them in whatever way   - XXX
# XXX - you need; this is a good method, however, in cases where it's OK    - XXX
# XXX - to let the user redefine it.                                        - XXX
[[ -z "$CC" ]] && CC="cc"


# XXX - make sure to compile the program, using make all!                   - XXX
# XXX - if you need to build the alt code for the try.sh script,            - XXX
# XXX - then change the 'all' to 'all alt' in the below command.            - XXX
# XXX - Later, if the submission wins, it can be changed to 'everything'.   - XXX
make CC="$CC" all >/dev/null || exit 1

# XXX - it's usually a good idea to clear the screen but if not done        - XXX
# XXX - then you should remove the comment about it and the command.        - XXX
# clear screen after compilation so that only the entry is shown
clear

# XXX - Invoke the program in one or more ways                      - XXX

# XXX - NOTE: you can include more than one command line and you    - XXX
# XXX - certainly can include pipelines.                            - XXX

# XXX - It is good to use the shell built-in read(1) to             - XXX
# XXX - let the user know what is about to be done, as              - XXX
# XXX - shown below, so they can proceed when ready.                - XXX

# XXX - You may modify the command based on your program and you    - XXX
# XXX - may provide more than one invocation.                       - XXX

# XXX - Examples follow.                                            - XXX

# XXX - if the prompt will not be too long, say more than 80 chars  - XXX
# XXX - or so:                                                      - XXX
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
./prog

# XXX - Otherwise, for longer command lines, you might try:         - XXX
echo "$ ./prog some long command line"
read -r -n 1 -p "Press any key to continue: "
./prog some long command line
