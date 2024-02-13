#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2006/hamre
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



read -r -n 1 -p "Press any key to run: ./hamre '-1*42/3*(42*42*42)/42': "
echo 1>&2
./hamre '-1*42/3*(42*42*42)/42'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamre '-1+4/3*(2+1/(3/2*(7/2-7/3+1/6)))/2': "
echo 1>&2
./hamre '-1+4/3*(2+1/(3/2*(7/2-7/3+1/6)))/2'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./hamre '1/0': "
echo 1>&2
./hamre '1/0' 1>&2
echo 1>&2
echo "...why did you not get an answer?" 1>&2
echo 1>&2

LIFE=12
UNIVERSE=15
EVERYTHING=15
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "For the next two notice how similar they are: why do they give different answers?" 1>&2

echo "$ LIFE=12; UNIVERSE=15; EVERYTHING=15; ./hamre \"\$LIFE/\$UNIVERSE/\$EVERYTHING\"" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./hamre "$LIFE/$UNIVERSE/$EVERYTHING"
echo 1>&2

echo "$ LIFE=12; UNIVERSE=15; EVERYTHING=15; ./hamre \"\$LIFE / \$UNIVERSE / \$EVERYTHING\"" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./hamre "$LIFE / $UNIVERSE / $EVERYTHING"

echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "And why do these next two give different answers?" 1>&2
echo "$ LIFE=12; UNIVERSE=15; EVERYTHING=15; ./hamre \"\$LIFE + \$UNIVERSE + \$EVERYTHING\"" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./hamre "$LIFE + $UNIVERSE + $EVERYTHING"
echo "$ LIFE=12; UNIVERSE=15; EVERYTHING=15; ./hamre \"\$LIFE+\$UNIVERSE+\$EVERYTHING\"" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./hamre "$LIFE+$UNIVERSE+$EVERYTHING"
echo 1>&2

echo "As it turns out, \$LIFE+\$UNIVERSE+\$EVERYTHING == 42/1 == 42!" 1>&2

exit 0
