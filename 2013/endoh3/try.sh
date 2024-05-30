#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2013/endoh3
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

# Because there are numerous ways to run this entry we check for different tools
# being installed in order to determine how to proceed. Even so /dev/dsp seems
# to be uninstalled in modern systems so we check for what the author suggested
# with that but only if the other options won't work (like SoX not installed).
#
SOX="$(type -P sox)"
PADSP="$(type -P padsp)"
RUBY="$(type -P ruby)"

endoh3()
{
    if [[ "$#" -ne 1 ]]; then
	echo "$0: endoh3() requires one arg, got: $#" 1>&2
	return
    fi
    if [[ -f "$1" && -r "$1" ]]; then
	if [[ -n "$SOX" ]]; then
	    echo "$ ./endoh3 < $1 | $SOX -q -traw -r8000 -b8 -e unsigned-integer - -tcoreaudio" 1>&2
	    read -r -n 1 -p "Press any key to continue: "
	    echo 1>&2
	    ./endoh3 < "$1" | "$SOX" -q -traw -r8000 -b8 -e unsigned-integer - -tcoreaudio
	    echo 1>&2
	elif [[ -n "$PADSP" ]]; then
	    echo "$ ./endoh3 < $1 | $PADSP tee /dev/dsp > /dev/null" 1>&2
	    read -r -n 1 -p "Press any key to continue: "
	    echo 1>&2
	    ./endoh3 < "$1" | "$PADSP" tee /dev/dsp > /dev/null
	    echo 1>&2
	elif [[ -n "$RUBY" ]]; then
	    echo "$ ./endoh3 < $1 | $RUBY wavify.rb > $1.wav" 1>&2
	    read -r -n 1 -p "Press any key to continue: "
	    echo 1>&2
	    ./endoh3 < "$1" | "$RUBY" wavify.rb > "$1".wav
	    echo "Now try playing $1.wav in a program that plays WAV files." 1>&2
	    echo 1>&2
	else
	    echo "Please install either SoX, ruby or padsp (from PulseAudio)." 1>&2
	    exit 1
	fi
    else # no file
	if [[ -n "$SOX" ]]; then
	    echo "$ echo $1 | ./endoh3 | $SOX -q -traw -r8000 -b8 -e unsigned-integer - -tcoreaudio" 1>&2
	    read -r -n 1 -p "Press any key to continue: "
	    echo 1>&2
	    echo "$1" | ./endoh3 | "$SOX" -q -traw -r8000 -b8 -e unsigned-integer - -tcoreaudio
	    echo 1>&2
	elif [[ -n "$PADSP" ]]; then
	    echo "$ echo $1 | ./endoh3 | $PADSP tee /dev/dsp > /dev/null" 1>&2
	    read -r -n 1 -p "Press any key to continue: "
	    echo 1>&2
	    echo "$1" | ./endoh3 | "$PADSP" tee /dev/dsp > /dev/null
	    echo 1>&2
	elif [[ -n "$RUBY" ]]; then
	    echo "$ echo $1 | ./endoh3 | $RUBY wavify.rb > $1.wav" 1>&2
	    read -r -n 1 -p "Press any key to continue: "
	    echo 1>&2
	    echo "$1" | ./endoh3 | "$RUBY" wavify.rb > "$1".wav
	    echo "Now try playing $1.wav in a program that plays WAV files." 1>&2
	    echo 1>&2
	else
	    echo "Please install either SoX, ruby or padsp (from PulseAudio)." 1>&2
	    echo "Tip: visit: https://www.ioccc.org/faq.html#sox" 1>&2
	    exit 1
	fi
    fi
}

if [[ "$#" -lt 1 ]]; then
    # if we have no arg just run endoh3 with twinkle.abc and the string ABC.
    endoh3 twinkle.abc
    endoh3 ABC
    endoh3 CDEFGABc
else
    # otherwise while we have an arg run endoh3 on it as a file or string
    while [[ "$#" -gt 0 ]]; do
	endoh3 "$1"
	shift 1
    done
fi
