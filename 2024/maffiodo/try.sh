#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/maffiodo

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program and the alt program have been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" everything >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
echo "Are you ready? Let's go!" 1>&2
echo 1>&2
read -r -n 1 -p "## Forrest test: Press any key to run: cat test.js string.js | ./prog "
echo 1>&2
echo 1>&2
cat test.js string.js | ./prog
echo 1>&2

read -r -n 1 -p "## Array tests: Press any key to run: cat test.js array.js | ./prog"
echo 1>&2
echo 1>&2
cat test.js array.js | ./prog
echo 1>&2

read -r -n 1 -p "## Math tests: Press any key to run: cat test.js math.js | ./prog"
echo 1>&2
echo 1>&2
cat test.js math.js | ./prog
echo 1>&2

read -r -n 1 -p  "## Utils tests: Press any key to run: cat test.js utils.js | ./prog"
echo 1>&2
echo 1>&2
cat test.js utils.js | ./prog
echo 1>&2

read -r -n 1 -p  "## Verify tests: Press any key to run: cat utils.js verify.js | ./prog"
echo 1>&2
echo 1>&2
cat utils.js verify.js | ./prog
echo 1>&2

read -r -n 1 -p  "## Fibonacci tests: Press any key to run: cat console.js fibo.js | ./prog"
echo 1>&2
echo 1>&2
cat console.js fibo.js | ./prog
echo 1>&2
