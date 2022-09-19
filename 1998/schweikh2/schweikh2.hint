Most Erratic Behavior:

    Jens Schweikhardt
    DFN Network Operation Center
    Schlartaeckerweg 3 (Home address)
    D-71384 Weinstadt
    Germany

    http://www.shuttle.de/schweikh/


Judges' comments:

    To build:

	make schweikh2

    Almost every compiler is supposed to be able to accept the code in
    schweikh2.c; try compiling schweikh2.orig.c to see if your compiler
    is fully standard-compliant.

    To use:

	./schweikh2
    or
	./schweikh2 integer_number

    Run the program with a small argument, like 5 or 10, several times.
    Are the results different? Why?

    Some non-gcc compilers that are not fully ANSI standard do not
    compile this entry correctly.

    At the time this hint file was written, some gcc and egcs
    implementations ran into problem when building the original entry:

	    make schweikh2.orig

    This program often will produce an error of the form:

	gcc -ansi schweikh2.orig.c -o schweikh2.orig
	as: Error: cca00NzV.s, line 58: Missing " at end of string
	     "
	as: Error: cca00NzV.s, line 58: malformed statement
	*** Error code 1 (bu21)

    because the line:

	??=line 10 ONE(O(1,1,2,6,0,6))

    turns into the line:

	# 9 "01\012"

    which causes gcc to give to the assembler the following two lines:

	.stabs "whey.c
	",132,0,0,Ltext1

    and the lone " after the #.file line results in an assembler syntax error.

    In some cases one must compile using 'gcc -g':

	make schweikh2.orig CFLAGS=-g

    to trigger this error.

    And with the proper text beyond the \012, it may be possible to have
    all kinds of fun adding ``inline assembly'' via #line directives.  :-)
    For extra credit:

	If your compiler has this bug, transform the line in the C
	program to inject assembly instructions in such a way that
	the program will compile.

	If you are able to do the above, try adding assembly instructions
	so that it will compile, execute and do something interesting.
    If you succeed in doing this (especially on FreeBSD, Linux or Sparc),
    email the author for a free pat on the back.


Selected author's comments:

    What this program does
    ----------------------

    My entry is a yarng, which stands for, you guessed it, yet another
    random number generator, and is pronounced 'yawn' due to its
    incredible speed.  Seriously, it exploits the randomness of quantum
    mechanical events that build up the hardware as well as some other
    non-deterministic factors.  Here's how it works:

    1) an alarm is scheduled to be delivered in a second
    2) an infinite loop is entered that just increments a counter
    3) on delivery of the alarm signal, the counter's LSB is printed.
    4) while some other counter is not zero, go to 1)
    5) exit

    The yarng therefore produces output at a rate of 1 baud. The number of
    bits may be specified by an argument and defaults either to UINT_MAX
    (least likely) or UINT_MAX+1 (most likely). Extra credit: why the
    different values? How long would you need for an empirical test?

    For example:

    $ yarng 32
    10111001010101110110010101001111
    $ yarng 5
    10011

    Why I think this is obfuscated
    ------------------------------

    -Ever seen a 'do for ... while' loop?
    -I avoided 'int' like the plague. Instead I used storage class specifiers
     (register, auto) to get implicit int. The Standard allows implicit int
     even in casts as you can see in '(void(*)(register))main'. Where implicit
     int is impossible, like in the 'int main' declaration I have int split
     across two lines. All indent programs I use insert space at the beginning
     of the continuation line and thereby introduce a syntax error.
    -main (ab)used as a signal handler. Shocking. Yeah, this leads to undefined
     behaviour. I have yet to see a system where it does not work. If it
     doesn't work for you, I'd appreciate if you mail me about it.
     Uh-oh, schweikh did it, uttered "Works for me". Don't quote me on that!
    -Even if you know how the program works, you just can't predict the output.
    -Chained use of token pasting operators ## with shuffled arguments
    -So you think you can't assign to __LINE__ and __FILE__? Not so. The
     #line preprocessor directive does the trick. But saying '#line 10 "01\n"'
     is a little lame and I came up with '??=line 10 ONE(O(1,1,2,6,0,6))'
    -__LINE__ is used as the signal number argument to signal(). If indenting
     or other editing changes the number of lines the program is likely to be
     killed after one second... Thanks to POSIX for specifying SIGALRM as 14.
     You're SOL if your system does not conform. Get a real OS.
    -All strings (or characters) needed are crammed into __FILE__ using
     octal notation and then extracted using pointer + offset notation.
    -Use of a # (null) preprocessor directive (hidden as a %: digraph)
     Delete this line and prepare for a core dump.
    -Identifiers reused with different capitalization: one, One, ONE, zero,
     Zero. ONE is particularly nasty because it appears as a macro taking
     an arg and as a plain identifier in main's parameters. The rule is that
     whenever ONE is followed by '(' it must be the macro.
    -A quote from Kernighan and Plauger, "The Elements of Programming Style",
     2nd Ed., page 21: "A useful way to decide if some piece of code is
     clear or not is the ``telephone test.'' If someone could understand your
     code when read aloud over the telephone, it's clear enough. If not then
     it needs rewriting."
     Now try the telephone test for 'one = zero = atoi (ONE[zero-1])'
    -Don't you love the aesthetics of symmetry: write (1, 1+__FILE__+1, 1)
     (telephone test this as well; is it 1, One, ONE, one? Maybe won?).

    Where does the randomness come from?
    ------------------------------------

    Each bit obviously depends on the number of times the loop body is
    executed between two calls of the signal handler. But what determines
    this number?

    + The accuracy of the clock driving the CPU
    + The accuracy of the clock driving the timer responsible for alarm signals
    + On multitasking OS's: The total time the process is scheduled
      to run between successive invocations of the signal handler.

    How about the randomness of the yarng? To measure these properties I
    counted the number of bit sequences and compared them to what I would
    expect from a generator with uniform distribution (all sequences
    equally likely to occur).

    It is interesting to note that yarng's maximum deviations are less
    than or equal to rand()'s. Randomness however tends to degrade under
    high load averages on my system (Linux). This could be avoided by
    allowing the process one second of execution time instead of wall
    clock time (using the SIGVTALRM sent by the virtual timer
    instead of SIGALRM).

    I'm not surprised. Yarng in the end depends on fluctuations of the
    electrical field and the heat distribution in the oscillators, the
    implementation and state of the scheduling algorithm, the system
    load, number and temporal distribution of asynchronous events and
    last but not least the phase of the moon. God _does_ play dice.
    Type yarng and watch Him roll.
