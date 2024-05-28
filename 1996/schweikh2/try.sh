#!/usr/bin/env bash
#
# try.sh - show IOCCC entry 1996/schweikh2
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to to run ./schweikh2 (space = next page, q = quit): " 1>&2
echo >&2
./schweikh2 | less -rEXF
echo >&2

read -r -n 1 -p "Press any key to run: ./schweikh2 15 1 0 0/0 | head -n 15: " 1>&2
echo >&2
./schweikh2 15 1 0 0/0 | head -n 15
echo >&2

read -r -n 1 -p "Press any key to run grep -v '#' schweikh2.c (space = next page, q = quit): "
echo 1>&2
grep -v '#' schweikh2.c | less -rEXF
echo 1>&2

PERL="$(type -P perl)"
if [[ -n "$PERL" ]]; then
    read -r -n 1 -p "Press any key to run: less hunni.c (space = next page, q = quit): "
    echo 1>&2
    less -rEXF hunni.c
    echo 1>&2

    echo "$ perl ./hunni.pl < hunni.c > obfus.c" 1>&2
    read -r -n 1 -p "Press any key to obfuscate hunni.c as obfus.c (space = next page, q = quit): "
    echo 1>&2
    perl ./hunni.pl < hunni.c > obfus.c

    read -r -n 1 -p "Press any key to run: diff -s obfus.c schweikh2.c: "
    echo 1>&2
    diff -s obfus.c schweikh2.c
    rm -f obfus.c
fi

read -r -p "Do you want to run the author's suggested command (Y/N)? "
if [[ "$REPLY" = "y" || "$REPLY" = "Y" ]]; then
    echo "Warning: this command is an infinite loop. Press ctrl-c or whatever your" 1>&2
    echo "intr is to end it." 1>&2
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    while :; do grep -v '#' schweikh2.c; sleep 2; echo; done
fi
