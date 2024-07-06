#
# Anthony's Editor
#
# IOCCC 1991
#
# Winner Best Utility
#

CFLAGS	= -Os -Wno-deprecated-non-prototype -Wno-unsequenced

all: build

build: ant sleep

clean:
	-rm -f ant

ant: ant.c
	${CC} ${CFLAGS} ant.c -o $@

sleep: sleep.c
	${CC} ${CFLAGS} sleep.c -o $@
