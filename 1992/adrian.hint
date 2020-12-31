Most Educational:

	Adrian Mariano
	University of Washington
	2729 72nd Ave SE
	Mercer Island, WA 98040
	USA


Judges' comments:

    To build:
	make adrian

    Try:
	adrian adrian.grep.try < adrian.hint
    
    For the slow minded, try:
	adsleep 32767
    
    Once you get past the obfuscation, you have an opportunity to learn
    about regular expressions and state machines.

    NOTE: Some compilers have had trouble optimizing this entry.


Selected notes from the author:

                            ADrian's GREP (adgrep)

    For those confused by the complexity of full-blown egrep style regular
    expressions, this program offers an alternative.  It implements an
    equivalent search, using a deterministic finite automaton.

    A deterministic finite automaton consists of a finite set of states,
    along with transition rules to move from one state to another, an initial
    state, and a set of accepting states.  The automaton takes a string as
    input and begins in the start state.  It reads a character of the string
    and consults the rules for the current state, moving to the new state
    indicated by the appropriate rule.  This process is repeated until the
    string is consumed.  If the current state at this point is one of the
    accepting states, then the string is accepted.

    The deterministic finite automaton is specified as a series of rules for
    each state:

       <state> chars1 <dest1> chars2 <dest2> ...

    chars1 is a list of characters (only the first 8 are significant) which
    should trigger a transition to <dest1>.  <dest1> is another state which
    should have a similar specification somewhere.  A state is accepting if
    it is specified in square brackets: [final], and state strings are
    significant to only eight characters.

    Example 1: matches ^abc$

    <q0> a <q1>          The first state to appear is the start state
    <q1> b <q2>
    <q2> c [q3]
    [q3]

    Technically, a deterministic finite automaton should have a rule for each
    possible input character at each state.  To simplify descriptions of the
    automata, if no rule is present, the string will not be accepted. Also,
    the '.' character matches any character if it occurs first in the
    character list.


    Example 2: ^abc

    <q0> a <q1>
    <q1> b <q2>
    <q2> c [q3]
    [q3] . [q3]


    Example 3: abc$

    <q0> a <q1> . <q0>
    <q1> b <q2> a <q1> . <q0>
    <q2> c [q3] a <q1> . <q0>
    [q3] . <q1>


    Example 4: ^(abc)*$

    [q0] a <q1>
    <q1> b <q2>
    <q2> c [q0]


    Example 5: ^[ab][cd][ef]$

    <q0> ab <q1>
    <q1> cd <q2>
    <q2> ef [q3]
    [q3]


    Example 6: ^(abc|efg)$

    <q0> a <q1> e <q3>
    <q1> b <q2>
    <q2> c [q5]
    <q3> f <q4>
    <q4> g [q5]
    [q5]


    With the automaton specification in 'filename', invoke the program by
    typing

                                adgrep 'filename'

    It will read stdin and print out all the lines which the automaton
    accepts.  If the file cannot be opened, a system error message will
    be printed.  If the input contains errors, then an error message along
    with the number of the offending line will be printed to stderr.  The 
    number of rules for each state is limited to 17.  If more than 17 rules 
    are present, you get the error to_many_rules, and the state that was 
    being processed is printed.  Error no_destination occurs if you specify a 
    set of characters, but no destination state, and error too_many_states 
    occurs if your automaton has more than 257 states.

    Running
                             adgrep from < your_mailbox

    will perform a function similar to that of the unix from command.

    If no filename is specified on the command line, then "adgrep.c" is used
    as the specification for the automaton.  (This file has been renamed 
    to adrian.c by the judges.)  In this case, the program will search for 
    matches to the regular expression:

                        ^.[^|C][^w[Q]*(Q|[w[]c).*|^.[C|]$

    I suggest using adgrep.c as input, and storing the output in adwc.c:

                           adgrep < adgrep.c > adwc.c

    Compiling the new file, mywc.c, yields a clone of the unix wc command. It
    runs on one file (defaulting to "adgrep.c" if no file is given) and
    displays the number of lines, words, and bytes in the input file.


    Another possibly interesting automaton can be created by slightly
    adjusting the adgrep.c file.  Change the first line to read

                                 /* . echo| . */

    and repeat the process above

                           adgrep <adgrep.c > adecho.c

    The new file now contains all lines which match

                      ^.[^5|m^]*[m^]([e=p,;]|[^e=+p,;].*)$

    Compile and run.  This is an echo clone.  Note the efficient algorithm
    employed.


    Two other adjustments to the first line also yield useful results. By
    changing it to
                                 /* . head; . */

    you can search for matches to

                                  ^.[^W]*W..*$

    By some freak happenstance, lines of adgrep.c which match this regular
    expression form a unix head command.  It prints the first ten lines of
    the file specified on the command line (or adgrep.c if no file is
    specified).

    By setting the first line to

                               /* . basename . */

    a clone of the unix basename command can be unearthed. The automaton will
    search for
                                  ^.[^j]*jr.*$

    on standard input.  And the program which results by running adgrep.c
    through this filter requires two parameters.  The first is meant to be a
    filename, and the second, an extension.  All leading pathname components
    are removed from the filename, and the extension is removed if present.
    The resulting base name is printed to stdout.

    Lastly, by setting the first line to

                       	         /* . sleep . */

    you can search for

        		        ^.[^(~][^s]*sl.*$

    Filtering adgrep.c through this search yields a clone of the sleep
    command.  Invoke with a single integer parameter, and it will pause
    for that many seconds.

    If either adbasename or adsleep is invoked with too few parameters,
    the program will print the error message:
                       Segmentation fault (core dumped)

    (The exact text of the above error messages varies from machine to
    machine.)  The four programs which read from stdin require lines
    shorter than 999 characters.

    The other info files are adrian.grep.[1-6] which contain the six
    examples that appear above, and from, which is used to emulate the
    unix from command.  For reasons of clarity, the name "from" should
    probably not be changed if possible.  I wouldn't want to be accused of 
    confusing people by giving the input files weird names.

    If you want to change the default input filename (line 80) you must be
    careful to choose a name that doesn't match the wrong search patterns,
    introducing extra lines into one of the programs.

    The program will produce at least one warning and possible several
    when compiled depending on the compiler.

Copyright (c) 1992, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
