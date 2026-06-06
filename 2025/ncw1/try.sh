#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/ncw1

# Default ROM file - defaults to showing a menu one not given on the command line
ROM_FILE="${1}"
ROMS_DIR="roms"
PROG=${PROG:-./prog}

# Build if needed
if [[ ! -x "$PROG" ]]; then
    printf "Building...\n"
    if [[ -f "Makefile.ioccc" ]]; then
        make -f Makefile.ioccc
    else
        make
    fi
fi

# --- SIZE CHECK ---
# We check this first to fail fast before changing terminal modes
REQUIRED_W=160
REQUIRED_H=73
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

# --- CLEANUP FUNCTION ---
cleanup() {
    # Restore terminal settings
    if [[ -n "$ORIG_STTY" ]]; then
        stty "$ORIG_STTY"
    else
        stty sane
    fi

    # Visual Cleanup:
    # - Reset colors (0m)
    # - Move cursor to bottom
    # - Show Cursor (?25h)
    local height
    height=$(tput lines 2>/dev/null || echo 24)
    printf "%s" "\033[0m\033[${height};0H\033[?25h"
}

# --- TRAP SETTINGS ---
# Save original settings
ORIG_STTY=$(stty -g)

# Run cleanup whenever the script exits (normally or via exit command)
trap cleanup EXIT

# If CTRL-C (INT) or kill (TERM) is received, explicitly EXIT.
#    This forces the loop to stop and triggers the EXIT trap above.
trap "exit 1" INT TERM HUP

# --- DOWNLOAD OSS ROMS ---

fetch() {
    local url="$1"
    local filename="$2"
    local filepath="roms/$filename"

    if [[ -f "$filepath" ]]; then
        echo "Skipping $filename (already exists)."
        return
    fi

    echo -n "Downloading $filename..."

    # Attempt download
    # -L: Follow redirects (needed for GitHub raw links)
    # -f: Fail silently on HTTP errors (so we can catch the exit code)
    # -o: Write output to file
    # -s: Silent mode (hide progress bar)
    if curl -L -f -s -o "$filepath" "$url"; then
        echo "OK"
    else
        echo "FAILED"
    fi
}

download_roms() {
    if [[ -f "roms/TicTacToe.gb" && -f "roms/Breakout.gb" && -f "roms/GameOfLife.gb" && -f "roms/2048.gb" ]]; then
       return
    fi

    read -r -p "Download Open Source ROMs? (y/n) " response

    if [[ "$response" =~ ^[Yy] ]]; then
        mkdir -p roms
        fetch "https://github.com/flozz/gameboy-examples/raw/refs/heads/master/03-tic-tac-toe/tictactoe.gb" "TicTacToe.gb"
        fetch "https://github.com/flozz/gameboy-examples/raw/refs/heads/master/10-breakout/breakout.gb" "Breakout.gb"
        fetch "https://github.com/msklywenn/GB-GameOfLife/raw/refs/heads/master/rom.gb" "GameOfLife.gb"
        fetch "https://github.com/wyattferguson/2048-gb/raw/refs/heads/master/2048.gb" "2048.gb"
        echo "Download complete."
    else
        echo "Download cancelled."
    fi
}

# --- MENU SELECTION LOGIC ---

if [[ -z "$ROM_FILE" && -d "$ROMS_DIR" ]]; then
    download_roms

    shopt -s nullglob
    rom_list=("$ROMS_DIR"/*.gb)
    count=${#rom_list[@]}

    if [[ $count -eq 0 ]]; then
        echo "No *.gb files found in $ROMS_DIR/"
        exit 1
    fi

    # Calculate width
    max_len=12
    for f in "${rom_list[@]}"; do
        fname=$(basename "$f")
        len=${#fname}
        if (( len > max_len )); then max_len=$len; fi
    done

    inner_width=$((max_len + 2))
    hbar=""
    for ((i=0; i<inner_width; i++)); do hbar="${hbar}─"; done

    # Configure terminal for Menu
    stty -echo -icanon min 1 time 0
    printf "\033[?25l\033[2J"

    selected=0

    while true; do
        printf "\033[H"

        # Top
        printf " ┌%s┐\033[K\n" "$hbar"

        # Title
        title="SELECT ROM"
        t_len=${#title}
        pad_left=$(( (inner_width - t_len) / 2 ))
	# Here be magic
        printf " │%*s%s%*s│\033[K\n" "$pad_left" "" "$title" $((inner_width - t_len - pad_left)) ""

        # Separator
        printf " ├%s┤\033[K\n" "$hbar"

        # List
        for ((i=0; i<count; i++)); do
            filename=$(basename "${rom_list[$i]}")
            if [[ $i -eq $selected ]]; then
                printf " │\033[7m %-*s \033[0m│\033[K\n" $((inner_width - 2)) "$filename"
            else
                printf " │ %-*s │\033[K\n" $((inner_width - 2)) "$filename"
            fi
        done

        # Bottom
        printf " └%s┘\033[K\n" "$hbar"
        printf "\033[0J"

        # Input
        # We check exit status of read to stop loop immediately on interrupt
        read -rsn1 key || exit 1

        if [[ $key == $'\x1b' ]]; then
            read -rsn2 -t 0.1 k2
            if [[ $k2 == "[A" ]]; then # Up
                ((selected--))
                [[ $selected -lt 0 ]] && selected=$((count-1))
            elif [[ $k2 == "[B" ]]; then # Down
                ((selected++))
                [[ $selected -ge $count ]] && selected=0
            fi
        elif [[ $key == "" ]]; then # Enter
            ROM_FILE="${rom_list[$selected]}"
            break
        elif [[ $key == "q" ]]; then
            exit 0
        fi
    done

    # --- CONTROLS SCREEN ---

    # Ensure terminal is set to hidden cursor and blocking input (in case menu was skipped)
    stty -echo -icanon min 1 time 0
    printf "\033[?25l\033[2J\033[H"

    printf "\n"
    printf "  ┌─────────────────────────────────┐\n"
    printf "  │         GAME BOY CONTROLS       │\n"
    printf "  ├─────────────────┬───────────────┤\n"
    printf "  │  W / A / S / D  │  D-Pad        │\n"
    printf "  │  J              │  B Button     │\n"
    printf "  │  K              │  A Button     │\n"
    printf "  │  SPACE          │  Select       │\n"
    printf "  │  RETURN         │  Start        │\n"
    printf "  ├─────────────────┴───────────────┤\n"
    printf "  │ \033[1;31m      Use CTRL-C to Quit  \033[0m      │\n"
    printf "  └─────────────────────────────────┘\n"
    printf "\n"
    printf "   Press any key to start..."

    # Wait for keypress
    read -rsn1 || exit 1
fi

if [[ ! -f "$ROM_FILE" ]]; then
    echo "Error: File '$ROM_FILE' not found." >&2
    exit 1
fi

# --- EMULATOR EXECUTION ---

# Configure Terminal
# raw   : raw input (no buffering)
# isig  : ENABLE signals (Ctrl-C sends SIGINT, Ctrl-Z sends SIGTSTP)
# opost : ENABLE output processing (so newlines work)
# -echo: stop printing keys pressed
# min 0 time 0: makes read() return immediately (non-blocking substitute)
stty raw isig opost -echo min 0 time 0
printf "\033[?25l\033[2J\033[H"

# Run Emulator
# We pass the ROM file into File Descriptor 3
$PROG 3< "$ROM_FILE"
