.POSIX :

#######################################################################

CFLAGS		:= -pedantic -Wall -std=c99 -g
LDFLAGS		:=
LIBS		:=
IT		:= iocccsize

#######################################################################

all: ${IT}$E

${IT}$E: ${IT}.c
	${CC} ${CFLAGS} -o ${IT}$E ${IT}.c

#
# Exercise the IOCCC size tool.
#
test: test-k test-wc test-rcount

#
# -k should pass through the source with block comments intact.
#
test-k: ${IT}$E
	@{ t="-k keep comments" ;\
	if ./${IT} -k <${IT}.c 2>/dev/null | diff - ${IT}.c ; then echo "-OK- $$t" ; else echo "FAIL $$t" ; fi ;\
	}

#
# First 3 counters should match wc(1)
#
test-wc: ${IT}$E
	@{ t="wc counts" ;\
	a=$$(./${IT} -s -k <${IT}.c 2>&1 | cut -d' ' -f1-3) ;\
	b=$$(wc ${IT}.c | sed -e's/^ *//; s/  */ /g' | cut -d' ' -f1-3) ;\
	if [ "$$a" = "$$b" ]; then echo "-OK- $$t"; else echo "FAIL $$t: expected '$$b', got '$$a'"; fi ;\
	}

#
# Show counters for different option combinations.
#
test-show: ${IT}$E
	./${IT} -s <${IT}.c
	./${IT} -s -r <${IT}.c
	./${IT} -s -k <${IT}.c
	./${IT} -s -r -k <${IT}.c

#
# Reserved word counter should be same for all option combinations.
#
test-rcount: ${IT}$E
	@{ t="rcount" ;\
	./${IT} -s <${IT}.c 2>&1 | cut -d" " -f 6 >/tmp/$$$$.tmp ;\
	./${IT} -s -r <${IT}.c 2>&1 | cut -d" " -f 6 >>/tmp/$$$$.tmp ;\
	./${IT} -s -k <${IT}.c 2>&1 | cut -d" " -f 6 >>/tmp/$$$$.tmp ;\
	./${IT} -s -r -k <${IT}.c 2>&1 | cut -d" " -f 6 >>/tmp/$$$$.tmp ;\
	n=$$(sort -u /tmp/$$$$.tmp | wc -l | sed -e's/^ *//') ;\
	if [ $$n -eq 1 ]; then echo "-OK- $$t"; else echo "FAIL $$t: expected 1 unique line, got $$n"; echo "see make test-show"; fi ;\
	rm -f /tmp/$$$$.tmp ;\
	}

clean:
	rm -f iocccsize.o
	rm -rf iocccsize.dSYM

clobber: clean
	rm -f iocccsize

install:
	@echo "no thank you on the install :-)"
