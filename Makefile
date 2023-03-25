#!/usr/bin/env make
#
# IOCCC Makefile

################################################################################
#
# Regarding individual entries:
#
# IOCCC winning entry code may not work on your system.  Even with standards,
# conditions and build environments change, especially when it comes to more
# extreme code such you might find in an IOCCC winner.  Moreover, what was
# allowed and liked in one IOCCC contest may no longer be liked/allowed in
# later IOCCC years.
#
# Corrections on winning author and fixing typos in remarks are VERY WELCOME.
#
# GitHub pull requests are welcome:
#
# If you have a patch that might make running an entry work in modern Unix-like
# environments, please create a GitHub pull request for the IOCCC judges to
# consider.
#
# Suggestions and corrections regarding Makefiles, winning author information,
# fixing typos in remarks, and code patches are welcome via opening a GitHub
# issue or better yet, by creating a GitHub pull request for the IOCCC judges
# to consider.  To form a GitHub issue or GitHub pull, please visit:
#
# https://github.com/ioccc-src/winner
#
################################################################################

# This work by Landon Curt Noll and Leonid A. Broukhis is licensed under:
#
#	Creative Commons Attribution-ShareAlike 3.0 Unported License.
#
# See: http://creativecommons.org/licenses/by-sa/3.0/


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
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

.PHONY: all alt data everything clean clobber install \
        love haste waste maker easter_egg sandwich \
        supernova deep_magic magic charon pluto

# alternative executable
#
alt:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# data files
#
data:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

# both all and alt
#
everything:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


###############
# utility rules
###############
#
clean:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

clobber:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

install:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

indent.c:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


##################
# 133t hacker rulz
##################
#
love:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

haste:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

waste:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

maker:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

easter_egg:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

sandwich:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='


# The IOCCC resident astronomer states
#
supernova:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

deep_magic:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

magic:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

charon:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='

pluto:
	@echo '=-=-=-=-= IOCCC begin make $@ =-=-=-=-='
	@-for i in [12][0-9][0-9]?; do \
            if [ -f $$i/Makefile ]; then \
                echo "cd $$i; make all"; \
                (cd $$i; make all); \
            fi; \
        done
	@echo '=-=-=-=-= IOCCC complete make $@ =-=-=-=-='
