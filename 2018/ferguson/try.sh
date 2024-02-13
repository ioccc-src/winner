#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2018/ferguson
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

read -r -n 1 -p "Press any key to run: ./weasel words (space = next page, q = quit, G = end): "
echo 1>&2
time ./weasel words | less -rEXFK

read -r -n 1 -p "Press any key to see how long it'll take Eric the monkey to type his name: "
echo 1>&2
time ./weasel -mq Eric
echo 1>&2

read -r -p "Do you want to run make test (Y/N)? "
if [[ "$REPLY" = "Y" || "$REPLY" = "y" ]]; then
    make test
fi

read -r  -p "Do you wish to see the undocumented Easter egg (Y/N)? "
if [[ "$REPLY" = "Y" || "$REPLY" = "y" ]]; then
    make -B OFFSPRING=97 everything 1>/dev/null || exit 1
    read -r -n 1 -p "Press any key to show Easter egg (./weasel): "
    echo 1>&2
    ./weasel
    echo 1>&2
fi

echo 1>&2
read -r -n 1 -p "Press any key to change max attempts to 100: "
echo 1>&2
echo "$ make -B MAX_ATTEMPTS=100 everything >/dev/null || exit 1" 1>&2
echo 1>&2
make -B MAX_ATTEMPTS=100 everything >/dev/null || exit 1
read -r -n 1 -p "Press any key to see what happens when the maximum attempts are reached: "
echo 1>&2
./weasel -m 'Eric the Monkey'

# recompile with default max attempts for the next steps
make -B everything >/dev/null || exit 1

# obviously '"intelligent" design' is false but who wants to try and prove
# otherwise? Or if they know better how long will it take to show that evolution
# is a proven fact?
./id.sh

# If the user did not try and prove '"intelligent" design' or they waited a
# long time (though saving them some time by limiting it to 900000 attempts) I
# ask: can Eric the monkey type the word 'words' before falling asleep or
# getting too hungry to continue?
./monkey-words.sh
