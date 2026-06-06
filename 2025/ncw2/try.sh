#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/ncw2

set -eu

PROG=./prog

# have() { command -v "$1" >/dev/null 2>&1; }

say() { printf '%s\n' "$*" 1>&2; }

trap "printf '\n\033[0m' ; exit" INT TERM HUP EXIT

# Build if needed
if [[ ! -x "$PROG" ]]; then
  say "Building..."
  make
fi

# --- SIZE CHECK ---
# We check this first to fail fast before changing terminal modes
REQUIRED_W=40
REQUIRED_H=25
CUR_W=$(tput cols)
CUR_H=$(tput lines)

if [[ $CUR_W -lt $REQUIRED_W || $CUR_H -lt $REQUIRED_H ]]; then
    echo "Error: Terminal is too small." 1>&2
    echo "Current : ${CUR_W}x${CUR_H}" 1>&2
    echo "Required: ${REQUIRED_W}x${REQUIRED_H}" 1>&2
    echo 1>&2
    echo "Hint: make the font smaller if you can't make the window big enough" 1>&2
    exit 1
fi

# UTF-8 locale check (best effort)
LOCALE_VAR=${LC_ALL:-}
[[ -n "$LOCALE_VAR" ]] || LOCALE_VAR=${LC_CTYPE:-}
[[ -n "$LOCALE_VAR" ]] || LOCALE_VAR=${LANG:-}
case $LOCALE_VAR in
  *[Uu][Tt][Ff]-8*|*[Uu][Tt][Ff]8*) : ;;
  *)
    say "Warning: locale does not look like UTF-8 (LANG/LC_*=$LOCALE_VAR)."
    say "         If output looks wrong, try: export LANG=en_GB.UTF-8"
    ;;
esac

# Truecolor hint (best effort)
case ${COLORTERM:-} in
  *truecolor*|*24bit*) : ;;
  *) say "Tip: use a truecolor terminal (24-bit) for best results." ;;
esac

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
