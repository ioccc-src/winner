#!/usr/bin/env bash

# WARNING: this will take A LONG time and will eat up inodes! I recommend if you
# run this, even if not the full duration (which might be wise), to open the
# target file (fun.ppm) soon after it starts: either in an image viewer that
# will reload the image when it detects a change OR repeatedly reopen it if you
# have a good way to do this. That can be done in macOS like: open fun.ppm.
#
# You could modify the range of course. That actually might be fun but I ran out
# of time to play with it more as I did not think of it until 5 March 2026! The
# idea started out as a way to test every coordinate and it seemed to look okay
# although as you'll notice if you do it it will stop looking like arrows:
# entirely the point but earlier on it looks more fun than later on.

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" clobber all >/dev/null || exit 1

# clear the screen
#
clear

./prog -90 180 earth.ppm fun.ppm
for ((i=-90; i<= 90; ++i)); do
    for ((j=-180; j<=180 ; ++j)); do
        ./prog "$i" "$j" fun.ppm fun.ppm
    done
done
