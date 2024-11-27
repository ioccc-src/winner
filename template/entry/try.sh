#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry abstract
#
# NOTE: if your submission wins and become an entry, 'abstract' will be changed
# to the YYYY/directory name. You can remove this comment if you wish but if not
# it'll be done by the judges.
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

# XXX - Invoke the program in one or more ways                    - XXX
# XXX - It is good to use the shell built-in read to let the user - XXX
# XXX - read what will happen and then proceed as they wish.      - XXX
# XXX - You may modify the command based on your program and you  - XXX
# XXX - may provide more than one invocation.                     - XXX
# XXX - Please remove the XXX lines                               - XXX
# XXX - an example follows                                        - XXX

read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
./prog
