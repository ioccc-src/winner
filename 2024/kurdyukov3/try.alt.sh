#!/usr/bin/env bash
#
# try.alt.sh - demonstrate 2024/kurdyukov3

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
make CC="$CC" alt >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
read -r -n 1 -p "Press any key to run: ./prog.sdl2 hello.bin: "
echo 1>&2
./prog.sdl2 hello.bin
echo 1>&2

# try the program 2nd time
#
read -r -n 1 -p "Press any key to run: ./prog.sdl2 loader.bin < hello.bin: "
echo 1>&2
./prog.sdl2 loader.bin < hello.bin
echo 1>&2

# try the program 3md time
#
read -r -n 1 -p "Press any key to run: ./prog.sdl2 lzmadec.bin < sdk.zip.lzma > sdk.zip: "
echo 1>&2
rm -f sdk.zip
./prog.sdl2 lzmadec.bin < sdk.zip.lzma > sdk.zip
echo 1>&2

# run the doom game
#
echo 'NOTE: In this next game, there is no sound, network nor mouse available.' 1>&2
echo 1>&2
echo 'NOTE: Press <Esc> to toggle viewing the menu' 1>&2
echo 'NOTE:     Use Up and Down arrows to navigate the menu' 1>&2
echo 'NOTE:	Press return to select a menu item' 1>&2
echo 1>&2
echo 'NOTE:	For game help, select the "Read This!" menu item' 1>&2
echo 'NOTE:	Select "New Game" to play'  1>&2
echo 'NOTE:	To terminate program, select the "Quit Game" menu item and then press "y"' 1>&2
echo 'NOTE: Use' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run in an xterm: ./prog.sdl2 doomp.bin: "
echo 1>&2
./prog.sdl2 doomp.bin
