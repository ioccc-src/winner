#
#	Test makefile for AM
#

#
#  Allow for empty macros.
#
EMPTY=

#
#  Allow for white space in macro assignment.
#
TEXT_1=no white space
TEXT_2 =left hand side
TEXT_3= right hand side
TEXT_4 = both sides
TEXT_5	=	tabs boths sides

#
#  Test psuedo targets.
#
all : print_macros repeat redefine many flags multiple split errors done

print_macros : empty t1 t2 t3 t4 t5 t.all

#
#  Targets with no dependencies.
#
empty :
	echo EMPTY='$(EMPTY)'

t1 :
	echo TEXT_1='$(TEXT_1)'

t2 :
	echo TEXT_2='$(TEXT_2)'

t3 :
	echo TEXT_3='$(TEXT_3)'

t4 :
	echo TEXT_4='$(TEXT_4)'

t5 :
	echo TEXT_5='$(TEXT_5)'

t.all :
	echo $(TEXT_1) $(TEXT_2) $(TEXT_3) $(TEXT_4) $(TEXT_5)

#
#  Test redefinition of macros.  AM allows redefinition and 
#  evaluates macros immediately.
#
TEXT_1	=text number 1
TEXT_2	= test macro split \
	across lines \
	three lines
TEXT_3	= test dollar macro '$$'
TEXT_4	= test dollar again "$$(TEXT_1)"
TEXT_5	=	imbeded macro '$(TEXT_1)'

redefine : r1 r2 r3 r4 r5 

r1 :
	echo TEXT_1='$(TEXT_1)'

r2 :
	echo TEXT_2='$(TEXT_2)'

r3 :
	echo TEXT_3='$(TEXT_3)'

r4 :
	echo TEXT_4='$(TEXT_4)'

r5 :
	echo TEXT_5='$(TEXT_5)'

#
#  Try to update a prerequisite more than once.  Subsequent occurences
#  should be ignored once a prerequisite has been updated.
#
repeat: t1 repeat.a t3
repeat.a : t2 t1


#
#  Target with multi-line receipe.
#
many : leaf.1 leaf.2
	echo Execute receipe with multiple commands.
	ls -1 leaf.*
	echo Last line of receipe for target 'many'.

leaf.1 :
	touch leaf.1

leaf.2 : 
	touch leaf.2


#
#  Test receipe line flags.
#
flags : silence ignore always combination

#  Command not displayed before execution.
silence :
	echo You should not see the 'ls' command printed. 
	@ls leaf.*

#  Ignore errors from command.
ignore :
	echo The 'ls' command should fail but not terminate AM.
	-ls unknown

#  This flag is ignored by AM since we don't support a silence option (-n).
always :
	+echo The '+' flag is accepted and ignored.

combination:
	-@echo The next displayed line should not be 'ls unknown'
	@-ls unknown
	@+-echo Combined flags test completed.


#
#  Multiple targets.
#
multiple : node.2 node.5

node.1 node.2 node.3 : leaf.1 leaf.2
	touch node.1 node.2 node.3

node.4 node.5 : node.2 leaf.3 
	touch node.4 node.5

leaf.3 :
	touch leaf.3


#
#  Test split lines.
#
split : node.6 leaf.4 split.cmd
	echo Completed split line tests.

#  Target dependencies split across lines.
node.6 : leaf.1 \
	leaf.2 \
	leaf.3
	echo Test dependency list split across lines.
	touch node.6

#  Target list split across lines.
split.tar \
leaf.4 \
leaf.5 :
	echo Test target list split across lines
	touch leaf.4 leaf.5 

#  Command lines split across lines.
split.cmd:
	echo Try spliting command \
		lines across more \
	than one line.


#
#  Test AM error reports and exit statuses.
#
errors:
	-am test.mk error.1
	-am test.mk error.2
	-am test.mk error.3
	
#  Target that does not exist, has no dependencies, and no commands.
error.1:

#  Target where dependency does not exist.
error.2: unknown

#  Receipe command causes error.
error.3: t1 fail t2
fail:
	ls -l unknown


#
#
#
done:
	echo AM Test Complete

clean:
	rm leaf.* node.*
