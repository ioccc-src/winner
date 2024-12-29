#!/usr/bin/env bash
#
# Script to automate the try commands of 1989/westley.
#
# If you need to pass a different compiler, say because your compiler is clang,
# you can use the CC environmental variable like:
#
#   CC=gcc ./try.sh
#
# This will be passed to compile.sh.
#
# If CC is empty (not specified) it defaults to 'cc'. After it is set to either
# 'cc' or the compiler specified it will use 'compile.sh' with the passed in (or
# default 'cc') CC var to make use of it.
#
# If CC is a path it will use that; otherwise it will let the script find the
# path via the shell. This is useful for this entry in particular because in
# macOS /usr/bin/gcc is actually clang and some of the versions of this entry
# will not compile with clang due to defects. Getting any version to compile
# with clang was an incredible challenge and it seems impossible to get all the
# versions to compile with clang but if you only have access to clang (for
# example in macOS /usr/bin/gcc is actually clang) you can at least get some
# entries to work.
#
# But if you have gcc installed, say with MacPorts, you could do something like:
#
#   CC=/opt/local/bin/gcc-mp-13 ./try.sh
#

# get the compiler using default cc if not specified in the command line
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# first compile everything or at least try to with the $CC var.
CC="$CC" ./compile.sh >/dev/null 2>&1

# clear the screen after compilation

if [[ -e "./westley" ]]; then
    echo "$ echo IOCCC | ./westley" 1>&2
    echo IOCCC | ./westley
    echo

    echo "$ echo IOCCC | ./westley 1" 1>&2
    echo IOCCC | ./westley 1
    echo

    echo "$ echo IOCCC | ./westley 1 2" 1>&2
    echo IOCCC | ./westley 1 2
    echo

    echo "$ echo IOCCC | ./westley 1 2 3" 1>&2
    echo IOCCC | ./westley 1 2 3
    echo
fi

if [[ -e "./ver0" ]]; then
    echo "$ echo IOCCC | ./ver0" 1>&2
    echo IOCCC | ./ver0
    echo

    echo "$ echo IOCCC | ./ver0 1" 1>&2
    echo IOCCC | ./ver0 1
    echo

    echo "$ echo IOCCC | ./ver0 1 2" 1>&2
    echo IOCCC | ./ver0 1 2
    echo

    echo "$ echo IOCCC | ./ver0 1 2 3" 1>&2
    echo IOCCC | ./ver0 1 2 3
    echo
fi

if [[ -e "./ver1" ]]; then
    echo "$ echo Version 1 | ./ver1" 1>&2
    echo Version 1 | ./ver1
    echo

    echo "$ echo Version 1 | ./ver1 1" 1>&2
    echo Version 1 | ./ver1 1
    echo

    echo "$ echo Version 1 | ./ver1 1 2" 1>&2
    echo Version 1 | ./ver1 1 2
    echo

    echo "$ echo Version 1 | ./ver1 1 2 3" 1>&2
    echo Version 1 | ./ver1 1 2 3
    echo
fi

if [[ -e "./ver2" ]]; then
    echo "$ echo Version 2 | ./ver2" 1>&2
    echo Version 2 | ./ver2
    echo

    echo "$ echo Version 2 | ./ver2 1" 1>&2
    echo Version 2 | ./ver2 1
    echo

    echo "$ echo Version 2 | ./ver2 1 2" 1>&2
    echo Version 2 | ./ver2 1 2
    echo

    echo "$ echo Version 2 | ./ver2 1 2 3" 1>&2
    echo Version 2 | ./ver2 1 2 3
    echo
fi

if [[ -e "./ver3" ]]; then
    echo "$ echo Version 3 | ./ver3" 1>&2
    echo Version 3 | ./ver3
    echo

    echo "$ echo Version 3 | ./ver3 1" 1>&2
    echo Version 3 | ./ver3 1
    echo

    echo "$ echo Version 3 | ./ver3 1 2" 1>&2
    echo Version 3 | ./ver3 1 2
    echo

    echo "$ echo Version 3 | ./ver3 1 2 3" 1>&2
    echo Version 3 | ./ver3 1 2 3
fi
echo 1>&2
