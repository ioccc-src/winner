#!/usr/bin/env bash
#
# try.alt.sh - alternative demonstration of 2025/yang22

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the alt program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" clobber alt >/dev/null || exit 1

# clear the screen
#
clear

# try a non-repetitive input
read -r -n 1 -p "Press any key to run: echo hello world | ./prog.alt > spam1.c "
echo hello world | ./prog.alt > spam1.c
echo 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: cat spam1.c "
echo 1>&2
cat spam1.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ${CC} spam1.c -o spam1 && ./spam1 "
echo 1>&2
echo 1>&2
${CC} spam1.c -o spam1 && ./spam1
echo 1>&2

# Try a repetitive input
read -r -n 1 -p "Press any key to run: echo yeah, yeah, yeah | ./prog.alt > spam2.c "
echo yeah, yeah, yeah | ./prog.alt > spam2.c
echo 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: cat spam2.c "
echo 1>&2
echo 1>&2
cat spam2.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ${CC} spam2.c -o spam2 && ./spam2 "
echo 1>&2
echo 1>&2
${CC} spam2.c -o spam2 && ./spam2
echo 1>&2

# Concatenate the outputs
read -r -n 1 -p "Press any key to run: cat spam1.c spam2.c > spam_spam.c "
echo 1>&2
echo 1>&2
cat spam1.c spam2.c > spam_spam.c

read -r -n 1 -p "Press any key to run: ${CC} spam_spam.c -o spam_spam && ./spam_spam "
echo 1>&2
echo 1>&2
${CC} spam_spam.c -o spam_spam && ./spam_spam
echo 1>&2

# Try C++ version
read -r -n 1 -p "Press any key to run: echo I O C C C | ./prog.alt++ > spam3.c "
echo 1>&2
echo 1>&2
echo I O C C C | ./prog.alt++ > spam3.c

read -r -n 1 -p "Press any key to run: cat spam3.c "
echo 1>&2
cat spam3.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ${CC} spam3.c -o spam3 && ./spam3 "
echo 1>&2
echo 1>&2
${CC} spam3.c -o spam3 && ./spam3
echo 1>&2
