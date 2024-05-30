#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2001/coupard
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
[[ -z "$CC" ]] && CC="cc"

# in this case we won't fail if we can't compile the code because we can still
# run the supplementary program.
make CC="$CC" everything >/dev/null

# clear screen after compilation so that only the entry is shown
clear

# hopefully sox(1) is installed but we check for it just in case that it's not
SOX="$(type -P sox)"
AUDIO="/dev/audio"
DSP="/dev/sound/dsp"

if [[ -n "$SOX" ]]; then
    echo "$ ./coupard | $SOX -q -traw -r8000 -b8 -e unsigned-integer - -tcoreaudio" 1>&2
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    ./coupard | "$SOX" -q -traw -r8000 -b8 -e unsigned-integer - -tcoreaudio
    echo 1>&2
elif [[ -S "$AUDIO" ]]; then
    ./coupard > "$AUDIO"
elif [[ -S "$DSP" ]]; then
    ./coupard > "$DSP"
else
    echo "SoX not installed. Please install it and try again." 1>&2
    echo "Tip: visit: https://www.ioccc.org/faq.html#sox" 1>&2
fi
