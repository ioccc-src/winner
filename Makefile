#!/usr/bin/env make
#
# IOCCC Makefile

################################################################################
#
# IOCCC winning entry code may not work on your system.  What was liked/allowed
# and worked in the past may no longer be liked/allowed or compile/run today.
#
# Bug fixes, corrections and typo fixes are VERY WELCOME.  If you see a problem,
# first check this URL for a list of known bugs and (mis)features of IOCCC winners:
#
#	https://www.ioccc.org/bugs.md
#
# GitHub pull requests are welcome!  Please see the above URL for details.
#
################################################################################
#
# This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
# You are free to share and adapt this file under the terms this license:
#
#	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
#
# For more information, see: https://creativecommons.org/licenses/by-sa/4.0/


#############################
# shell used by this Makefile
#############################
#
SHELL= bash

#######################
# common tool locations
#######################
#
include var.mk


###################
# build all entries
###################
#
all:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

.PHONY: all alt data everything orig_prog_diff alt_prog_diff \
	clean clobber install love haste waste maker easter_egg \
	sandwich supernova deep_magic magic charon pluto

# alternative executable
#
alt:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# data files
#
data:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# both all and alt
#
everything:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff orig source and source
#
orig_prog_diff:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# diff alt source and source
#
alt_prog_diff:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


###############
# utility rules
###############
#
clean:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

clobber:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

install:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

indent.c:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


##################
# 133t hacker rulz
##################
#
love:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

haste:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

waste:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

maker:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

easter_egg:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

sandwich:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


# The IOCCC resident astronomer states
#
supernova:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

deep_magic:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

magic:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

charon:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

pluto:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9][0-9]; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make $@"; \
                (cd $$i; make $@); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='
