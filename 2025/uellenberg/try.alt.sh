#!/usr/bin/env bash
#
# try.alt.sh - alternative demonstration of 20205/uellenberg

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" alt >/dev/null || exit 1

# clear the screen
#
clear

cp prog.alt.c prog.alt.quine.c
chmod +w prog.alt.quine.c

stty -echo -icanon
trap 'stty sane && rm prog.alt.quine.c' EXIT

cat prog.alt.quine.c

while true
do
  # Use "alt-quine" to compile prog.alt.quine.c and avoid overriding prog.alt.c
  ${MAKE:=make} CC="$CC" alt-quine >/dev/null &
  pid=$!

  key=""
  while IFS= read -r -t 0.1 -n 1 ch; do key="$ch"; done

  wait "$pid" || exit 1
  output=$(./prog.alt.quine "$key") || exit 1
  echo "$output" > prog.alt.quine.c

  clear
  echo "$output"
done
