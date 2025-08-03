#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/kurdyukov2

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(which gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
read -r -n 1 -p "Press any key to run: ./prog < input.jpg > output.jpg: "
echo 1>&2
echo 1>&2
rm -f output.jpg
./prog < input.jpg > output.jpg
echo "Now open output.jpg in a graphics viewer in a separate window." 1>&2
echo "And compare it, in a separate window, with the original input.jpg file." 1>&2
echo 1>&2

# try the program again
#
read -r -n 1 -p "Press any key to run: ./prog < input2.jpg > output2.jpg: "
echo 1>&2
echo 1>&2
rm -f output2.jpg
./prog < input2.jpg > output2.jpg
echo "Now open output2.jpg in a graphics viewer in a separate window." 1>&2
echo "And compare it, in a separate window, with the original input2.jpg file." 1>&2
echo 1>&2
