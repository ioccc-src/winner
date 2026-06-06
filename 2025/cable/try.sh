#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/cable

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
read -r -n 1 -p "Press any key to run: ./prog < mandelbrot.bootimage: "
echo 1>&2
echo 1>&2
./prog < mandelbrot.bootimage
echo 1>&2

# try the program again
#
echo 'player 1: a = up, z = down'
echo 'player 2: k = up, m = down'
echo 'press q to quit'
echo
read -r -n 1 -p "Press any key to run: ./prog < pong.bootimage: "
echo 1>&2
echo 1>&2
./prog < pong.bootimage
echo 1>&2

# download special vmlinux image, if needed
#
export IMAGE_URL="https://raw.githubusercontent.com/adriancable/eternal/main/ioccc/vmlinux.bootimage.xz"
if [[ ! -s vmlinux.bootimage.xz && ! -s vmlinux.bootimage ]]; then
    read -r -n 1 -p "Press any key to: wget $IMAGE_URL: "
    echo 1>&2
    echo 1>&2
    wget "$IMAGE_URL"
    STATUS="$?"
    if [[ ! -s vmlinux.bootimage.xz ]]; then
	echo "ERROR: failed to download: $IMAGE_URL, error code: $STATUS" 1>&2
	exit 1
    fi
fi

# uncompress vmlinux image, if needed
#
if [[ -s vmlinux.bootimage.xz && ! -s vmlinux.bootimage ]]; then
    read -r -n 1 -p "Press any key to: xz -d vmlinux.bootimage.xz: "
    echo 1>&2
    echo 1>&2
    xz -d vmlinux.bootimage.xz
    STATUS="$?"
    if [[ ! -s vmlinux.bootimage ]]; then
	echo "ERROR: uncompress failed: vmlinux.bootimage.xz, error code: $STATUS" 1>&2
	exit 2
    fi
fi

# run vmlinux
#
if [[ -s vmlinux.bootimage ]]; then
    echo "Image will boot in a separate window.  To exit, type exit in the shell of that window." 1>&2
    echo 1>&2
    read -r -n 1 -p "Press any key to: ./prog < vmlinux.bootimage: "
    echo 1>&2
    echo 1>&2
    ./prog < vmlinux.bootimage
else
    echo "ERROR: non-empty image not found: vmlinux.bootimage" 1>&2
    exit 3
fi
