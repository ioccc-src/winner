#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/endoh3

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

# Set up the working directory:
#
rm -rf work
mkdir -p work
cp prog.c ioooo.txt.orig ioccc.diff patch work
cd work || echo "ERROR: failed to cd work" 1>&2 || exit 1
chmod +w prog.c ioooo.txt.orig ioccc.diff
chmod +x patch

# Check that the program works like a patch command:
#
echo 'Check that the program works like a patch command' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./patch < ioccc.diff: "
echo 1>&2
echo 1>&2
cp -f ioooo.txt.orig ioooo.txt
./patch < ioccc.diff
echo 1>&2

read -r -n 1 -p "Press any key to run: cat ioooo.txt: "
echo 1>&2
echo 1>&2
cat ioooo.txt
echo 1>&2

# Apply the program as a patch file to the program itself:
#
echo 'Check that the program works like a patch command' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./patch < prog.c: "
echo 1>&2
echo 1>&2
./patch < prog.c

# Compile the patched program:
#
echo 'Compile the patched program' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to: re-compile ./prog: "
echo 1>&2
echo 1>&2
rm -f prog
make -f ../Makefile CC="$CC" prog
echo 1>&2

# The patched program should output a new patch file:
#
echo 'The patched program should output a new patch file' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to apply the new patch: ./prog | ./patch : "
echo 1>&2
echo 1>&2
./prog | ./patch
echo 1>&2

# Set up a git repository and commit the prog.c:
#
echo 'Set up a git repository and commit the prog.c' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to: git init: "
echo 1>&2
echo 1>&2
git init
echo 1>&2
read -r -n 1 -p "Press any key to: git add prog.c: "
echo 1>&2
echo 1>&2
git add prog.c
read -r -n 1 -p "Press any key to: git commit --allow-empty-message -m \"/* initial commit */\": "
echo 1>&2
echo 1>&2
git commit --allow-empty-message -m "/* initial commit */"
echo 1>&2

# Repeat: recompile, generate a patch, and apply it via git am.
# Each iteration peels off one line of the final program as a commit message.
# Eventually, the program outputs nothing and the loop ends.
#
echo 'Repeat: recompile, generate a patch, and apply it via git am.' 1>&2
echo 'Each iteration peels off one line of the final program as a commit message.' 1>&2
echo 'Eventually, the program outputs nothing and the loop ends.' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to: start the 26 cycle loop: "
echo 1>&2
export CYCLE=0
while true; do
    echo 1>&2
    echo "starting compile and patch cycle number $CYCLE: " 1>&2
    echo 1>&2
    rm -f prog
    echo "make -f ../Makefile CC=\"$CC\" prog" 1>&2
    make -f ../Makefile CC="$CC" prog >/dev/null 2>&1
    echo "./prog > _patch.tmp" 1>&2
    ./prog > _patch.tmp
    echo "[[ -s _patch.tmp ]] || break" 1>&2
    [[ -s _patch.tmp ]] || break
    echo "git am < _patch.tmp" 1>&2
    echo 1>&2
    git am < _patch.tmp
    ((CYCLE=CYCLE+1))
done
echo 1>&2
echo "rm -f _patch.tmp" 1>&2
echo 1>&2
echo "End of loops" 1>&2
rm -f _patch.tmp
echo 1>&2

# The commit messages form the final program:
#
echo 'The commit messages form the final program' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to: git log --pretty=format:%s > diff.c: "
echo 1>&2
echo 1>&2
git log --pretty=format:%s > diff.c

# Compile the final program and run it:
#
echo 'Compile the final program'
echo 1>&2
read -r -n 1 -p "Press any key to compile: diff.c: "
echo 1>&2
echo 1>&2
make -f ../Makefile CC="$CC" diff

# Run the final program
#
echo 'Run the final program'
echo 1>&2
read -r -n 1 -p "Press any key to see the usage message for: ./diff: "
echo 1>&2
echo 1>&2
./diff
echo 1>&2
read -r -n 1 -p "Press any key to: ./diff ioooo.txt.orig ioooo.txt: "
./diff ioooo.txt.orig ioooo.txt
echo 1>&2
