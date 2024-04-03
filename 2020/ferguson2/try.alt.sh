#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2020/ferguson2
#
# I, Cody Boone Ferguson, want to dedicate this entry in part to the millions of
# poor souls that were lost during the tragedy that is the Second World War.
# There are so many people who are unknown, unloved, unclaimed and even
# unidentified. And who knows what they might have gone on to do if their lives
# weren't - like it is with all other wars - needlessly taken from them? When
# one considers it was all because the most powerful man in the world at the
# time felt he should rule all others it makes it somehow even more tragic:
# there wasn't even a good reason for the war (is there ever?).
# 
# If one were to write the name of every person who died in the conflict in a
# book, it would take so many pages that the book would be so heavy, so long, so
# expensive to print and it wouldn't bring anyone back to life nor would it erase
# the suffering. Nothing will. It's horrible.
# 
# There really are no words that can truly describe the tragedy but I wish to
# with my Enigma simulator honour each and every soul who was lost, or suffered,
# or suffered the loss of friends or loved ones, as well as the world itself, in
# and from one of the greatest tragedies in the history of mankind.
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

# IOCCC obfuscated!
read -r -n 1 -p "Press any key to encrypt IOCCC with default settings: "
echo 1>&2
echo "$ echo IOCCC | ./prog.alt" 1>&2
echo IOCCC | ./prog.alt
echo 1>&2

# IOCCC obfuscated and de-obfuscated!:
read -r -n 1 -p "Press any key to encrypt and then decrypt IOCCC with default settings: "
echo 1>&2
echo "$ echo IOCCC | ./prog | ./prog.alt" 1>&2
echo IOCCC | ./prog | ./prog.alt
echo 1>&2

# more input fun:
read -r -n 1 -p "Press any key to show try.this.txt: "
echo 1>&2
echo "$ cat try.this.txt" 1>&2
cat try.this.txt
read -r -n 1 -p "Press any key to encrypt text of try.this.txt with its own settings: "
echo 1>&2
echo "$ ./prog.alt - < try.this.txt 2>/dev/null" 1>&2
echo 1>&2
./prog.alt - < try.this.txt 2>/dev/null
echo 1>&2

# even more input fun:
read -r -n 1 -p "Press any key to show key.txt: "
echo 1>&2
echo "$ cat key.txt" 1>&2
cat key.txt
echo 1>&2
read -r -n 1 -p "Press any key to encrypt IOCCC with code of key.txt: "
echo 1>&2
echo "$ echo IOCCC | ./recode -v -Rkey.txt | ./prog.alt - 2>/dev/null" 1>&2
echo IOCCC | ./recode -v -Rkey.txt | ./prog.alt - 2>/dev/null
echo 1>&2

# now decrypt IOCCC with settings of key.txt by piping it back to recode -> prog.alt
read -r -n 1 -p "Press any key to encrypt and then decrypt IOCCC with code of key.txt: "
echo 1>&2
echo "$ echo IOCCC | ./recode -v -Rkey.txt | ./prog - 2>/dev/null | ./recode -Rkey.txt | ./prog.alt - 2>/dev/null" 1>&2
echo IOCCC | ./recode -v -Rkey.txt | ./prog - 2>/dev/null | ./recode -Rkey.txt | ./prog.alt - 2>/dev/null
echo 1>&2

# more obfuscated fun:
read -r -n 1 -p "Press any key to send 'testing test tests' to recode: "
echo 1>&2
echo "$ echo testing test tests | ./recode -v" 1>&2
echo testing test tests | ./recode -v
echo 1>&2

read -r -n 1 -p "Press any key to send 'testing test tests' to recode -> prog.alt: "
echo 1>&2
echo "$ echo testing test tests | ./recode -v | ./prog.alt - 2>/dev/null" 1>&2
echo testing test tests | ./recode -v | ./prog.alt - 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to send 'testing test tests' to recode -> prog -> recode: "
echo 1>&2
echo "$ echo testing test tests | ./recode -v | ./prog - 2>/dev/null | ./recode" 1>&2
echo testing test tests | ./recode -v | ./prog - 2>/dev/null | ./recode -v
echo 1>&2

read -r -n 1 -p "Press any key to send 'testing test tests' to recode -> prog -> recode -> prog.alt: "
echo 1>&2
echo "$ echo testing test tests | ./recode -v | ./prog - 2>/dev/null | ./recode -v | ./prog.alt - 2>/dev/null" 1>&2
echo testing test tests | ./recode -v | ./prog - 2>/dev/null | ./recode -v | ./prog.alt - 2>/dev/null
echo 1>&2

# even more obfuscated fun saving and reading from files:
#
# initial clean up:
rm -f conf input output output2
# encrypt "testing test tests" with randomised settings saved in conf, saving
# original string to input and original output to output:
read -r -n 1 -p "Press any key to save settings and output, then encrypt: "
echo 1>&2
echo "$ echo testing test tests | tee input | ./recode -v -r -oconf | ./prog - 2>/dev/null >output" 1>&2
echo testing test tests | tee input | ./recode -v -r -oconf | ./prog - 2>/dev/null >output
read -r -n 1 -p "Press any key to show input file: "
echo 1>&2
cat input
echo 1>&2
read -r -n 1 -p "Press any key to run: cat output: "
echo 1>&2
cat output
echo 1>&2
# configure Enigma machine from conf file and read from output file, thus decrypting:
read -r -n 1 -p "Press any key to decrypt the output from the above command: "
echo 1>&2
echo "$ ./recode -v -Rconf -foutput | ./prog - 2>/dev/null > output2" 1>&2
./recode -v -Rconf -foutput | ./prog - 2>/dev/null > output2
read -r -n 1 -p "Press any key to run: cat output2: "
echo 1>&2
cat output2
read -r -n 1 -p "Press any key to run: cat input: "
echo 1>&2
cat input
echo 1>&2
# make sure input and output2 are the same:
read -r -n 1 -p "Press any key to compare input and output2: "
echo 1>&2
diff -s input output2
# final clean up
rm -f conf input output output2
