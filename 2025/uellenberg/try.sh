#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/uellenberg

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

cp -f prog.c prog.quine.c
chmod +w prog.quine.c

stty -echo -icanon
trap 'stty sane && rm -f prog.quine.c' INT TERM HUP EXIT

# try the program
#
echo 'To move, pass either "w" (up) or "e" (down)' 1>&2
echo 'To quit, press ^C' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
cat prog.quine.c

while true
do
  # Use "quine" to compile prog.quine.c and avoid overriding prog.c
  ${MAKE:=make} CC="$CC" quine >/dev/null &
  pid=$!

  key=""
  while IFS= read -r -t 0.1 -n 1 ch; do key="$ch"; done

  wait "$pid" || exit 1
  output=$(./prog.quine "$key") || exit 1
  echo "$output" > prog.quine.c

  clear
  echo "$output"
done
