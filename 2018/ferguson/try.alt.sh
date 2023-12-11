#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC winner 2018/ferguson alt code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: ./weasel.alt words (space = next page, q = quit): "
echo 1>&2
time ./weasel.alt words | less -EXF

read -r -n 1 -p "Press any key to see how long it'll take Eric the monkey to type his name: "
echo 1>&2
time ./weasel.alt -mq Eric
echo 1>&2

read -r -n 1 -p "Press any key to run: make test: "
echo 1>&2
make test

read -r -p "Do you wish to try and prove 'intelligent design' (Y/N)? "
if [[ "$REPLY" == "Y" || "$REPLY" == "y" ]]; then
    echo "$ ./weasel.alt -m 'INTELLIGENT DESIGN'" 1>&2
    echo "Press any key to continue. Send ctrl-c when convinced that intelligent" 1>&2
    read -r -n 1 -p "design is not real or you're tired of waiting: "
    echo 1>&2
    time ./weasel.alt -m 'INTELLIGENT DESIGN'
    echo 1>&2
else
    echo "$ ./weasel.alt -q -r8 'EVOLUTION IS A PROVEN FACT'" 1>&2
    time ./weasel.alt -q -r8 'EVOLUTION IS A PROVEN FACT'
fi

read -r -n 1 -p "Do you want to see how long it might take the monkey Eric to type 'words'? (Y/N)? "
if [[ "$REPLY" == "Y" || "$REPLY" == "y" ]]; then
    echo 1>&2
    echo "Will not display until Eric succeeds or too many generations. Hit ctrl-c" 1>&2
    echo "to stop him early." 1>&2
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    time ./weasel.alt -mq words
fi
