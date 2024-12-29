#!/usr/bin/env bash
#
# compile.sh - compile westley.c then generate and compile versions
#
# To change what compiler is used you can do something like:
#
#	CC=/path/to/cc ./compile.sh
#	CC=gcc ./compile.sh
#
# The path is only necessary if the default using the shell would result in the
# wrong one for instance in macOS /usr/bin/gcc is actually clang but if you have
# gcc installed elsewhere you can specify the path. If CC is unset it will be
# set to 'cc'.
#
# The following example was run on a MacBook Pro (with the M1 Max) which which
# could not normally compile everything by default because clang can only compile some of
# the versions due to defects in clang. Getting clang to compile any version was
# an incredible challenge but some versions of the generated code can be
# compiled with clang. Nevertheless if you have gcc from, say, MacPorts,
# installed, you could do:
#
#	CC=/opt/local/bin/gcc-mp-13 ./compile.sh	
#
# If you don't specify a path the shell/script will figure it out.
#
# We sleep (by default) for 0 seconds after each command but one can set that to
# a different value so that it's easier for them to read what is being done. For
# instance to change it to 2 seconds:
#
#	DELAY=2 ./compile.sh
#
# You can of course use both variables in the same command line like:
#
#	CC=/opt/local/bin/gcc-mp-13 DELAY=2 ./compile.sh
#	DELAY=2 CC=/opt/local/bin/gcc-mp-13 ./compile.sh
#
# ...and so on.

# get the compiler using default cc if not specified in the command line
#
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# get sleep duration
if [[ -z "$DELAY" ]]; then
    DELAY=0
fi

# make clobber to make the directory clean and then compile westley which we
# need to run everything else. Exit if make westley fails as there would be
# nothing further that could be done in that case:
#
echo "$ make clobber westley" 1>&2
sleep "$DELAY"
make CC="$CC" clobber westley || exit 1
sleep "$DELAY"

# run commands previously in the try section of the README.md, showing what the
# commands are as we go:

echo "$ ./westley < westley.c > ver0.c" 1>&2
./westley < westley.c > ver0.c
sleep "$DELAY"
echo "$ ./westley 1 < westley.c > ver1.c" 1>&2
./westley 1 < westley.c > ver1.c
sleep "$DELAY"
echo "$ ./westley 1 2 < westley.c > ver2.c" 1>&2
./westley 1 2 < westley.c > ver2.c
sleep "$DELAY"
echo "$ ./westley 1 2 3 < westley.c > ver3.c" 1>&2
./westley 1 2 3 < westley.c > ver3.c
sleep "$DELAY"

# now compile the files by running make
#

echo "Compiling generated versions ..." 1>&2
sleep "$DELAY"
echo "$ make CC=$CC ver0 ver1 ver2 ver3" 1>&2
sleep "$DELAY"
make CC="$CC" ver0 ver1 ver2 ver3
