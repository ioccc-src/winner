#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 2000/natori alternate code
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

NATORI="natori"
moon()
{
    read -r -n 1 -p "Press any key to randomly show the northern/southern hemisphere Moon: "
    echo 1>&2
    for ((i=0;i<=10;i++)); do
	RAND=$((RANDOM % 1000))
	if [[ "$RAND" -le 500 ]]; then
	    ./"$NATORI".alt
	    echo 1>&2
	else
	    ./"$NATORI"
	    echo 1>&2
	fi

	if [[ "$i" != 10 ]]; then
	    read -r -n 1 -p "Press any key to continue: "
	    echo 1>&2
	fi
    done

    echo 1>&2
    RAND=$((RANDOM % 1000))
    if [[ "$RAND" -gt 500 ]]; then
	read -r -n 1 -p "Press any key to alternate between the southern/northern hemisphere Moon: "
	echo 1>&2
	./"$NATORI".alt
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI"
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI".alt
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI"
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI".alt
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI"
    else
	read -r -n 1 -p "Press any key to alternate between the northern/southern hemisphere Moon: "
	echo 1>&2
	./"$NATORI"
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI".alt
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI"
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI".alt
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI"
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI".alt
    fi

    echo 1>&2
    echo "We will now reverse the order." 1>&2
    echo 1>&2

    if [[ "$RAND" -le 499 ]]; then
	read -r -n 1 -p "Press any key to alternate between the southern/northern hemisphere Moon: "
	echo 1>&2
	./"$NATORI".alt
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI"
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI".alt
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI"
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI".alt
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI"
    else
	read -r -n 1 -p "Press any key to alternate between the northern/southern hemisphere Moon: "
	echo 1>&2
	./"$NATORI"
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI".alt
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI"
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI".alt
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI"
	read -r -n 1 -p "Press any key to continue: "
	echo 1>&2
	./"$NATORI".alt
    fi

    echo 1>&2
    echo "Will now use less(1): 'q' = quit, space = next page, enter = next line." 1>&2
    echo "We recommend that you try holding space down." 1>&2
    echo 1>&2
    RAND=$((RANDOM % 1000))
    if [[ "$RAND" -gt 500 ]]; then
	read -r -n 1 -p "Press any key to alternate between the southern/northern hemisphere Moon: "
	echo 1>&2
	( ./"$NATORI.alt"; ./"$NATORI" ; ./"$NATORI.alt" ; ./"$NATORI"; \
	    ./"$NATORI.alt"; ./"$NATORI" ) | less -rEXF
    else
	read -r -n 1 -p "Press any key to alternate between the northern/southern hemisphere Moon: "
	echo 1>&2
	( ./"$NATORI"; ./"$NATORI.alt" ; ./"$NATORI" ; ./"$NATORI.alt"; \
	    ./"$NATORI"; ./"$NATORI.alt" ) | less -rEXF
    fi

    echo 1>&2
    echo "Will now use less(1): 'q' = quit, space = next page, enter = next line." 1>&2
    echo "We now recommend that you try holding enter down." 1>&2
    echo 1>&2
    if [[ "$RAND" -gt 500 ]]; then
	read -r -n 1 -p "Press any key to alternate between the southern/northern hemisphere Moon: "
	echo 1>&2
	( ./"$NATORI.alt"; ./"$NATORI" ; ./"$NATORI.alt" ; ./"$NATORI"; \
	    ./"$NATORI.alt"; ./"$NATORI" ) | less -rEXF
    else
	read -r -n 1 -p "Press any key to alternate between the northern/southern hemisphere Moon: "
	echo 1>&2
	( ./"$NATORI"; ./"$NATORI.alt" ; ./"$NATORI" ; ./"$NATORI.alt"; \
	    ./"$NATORI"; ./"$NATORI.alt" ) | less -rEXF
    fi
    echo 1>&2

    echo "We will now reverse the order." 1>&2
    echo 1>&2
    echo "Will now use less(1): 'q' = quit, space = next page, enter = next line." 1>&2
    echo "We recommend that you try holding space down." 1>&2
    echo 1>&2
    if [[ "$RAND" -le 499 ]]; then
	read -r -n 1 -p "Press any key to alternate between the southern/northern hemisphere Moon: "
	echo 1>&2
	( ./"$NATORI.alt"; ./"$NATORI" ; ./"$NATORI.alt" ; ./"$NATORI"; \
	    ./"$NATORI.alt"; ./"$NATORI" ) | less -rEXF
    else
	read -r -n 1 -p "Press any key to alternate between the northern/southern hemisphere Moon: "
	echo 1>&2
	( ./"$NATORI"; ./"$NATORI.alt" ; ./"$NATORI" ; ./"$NATORI.alt"; \
	    ./"$NATORI"; ./"$NATORI.alt" ) | less -rEXF
    fi

    echo 1>&2
    echo "Will now use less(1): 'q' = quit, space = next page, enter = next line." 1>&2
    echo "We now recommend that you try holding enter down." 1>&2
    echo 1>&2
    if [[ "$RAND" -le 499 ]]; then
	read -r -n 1 -p "Press any key to alternate between the southern/northern hemisphere Moon: "
	echo 1>&2
	( ./"$NATORI.alt"; ./"$NATORI" ; ./"$NATORI.alt" ; ./"$NATORI"; \
	    ./"$NATORI.alt"; ./"$NATORI" ) | less -rEXF
    else
	read -r -n 1 -p "Press any key to alternate between the northern/southern hemisphere Moon: "
	echo 1>&2
	( ./"$NATORI"; ./"$NATORI.alt" ; ./"$NATORI" ; ./"$NATORI.alt"; \
	    ./"$NATORI"; ./"$NATORI.alt" ) | less -rEXF
    fi
    echo 1>&2

    # Finally, for the try.alt.sh (alternate code, southern hemisphere), force
    # starting with southern hemisphere.
    echo "Will now use less(1): 'q' = quit, space = next page, enter = next line." 1>&2
    echo "We now recommend that you try holding enter down." 1>&2
    read -r -n 1 -p "Press any key to alternate between the southern/northern hemisphere Moon: "
    echo 1>&2
    ( ./"$NATORI.alt"; ./"$NATORI" ; ./"$NATORI.alt" ; ./"$NATORI"; \
	./"$NATORI.alt"; ./"$NATORI" ) | less -rEXF

    echo 1>&2

}

# show the Moon phase in artistic ways!
moon
