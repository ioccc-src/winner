#!/bin/ksh
# Assume a POSIX compliant shell.

PROG="./prog"

args=$(getopt 'f:w' $*)
if [ $? -ne 0 ]; then
	echo "usage: prog-test.sh [-w][-f flags]"
	exit 2
fi
set -- $args
while [ $# -gt 0 ]; do
	case "$1" in
	-w)
		PROG="./prog-w64"
		;;
	-f)
		flags=$2; shift
		;;
	--)
		shift; break
		;;
	esac
	shift
done

function distance
{
	typeset A="$1"; shift
	typeset B="$1"; shift
	typeset expect="$1"; shift

	printf "$A" | sed -e 's/./&\
/g' >$A.tmp
	printf "$B" | sed -e 's/./&\
/g' >$B.tmp

	echo "<<< A='$A' B='$B' $@"
	typeset dist=$($PROG -d $@ $A.tmp $B.tmp | tr -d '\r')

	printf '>>> got=%d expect=%d ' "$dist" "$expect"

	if [ "$dist" -ne "$expect" ]; then
		echo FAIL
		return 1
	fi

	echo -OK-
	return 0
}

function dif
{
	typeset A="$1"; shift
	typeset B="$1"; shift
	typeset expect="$1"; shift

	echo "==== $A $B"
	$PROG $A $B | tee patch.tmp
	typeset ex=$?

	if [ "$expect" -eq 0 ]; then
		printf "got=%d expect=%d " $ex $expect
		if [ $expect -ne $ex ]; then
			echo FAIL
			return 1
		fi
		echo -OK-
		return 0
	fi

	printf "forward patch "
	cp $A copy.tmp
	if ! patch -f -s copy.tmp patch.tmp ; then
		echo FAIL
		return 1
	fi
	echo -OK-

	printf "forward compare "
	if ! cmp $B copy.tmp ; then
		echo FAIL
		return 1
	fi
	echo -OK-

	printf "reverse patch "
	if ! patch -R -f -s copy.tmp patch.tmp ; then
		echo FAIL
		return 1
	fi
	echo -OK-

	printf "reverse compare "
	if ! cmp $A copy.tmp ; then
		echo FAIL
		return 1
	fi
	echo -OK-

	return 0
}

distance "1" "1" 0 $flags
distance "1" "A" 2 $flags
distance "123" "ABCDE" 8 $flags
distance "ABCDE" "123" 8 $flags
distance "ABD" "ABCD" 1 $flags
distance "ABCD" "ABD" 1 $flags
distance "ABCD" "ACDBECFD" 4 $flags
distance "ABCDEF" "ABXYEFCD" 6 $flags
distance "ABCDEFGHIJK" "ABCEFGIJKDEFGHIJK" 6 $flags
distance "ABCABBA" "CBABAC" 5 $flags
distance "ACEBDABBABED" "ACBDEACBED" 6 $flags

touch EMPTY.tmp
dif 1.tmp 1.tmp 0
dif EMPTY.tmp 123.tmp 1
dif 123.tmp EMPTY.tmp 1
dif ABCD.tmp ACDBECFD.tmp 1
dif ACDBECFD.tmp ABCD.tmp 1
dif 123.tmp ABCDE.tmp 1
dif ABCDE.tmp 123.tmp 1

# Note that prog and diff(1) have same edit distance,
# but differ in the output.
dif CBABAC.tmp ABCABBA.tmp 1
dif ABCABBA.tmp CBABAC.tmp 1

rm copy.tmp* 2>/dev/null

echo DONE
