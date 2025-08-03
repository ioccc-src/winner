#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/ferguson2

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
read -r -n 1 -p "Press any key to translate \"test\": "
echo 1>&2
echo 1>&2
./prog test
echo 1>&2

read -r -n 1 -p "Press any key to decipher the above output: "
echo 1>&2
echo 1>&2
# SC2046 (warning): Quote this to prevent word splitting
# We must disable this warning as we want word splitting!
# shellcheck disable=SC2046
./prog.alt $(./prog test)
echo 1>&2

read -r -n 1 -p "Press any key to translate \"bear\": "
echo 1>&2
echo 1>&2
./prog bear
echo 1>&2

read -r -n 1 -p "Press any key to decipher the above output: "
echo 1>&2
echo 1>&2
# SC2046 (warning): Quote this to prevent word splitting
# We must disable this warning as we want word splitting!
# shellcheck disable=SC2046
./prog.alt $(./prog bear)
echo 1>&2

read -r -n 1 -p "Press any key to translate \"Commanding Officer\": "
echo 1>&2
echo 1>&2
./prog 'Commanding Officer'
echo 1>&2

read -r -n 1 -p "Press any key to decipher the above output: "
echo 1>&2
echo 1>&2
# SC2046 (warning): Quote this to prevent word splitting
# We must disable this warning as we want word splitting!
# shellcheck disable=SC2046
./prog.alt $(./prog 'Commanding Officer')
echo 1>&2

read -r -n 1 -p "Press any key to translate cat: "
echo 1>&2
echo 1>&2
# SC2046 (warning): Quote this to prevent word splitting
# We must disable this warning as we want word splitting!
# shellcheck disable=SC2046
./prog cat
echo 1>&2

read -r -n 1 -p "Press any key to decipher the above output: "
echo 1>&2
echo 1>&2
# SC2046 (warning): Quote this to prevent word splitting
# We must disable this warning as we want word splitting!
# shellcheck disable=SC2046
./prog.alt $(./prog cat)
echo 1>&2

read -r -n 1 -p "Press any key to translate code: "
echo 1>&2
echo 1>&2
./prog code
echo 1>&2

read -r -n 1 -p "Press any key to decipher the above output: "
echo 1>&2
echo 1>&2
# SC2046 (warning): Quote this to prevent word splitting
# We must disable this warning as we want word splitting!
# shellcheck disable=SC2046
./prog.alt $(./prog code)
echo 1>&2

read -r -n 1 -p "Press any key to encode: SENDING CODE: "
echo 1>&2
echo 1>&2
./prog "SENDING CODE"
echo 1>&2
read -r -n 1 -p "Press any key to decode above message: " 1>&2
echo 1>&2
echo 1>&2
for i in KLESH DZEH TSAH CHINDI YEH-HES TSAH JEHA ' ' MOASI A-KHA CHINDI DZEH; do
    ./prog.alt "$i" | tr -d '\n'
done
echo 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to encode: CODE RECEIVED: "
echo 1>&2
echo 1>&2
./prog "CODE RECEIVED"
echo 1>&2
read -r -n 1 -p "Press any key to decode above message: " 1>&2
echo 1>&2
echo 1>&2
for i in MOASI NE-AHS-JAH LHA-CHA-EH DZEH ' ' GAH DZEH MOASI DZEH TKIN A-KEH-DI-GLINI DZEH LHA-CHA-EH; do
    ./prog.alt "$i" | tr -d '\n'
done
echo 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to encode: INTERNATIONAL OBFUSCATED C CODE CONTEST: "
echo 1>&2
echo 1>&2
./prog "INTERNATIONAL OBFUSCATED C CODE CONTEST"
echo 1>&2
read -r -n 1 -p "Press any key to decode above message: " 1>&2
echo 1>&2
echo 1>&2
for i in YEH-HES TSAH D-AH DZEH DAH-NES-TSA TSAH WOL-LA-CHEE D-AH YEH-HES A-KHA TSAH WOL-LA-CHEE NASH-DOIE-TSO ' ' A-KHA SHUSH CHUO NO-DA-IH KLESH MOASI WOL-LA-CHEE D-AH DZEH CHINDI ' '  MOASI ' ' MOASI A-KHA CHINDI DZEH ' ' MOASI A-KHA TSAH D-AH DZEH KLESH D-AH; do
    ./prog.alt "$i" | tr -d '\n'
done
echo 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to encode the English alphabet: "
echo 1>&2
echo 1>&2
for i in {A..Z}; do ./prog "$i" | tr '\n' ' '; done
echo 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to decode the above output: "
echo 1>&2
echo 1>&2
for i in {A..Z}; do
    ./prog.alt "$(./prog.alt "$i")" | tr '\n' ' '
done
echo 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog.alt +prog.alt.c > foo.c: "
echo 1>&2
echo 1>&2
./prog.alt +prog.alt.c > foo.c

read -r -n 1 -p "Press any key to run: make foo: "
echo 1>&2
echo 1>&2
make foo
echo 1>&2

read -r -n 1 -p "Press any key to run: ./foo +foo.c > bar.c: "
echo 1>&2
echo 1>&2
./foo +foo.c > bar.c

read -r -n 1 -p "Press any key to run: diff foo.c bar.c: "
echo 1>&2
echo 1>&2
diff foo.c bar.c
echo 1>&2

echo 'If the above diff shows difference, can you explain there is a difference? :-)'
echo 1>&2

# cleanup
#
rm -f foo foo.c bar bar.c
