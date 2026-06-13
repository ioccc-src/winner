#!/usr/bin/env bash
#
# try.alt.sh - demonstration of 2025/ncw2

set -eu

PROG=./prog.alt

# have() { command -v "$1" >/dev/null 2>&1; }

say() { printf '%s\n' "$*" 1>&2; }

# trap "printf '\n\033[0m' ; exit" INT TERM HUP EXIT

# Build if needed
if [[ ! -x "$PROG" ]]; then
  say "Building..."
  make "$PROG"
fi

# clear the screen
#
clear

# Run as a child
say "Press CTRL-C to exit"
say "Press RETURN to start the program"
say ""
export go
read -r go
"$PROG"
rc=$?

exit "$rc"
