#!/usr/bin/env bash
#
# Try and determine full screen size for make fullscreen rule.
#
TPUT="$(type -P tput)"

if [[ -z "$TPUT" ]]; then
    echo "No tput found, try:" >&2
    echo >&2
    echo "  make clobber LINES=\$LINES COLUMNS=\$COLUMNS all" >&2
    echo >&2
    echo "or to specify a specific size:" >&2
    echo >&2
    echo "  make clobber LINES=20 COLUMNS=20 all" >&2
    echo >&2
    echo "or whatever you wish the lines and columns to be." >&2
    exit 1
else
    make clobber all LINES="$($TPUT lines)" COLUMNS="$($TPUT cols)"
fi
