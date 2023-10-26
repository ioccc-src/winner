#!/usr/bin/env bash
#
# compile.sh - compile westley.alt.c, generate the alt versions and then attempt to
# compile them.
#
# To change what compiler is used you can do something like:
#
#	CC=/path/to/cc ./compile.sh
#
# The following example was run on a MacBook Pro with the M1 Max which which
# could not normally compile everything because macOS's compiler, even when run
# as gcc, is actually clang:
#
#	CC=/opt/local/bin/gcc-mp-12 ./compile.sh	
#
# We sleep (by default) for approximately 1 second after each command so that
# the you can read what is being done. If this is too fast you can change it in
# a similar way to the above but using the variable DELAY like so:
#
#	DELAY=2 ./compile.sh
#
# You can of course use both variables in the same command line like:
#
#	CC=/opt/local/bin/gcc-mp-12 DELAY=2 ./compile.sh
#	DELAY=2 CC=/opt/local/bin/gcc-mp-12 ./compile.sh
#
# ...and so on.

# get the compiler using default cc if not specified in the command line
#
# we cannot use the form '${CC:=cc}' because at least in some versions of bash
# it tries to invoke the command which would be an error by itself. Thus we just
# check if it's empty before we set it.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# get sleep duration
# we cannot use the form '${DELAY:=5}' because at least in some versions of bash
# it tries to invoke the command and obviously that won't work. Thus we check if
# it's empty before setting the default.
if [[ -z "$DELAY" ]]; then
    DELAY=0
fi

# make clobber to make the directory clean and then compile westley.alt which we
# need to run everything else. Exit if make westley.alt fails as there would be
# nothing further that could be done in that case:
echo "$ make clobber westley.alt"
sleep "$DELAY"
make CC="$CC" clobber westley.alt || exit 1
sleep "$DELAY"

# run commands previously in the try section of the README.md, showing what the
# commands are as we go:

# now generate and compile the files
#
echo "Generating and compiling alt versions ..." 1>&2
sleep "$DELAY"
echo "$ make CC=$CC alt.ver0 alt.ver1 alt.ver2 alt.ver3" 1>&2
make CC="$CC" alt.ver0 alt.ver1 alt.ver2 alt.ver3
