#!/usr/bin/env make
#
# 2024/ferguson1

#############################
# shell used by this Makefile
#############################

SHELL= bash


#######################
# common tool locations
#######################

include ../../var.mk


#####################
# C compiler settings
#####################

# Common C compiler warnings to silence
#
# Example: CSILENCE= -Wno-poison-system-directories
#
CSILENCE= -Wno-strict-prototypes -Wno-implicit-fallthrough -Wno-misleading-indentation

# Attempt to silence unknown warning options
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
# NOTE: The addition of -pedantic to CWARN is a challenge that
#       You may wish to avoid if it proves too problematic.
#       There is NO penalty for removing -pedantic from CWARN.
#
CWARN= -Wall -Wextra -pedantic ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu17

# Compiler bit architecture
#
# Example for 32-bitness: ARCH= -m32
# Example for 64-bitness: ARCH= -m64
#
# NOTE: Normally one should NOT specify a specific architecture.
#
ARCH=

# Defines that are needed to compile
#
# The DATA define not here is primarily for portability with emojis so it's
# defined in the respective rules. It amounts to either "data" or "data.asc" (or
# "data.scrnshot") and is a data file to open.
#
CDEFINE= -DBLOCKSIZE=1663

# Include files that are needed to compile
#
# Example: CINCLUDE= -include stdio.h
#
CINCLUDE=

# Other flags to pass to the C compiler
#
# Example: COTHER= -fno-math-errno
#
COTHER=

# Optimization
#
# NOTE: Feel free to change the level of compiler optimization.
#       The "-O3" is just a friendly default you might wish to try.
#
# Example: OPT= -O0 -g
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${COTHER} ${OPT}

# Libraries needed to build
#
# Example: LDFLAGS= -lncurses -lm
#
LDFLAGS=

# C compiler to use
#
# NOTE: The IOCCC Judges recommend you leave CC as just "cc"
#       and NOT set it to clang, or gcc, or something else
#       unless you have a STRONG reason to do so.
#
#       Setting CC to something other than "cc" makes your
#       code less portable to those who do not have your
#       particular C compiler.  **hint**
#
#       If you want to test your code with a particular C compiler,
#       use the make command line.  For example:
#
#           make all CC=clang
#           make all CC=gcc
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
# NOTE: This code is only invoked when CC is "clang"
#       such as when you use the make command line:
#
#           make all CC=clang
#
CSILENCE+= -Wno-missing-prototypes -Wno-poison-system-directories -Wno-switch-default \
	-Wno-format-nonliteral -Wno-implicit-fallthrough \
	-Wno-misleading-indentation -Wno-missing-variable-declarations \
	-Wno-shorten-64-to-32 -Wno-unreachable-code -Wno-unsafe-buffer-usage
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq "$(findstring $(GCC),${CC})" "$(GCC)"
#
# NOTE: This code is only invoked when CC is "gcc"
#       such as when you use the make command line:
#
#    make all CC=gcc
#
CSILENCE+=
#
CWARN+=
#
endif


###########################################
# Special Makefile variables for this entry
###########################################

ENTRY= prog
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
TARGET= ${PROG} ${PROG}.asc ${PROG}.scrnshot

# .alt is as above more events
#
ALT_OBJ= ${PROG}.alt.o ${PROG}.alt.asc.o ${PROG}.alt.scrnshot.o
ALT_TARGET= ${PROG}.alt ${PROG}.alt.asc ${PROG}.alt.scrnshot

# list any data files supplied with the submission
#
# Don't include data, data.asc or data.scrnshot.
# The data rule (although it's better to use makedata the data rule might work -
# or it might not) is needed.
#
# The build of the programs use make padding however.
#
# I discuss the data files in obfuscation.md in more detail and I also mention
# them in remarks.md (to do with troubleshooting and notes to the judges).
#
# As I noted in the remarks.md you should always make sure to rebuild them if
# there is some kind of error: basically a pre-process for the code. No issues
# have occurred since I added the build of the data files in the build of the
# program but it is theoretically possible.
#
# It isn't always necessary to build the data files but when developing it was
# VERY necessary hence all the protections in place (and the discussion in the
# remarks.md). In any event the data files are built at build time so they
# should not be in this variable.
#
# Observe too that the rules to compile programs do NOT depend on the data rule
# and also do not depend on DATA (most anyway if not all). This is to help
# prevent the programs being compiled every time the data files are updated.
#
DATA= data.src data.asc.src data.scrnshot.src


#################
# build the entry
#################

all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything clean clobber test

# how to compile
#
${PROG}: ${PROG}.c
	${MAKE} padding
	${CC} ${CFLAGS} -DDATA='"data"' ${PROG}.c -o $@ ${LDFLAGS}

# test rule to make sure that no string in the data files are >= the blocksize
# and the ASCII only data file does not have multibyte characters (or at least
# 2, 3 or 4 bytes - unsure if more bytes in a single character is possible).
#
# The compilation rules use this to make sure there are no problems and it will
# exit non-zero if there is any issue thus preventing the build of the specific
# program.
#
test: lencount mbcheck
	@./lencount -t -i data.src
	@./lencount -t -i data.asc.src
	@./lencount -t -i data.scrnshot.src
	@./mbcheck

# ASCII only version of submission code, hence why the DATA macro is defined
# here, not in CDEFINE.
#
${PROG}.asc: ${PROG}.c
	${MAKE} padding
	${CC} ${CFLAGS} -DDATA='"data.asc"' ${PROG}.c -o $@ ${LDFLAGS}

# screenshot friendly version
#
${PROG}.scrnshot: ${PROG}.c
	${MAKE} padding
	${CC} ${CFLAGS} -DDATA='"data.scrnshot"' ${PROG}.c -o $@ ${LDFLAGS}

# this tool creates the data files (emoji and ASCII only versions).
#
# The warnings disabled are unfortunate. One is actually an extra sanity check
# in case the exit(1); call was removed by mistake.
#
addpadding: addpadding.c
	${CC} ${CFLAGS} -Wno-unreachable-code-break -Wno-sign-conversion  addpadding.c -o $@ ${LDFLAGS}

# this tool is the first step in helping some of the other tools work, as a
# pre-processor. This tool is used in the makedata.sh script which is also a
# pre-processor and must happen if the data source files are updated (which
# should really only be done by me, the author, as I'm the only one who knows
# precisely how it works and how perilous it can be to edit).
#
bytecount: bytecount.c
	${CC} ${CFLAGS} -Wno-unreachable-code-break bytecount.c -o $@ ${LDFLAGS}

# this tool helped me verify the locations of strings were correct (locations
# are based on the blocksize). The bytecount also helped.
#
bytetest: bytetest.c
	${CC} ${CFLAGS}  bytetest.c -o $@ ${LDFLAGS}

# similar to bytecount but it doesn't print out the location and it also parses
# the file without caring about the NUL bytes (see if you can figure that out)
#
byteread: byteread.c
	${CC} ${CFLAGS}  byteread.c -o $@ ${LDFLAGS}

# this tool was helpful to help identify if any emojis in the ASCII only version
# slipped through (however, mbcheck is a better one: this tool is still
# useful however). Probably only the judges will find this interesting just like
# most of the tools I have provided.
#
bytecheck: bytecheck.c
	${CC} ${CFLAGS} -Wno-unreachable-code-break bytecheck.c -o $@ ${LDFLAGS}

# by default this checks for multibyte characters (well 2, 3, 4) in the ASCII
# data source file, reporting if any are found. If any are found it will report
# which string so it can be fixed.
#
mbcheck: mbcheck.c
	${CC} ${CFLAGS} -Wno-unreachable-code-break mbcheck.c -o $@ ${LDFLAGS}

# prints the strings in the data file for visual inspection. This could be
# useful to check if your system supports all the emojis, although obviously
# you'll need some sort of scrollback (or use less, perhaps with -r/-R - or
# possibly redirect to a file if that is equivalent but if it is you could just
# look at the strings.*loc.txt files).
#
printer: printer.c
	${CC} ${CFLAGS} -Wno-unreachable-code-break printer.c -o $@ ${LDFLAGS}

# counts number of strings in data file and returns the longest one. Used in
# calculating the blocksize (originally). It also warns about strings that are
# >= the BLOCKSIZE in length. >= because we need the NUL byte too! With -t it
# exits 666 if the blocksize is breached by a string.
#
lencount: lencount.c
	${CC} ${CFLAGS} -Wno-unreachable-code-break lencount.c -o $@ ${LDFLAGS}


# IMPORTANT NOTES FOR THE JUDGES.
#
# The makedata.sh script will generate files that are needed by some of the
# extra tools that I had to write and those tools should in general not be
# needed by most. I include them to be complete and so you can see my very
# thorough and careful design.
#
# The addpadding.c is necessary but it does not depend on makedata.sh and in
# fact makedata.sh uses it.
#
# The addpadding tool ALWAYS updates all three data files, assuming the source
# files exist of course; if they don't then obviously there is an error but as I
# provide them this should not happen unless the Devil has visited you in the
# night (in which case you might want to be worried, very worried, that
# something might happen! :-) - maybe declare it a winner to satisfy the Devil?
# :-) Okay joking aside you get the idea: this should not happen as the source
# files and this tool are included.
#
# When in doubt, make sure the right data file is used (the different compiled
# binaries based on the DATA macro) and that it was created by addpadding.c! And
# do make sure you use the right version of addpadding.c - this submission does
# NOT encrypt the data and the other one does! In fact there is an explicit
# comment in addpadding.c about this.
#
padding: addpadding test
	@echo "Creating data file..."
	./addpadding
	@echo "Done."

# see remarks.md for more details. This script is mostly useful for the some of
# the other tools but it can be used for prog.c and prog.alt.c indirectly as it
# also does build the data files from the source files.
#
# An example use of when I personally use this rule: when I actually make an
# edit to the data source files. As you will probably have noticed the printer.c
# and bytetest.c tools depend on V.c and makedata.sh creates it so I have those
# tools use that script too.
#
makedata: makedata.sh
	./makedata.sh

# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

# Devil's Cut: extra events that couldn't fit in the prog.c (alas!)
#
# As noted the DATA macro is for portability.
#
${PROG}.alt: ${PROG}.alt.c
	${MAKE} padding
	${CC} ${CFLAGS} -DDATA='"data"' ${PROG}.alt.c -o $@ ${LDFLAGS}

# ASCII only version of alt code (Devil's Cut above). This is why indeed the
# DATA variable is not in the CDEFINE - the .asc versions use the data.asc file.
#
${PROG}.alt.asc: ${PROG}.alt.c
	${MAKE} padding
	${CC} ${CFLAGS} -DDATA='"data.asc"' ${PROG}.alt.c -o $@ ${LDFLAGS}

# screenshot friendly version of alt code
#
${PROG}.alt.scrnshot: ${PROG}.alt.c
	${MAKE} padding
	${CC} ${CFLAGS} -DDATA='"data.scrnshot"' ${PROG}.alt.c -o $@ ${LDFLAGS}

# data files
#
data: ${DATA}
	@${TRUE}

# both all and alt
#
everything: all alt
	@${TRUE}


###############
# utility rules
###############
#
clean:
	${RM} -f ${OBJ} ${ALT_OBJ}

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM
	${RM} -rf ${TARGET} addpadding bytetest byteread bytecount printer lencount bytecheck mbcheck data data.asc data.scrnshot


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
