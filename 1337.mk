
########################
# extended utility rules
########################

install:
	@echo "Dr. Spock says that is not logical!"
	@${TRUE}


######################
# clang-format options
######################

.PHONY: clang-format

# NOTE: The IOCCC Judges set CLANG_FORMAT_STYLE according to the ".clang-format" file.
#
#	https://github.com/ioccc-src/winner/blob/master/.clang-format
#
# NOTE: Please don't add "// clang-format off" to your code: that is both annoying, and is easily disabled.
#
clang-format: ${PROG}.c
	${CLANG_FORMAT} -style=file ${PROG}.c


#####################
# make a difference #
#####################

.PHONY: diff_orig_prog diff_prog_orig diff_alt_prog diff_prog_alt diff_orig_alt diff_alt_orig

# diff orig source and source
#
diff_orig_prog: ${PROG}.orig.c ${PROG}.c
	@-${DIFF} -u ${PROG}.orig.c ${PROG}.c

# diff source and orig source
#
diff_prog_orig: ${PROG}.c ${PROG}.orig.c
	@-${DIFF} -u ${PROG}.c ${PROG}.orig.c

# diff alt source and source
#
diff_alt_prog: ${PROG}.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.alt.c ${PROG}.c; \
	fi

# diff source and alt source
#
diff_prog_alt: ${PROG}.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.c ${PROG}.alt.c; \
	fi

# diff orig and alt
#
diff_orig_alt: ${PROG}.orig.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.orig.c ${PROG}.alt.c; \
	fi

# diff alt and orig
diff_alt_orig:
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.alt.c ${PROG}.orig.c; \
	fi


#############################################################
# NOTE: 'Don't Panic' if you don't understand the stuff below
#############################################################


##################
# 133t hacker rulz
##################

.PHONY: love haste waste maker easter_egg sandwich supernova more_magic magic charon pluto

love:
	@echo 'not war?'

waste:
	@echo $@

haste:
	@echo make waste
	@${MAKE} waste

maker: haste
	@echo 'Participate in a maker faire'
	@echo make love
	@${MAKE} love

easter_egg: maker
	@echo "You are expected to often misunderstand this $${RANDOM} magic, Eggy 🥚!"
	@echo "chongo '<was here>' /\\oo/\\"
	@echo "p.s.: Careful with That Axe, Eugene!"

sandwich: easter_egg
	@if [[ $$(id -u) -eq 0 ]]; then \
	    echo 'Okay 🥪.'; \
	    echo "$${RANDOM}`date +%s`$${RANDOM}" > $@; \
	else \
	    echo 'What? Make it yourself.'; \
	    echo "Did you forget the magic word?"; \
	fi

# Understand the history of the Homebrew Computer Club
# as well as the West Coast Computer Faire and
# you might be confused different.  :-)
#
supernova: sandwich
	@-if [[ -r .code_analysis ]]; then \
	    ${RM} -f .code_analysis_v7; \
	else \
	    echo "Planet deniers, like some members of the IAU, are so cute when they try to defend their logic"; \
	fi
	@echo "A $@ 💥 helps ${MAKE} the elements that help form planets"

more_magic: supernova
	@-if [[ -r .code_analysis ]]; then \
	    ccode_analysis --more_magic dd268dbcaac550362d98c384c4e576ccc8b1536847b6bbb31023b4c8caee0535 \
			   --FNV1a_hash_256_bit -v3 "${PROG}" "${PROG}.c"; \
	else \
	    echo "Wrong! Do it again!"; \
	    sleep 1; \
	    echo "Wrong! Do it again!"; \
	    sleep 1; \
	    echo "Wrong! Do it again!"; \
	fi

magic: more_magic
	@-if [[ -r .code_analysis ]]; then \
	    ccode_analysis --level 20003 --mode 5718856 --FNV1a_hash_256_bit -v3 "${PROG}" "${PROG}.c"; \
	else \
	    echo "If you don't eat yer meat, you can't have any pudding!"; \
	    echo "How can you have any pudding if you don't eat yer meat?!"; \
	fi

# The IOCCC resident astronomer states
#
charon: magic
	@echo "$@ is a dwarf planet 🪐"
	@echo "Dwarf planets 🪐🪐 are a type of planet 🪐"
	@echo "Therefore IAU, $@ is a planet 🪐"

pluto: charon
	@echo "See https://www.hou.usra.edu/meetings/lpsc2017/pdf/1448.pdf"
	@echo "for a good definition of a planet"
	@echo "$@ is a dwarf planet 🪐"
	@echo "Dwarf planets 🪐🪐 are a type of planet 🪐"
	@echo "Therefore, $@ is a planet 🪐"
	@echo "The geophysical definition of planet gives us ~110 planets 🪐🪐 in our solar system"
