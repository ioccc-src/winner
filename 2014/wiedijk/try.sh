#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2014/wiedijk
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


# Make sure that indent(1) and sed(1) are installed but let user override them
# as well say for using a different beautifier. We assume less(1) is installed.
if [[ -z "$INDENT" ]]; then
    INDENT="$(type -P indent)"
else
    INDENT="$(type -P "$INDENT")"
    [[ ! -f "$INDENT" || ! -x "$INDENT" ]] && INDENT="$(type -P indent)"
fi
if [[ ! -x "$INDENT" ]]; then
    echo "$0: cannot find indent, sorry." 1>&2
    exit 1
fi

if [[ -z "$SED" ]]; then
    SED="$(type -P sed)"
else
    SED="$(type -P "$SED")"
    [[ ! -f "$SED" || ! -x "$SED" ]] && SED="$(type -P sed)"
fi
if [[ ! -x "$SED" ]]; then
    echo "$0: cannot find sed, sorry." 1>&2
    exit 2
fi

echo "$ $CC -E prog.c | $INDENT |
    $SED '1,/5.*prog/d'"
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
"$CC" -E prog.c | "$INDENT" | "$SED" '1,/5.*prog/d' | less -EXF
