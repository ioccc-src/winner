#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/ayu

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
echo 'For the demos that follow:' 1>&2
echo 1>&2
echo '    Move via arrow keys, or using h / j / k / l keys' 1>&2
echo '    Type q to quit, or ^C' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
export SOX_TOOL
SOX_TOOL=$(type -P sox)
if [[ -x $SOX_TOOL ]]; then
    echo 'The game supports sounds.' 1>&2
    echo 1>&2
    read -r -n 1 -p "Press any key to run: ./prog >(sox --buffer 1024 -t s16 -r 48000 -c 1 - -d 2>/dev/null): "
    echo 1>&2
    ./prog >(sox --buffer 1024 -t s16 -r 48000 -c 1 - -d 2>/dev/null)
else
    echo 'The game supports sounds.  Please install sox demonstrate that feature.' 1>&2
    echo 'Due to the lack of sox tool, playing without sound.' 1>&2
    echo 1>&2
    ./prog
fi
echo 1>&2
