#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/zeitak
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

# assume no error: set ERROR to 0
ERROR=0

read -r -n 1 -p "Press any key to test zeitak.c for nesting errors: "
echo 1>&2
./zeitak < zeitak.c
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 3 ]]; then
    echo "Error: did not get exit code 3: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

echo "$ cat anonymous.c" 1>&2
cat anonymous.c
echo 1>&2
read -r -n 1 -p "Press any key to test anonymous.c for nesting errors: "
echo 1>&2
./zeitak < anonymous.c
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 3 ]]; then
    echo "Error: did not get exit code 3: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

echo "$ cat anonymous.alt.c" 1>&2
cat anonymous.alt.c
echo 1>&2
read -r -n 1 -p "Press any key to test anonymous.alt.c for nesting errors: "
echo 1>&2
./zeitak < anonymous.alt.c
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 3 ]]; then
    echo "Error: did not get exit code 3: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

echo "$ cat incorrect.brace.c" 1>&2
cat incorrect.brace.c
echo 1>&2
read -r -n 1 -p "Press any key to test incorrect.brace.c: "
echo 1>&2
./zeitak < incorrect.brace.c
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 10 ]]; then
    echo "Error: did not get exit code 10: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

echo "$ cat incorrect.bracket.c" 1>&2
cat incorrect.bracket.c
echo 1>&2
read -r -n 1 -p "Press any key to test incorrect.bracket.c: "
echo 1>&2
./zeitak < incorrect.bracket.c
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 10 ]]; then
    echo "Error: did not get exit code 10: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

echo "$ cat incorrect.paren.c" 1>&2
cat incorrect.paren.c
echo 1>&2
read -r -n 1 -p "Press any key to test incorrect.paren.c: "
echo 1>&2
./zeitak < incorrect.paren.c
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 10 ]]; then
    echo "Error: did not get exit code 10: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

echo "$ cat incorrect.quote-esc.c" 1>&2
cat incorrect.quote-esc.c
echo 1>&2
read -r -n 1 -p "Press any key to test incorrect.quote-esc.c: "
echo 1>&2
./zeitak < incorrect.quote-esc.c
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 10 ]]; then
    echo "Error: did not get exit code 10: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

echo "$ cat incorrect.3.quotes.c" 1>&2
cat incorrect.3.quotes.c
echo 1>&2
read -r -n 1 -p "Press any key to test incorrect.3.quotes.c: "
echo 1>&2
./zeitak < incorrect.3.quotes.c
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 10 ]]; then
    echo "Error: did not get exit code 10: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

echo "$ cat incorrect.single.quote.c" 1>&2
cat incorrect.single.quote.c
echo 1>&2
read -r -n 1 -p "Press any key to test incorrect.single.quote.c: "
echo 1>&2
./zeitak < incorrect.single.quote.c
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 10 ]]; then
    echo "Error: did not get exit code 10: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

echo "$ cat incorrect.1.quote.c" 1>&2
cat incorrect.1.quote.c
echo 1>&2
read -r -n 1 -p "Press any key to test incorrect.1.quote.c: "
echo 1>&2
./zeitak < incorrect.1.quote.c
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 10 ]]; then
    echo "Error: did not get exit code 10: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

echo "$ cat incorrect.txt" 1>&2
cat incorrect.txt
echo 1>&2
read -r -n 1 -p "Press any key to test incorrect.txt: "
echo 1>&2
./zeitak < incorrect.txt
EXIT_CODE="$?"
if [[ "$EXIT_CODE" -ne 10 ]]; then
    echo "Error: did not get exit code 10: $EXIT_CODE" 1>&2
    ERROR=1
fi
echo 1>&2

exit "$ERROR"
