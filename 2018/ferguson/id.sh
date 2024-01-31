#!/usr/bin/env bash
#
# id.sh - determine exactly how real '"intelligent" design' is
#

# limit to 250000 attempts to save them time if they really wish to try and
# prove that '"intelligent" design' is real (or more correctly so that they
# might last long enough in the try scripts to move on to the next step)
make -B MAX_ATTEMPTS=250000 everything >/dev/null || exit 1

read -r -p "Do you wish to try and prove '\"intelligent\" design' (Y/N)? "
if [[ "$REPLY" = "Y" || "$REPLY" = "y" ]]; then
    echo "$ ./weasel -m 'INTELLIGENT DESIGN'" 1>&2
    echo "Limiting to 250000 attempts to save you time." 1>&2
    echo "Press any key to continue. Send ctrl-c when convinced that intelligent" 1>&2
    read -r -n 1 -p "design is not real or you're tired of waiting: "
    ./weasel -m 'INTELLIGENT DESIGN'
    echo 1>&2
    exit 1
else
    echo "$ ./weasel -r8 'EVOLUTION IS A PROVEN FACT'" 1>&2
    time ./weasel -r8 'EVOLUTION IS A PROVEN FACT'
    exit 0
fi
