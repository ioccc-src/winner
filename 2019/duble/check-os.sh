#!/bin/sh

PROGNAME="$0"
LINES="$1"
COLUMNS="$2"

if [ "$2" = "" ]
then
    echo "Usage: $0 <LINES> <COLUMNS>"
    exit 1
fi

OS=$(uname)

MAGIC_VALUE_LINUX=$(((COLUMNS*28+12)*LINES+36))

linux_min_vals() {
    cat << EOF
net.core.wmem_max                   $MAGIC_VALUE_LINUX
net.core.wmem_default               $MAGIC_VALUE_LINUX
EOF
}

MAGIC_VALUE_FREEBSD=16777216

freebsd_min_vals() {
    cat << EOF
net.local.dgram.recvspace           $MAGIC_VALUE_FREEBSD
net.local.dgram.maxdgram            $MAGIC_VALUE_FREEBSD
net.local.seqpacket.recvspace       $MAGIC_VALUE_FREEBSD
net.local.seqpacket.maxseqpacket    $MAGIC_VALUE_FREEBSD
kern.ipc.maxsockbuf                 $((4*MAGIC_VALUE_FREEBSD))
EOF
}

list_fixup_commands() {
    while read param min_value
    do
        cur_val=$(sysctl -n $param)
        if [ "$cur_val" -lt "$min_value" ]
        then
            echo "$PROGNAME -- $ sudo sysctl $param=$min_value"
        fi
    done
}

echo
echo "$PROGNAME -- Detected OS: $OS"

case "$OS" in
    "Linux")
        fixup_commands="$(linux_min_vals | list_fixup_commands)"
        ;;
    "FreeBSD")
        fixup_commands="$(freebsd_min_vals | list_fixup_commands)"
        ;;
    *)
        echo "$PROGNAME -- Sorry, the program has not been designed or tested for your OS!"
        exit 1   # failed, unknown OS
esac

if [ -z "$fixup_commands" ]
then
    echo "$PROGNAME -- Checking IPC parameters... OK!"
    echo
    exit    # script was successful
else
    cat << EOF
$PROGNAME -- Checking IPC parameters... FAILED!

$PROGNAME -- Program compiled as ${COLUMNS}x${LINES} needs higher default IPC parameters.
$PROGNAME -- Please run:
$fixup_commands

EOF
    exit 2  # failed, OS needs higher IPC parameter values.
fi
