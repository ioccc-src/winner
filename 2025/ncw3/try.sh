#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/ncw3

set -eu

PROG=./prog

say() { printf '%s\n' "$*" >&2; }

trap "printf '\n\033[0m' ; exit" INT TERM HUP EXIT

# Build if needed
if [[ ! -x "$PROG" ]]; then
  say "Building..."
  make
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

# --- SIZE CHECK ---
# We check this first to fail fast before changing terminal modes
REQUIRED_W=120
REQUIRED_H=40
CUR_W=$(tput cols)
CUR_H=$(tput lines)

if [[ $CUR_W -lt $REQUIRED_W || $CUR_H -lt $REQUIRED_H ]]; then
    echo "Error: Terminal is too small."
    echo "Current : ${CUR_W}x${CUR_H}"
    echo "Required: ${REQUIRED_W}x${REQUIRED_H}"
    echo
    echo "Hint: make the font smaller if you can't make the window big enough"
    exit 1
fi

# Truecolor hint (best effort)
case ${COLORTERM:-} in
  *truecolor*|*24bit*) : ;;
  *) say "Tip: use a truecolor terminal (24-bit) for best results." ;;
esac

# Run as a child
say "Press CTRL-C to exit"
say "Press RETURN to start the program"
say ""
export go
read -r go
"$PROG"
rc=$?

exit "$rc"
