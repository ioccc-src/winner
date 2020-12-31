Most complex algorithm:

	Paul E. Black
	CIRRUS LOGIC, Inc.
	1463 Centre Pointe Dr.
	Milpitas, CA 
	95035 
	USA

Judges notes:

	The original source contained a long line which caused many
	mailers to barf.  The original file may be re-constructed by
	removeing the trailing "\" on line 12 and joining lines 12 and
	13 together without a space.

	WHAT FOLLOWS IS A DETAILED PROGRAM EXPLINATION AND SPOILER.
	IF YOU WANT A REAL CHALLENGE, DON'T READ ANY FURTHER AND TRY
	TO UNDERSTAND THE PROGRAM VIA THE SOURCE.


Selected notes from the author:

	This programs computes and prints Fibonacci numbers by
	simulating a Turing machine with the proper program.
	Understanding the C program, i.e., a Turing machine simulator,
	is only the first and simplest step.  The Turing machine
	program must be understood, too!  (it is trivial, perhaps even
	natural to write incredibly obscure Turing programs.)

	If the program is invoked with an operand, the operand is used
	as the Turing program.  It includes a "trace" facility,
	subroutine r (commented out for obscurity), to help write and
	debug Turing programs.  Just the thing for some fun in a Theory
	of Computation class.

	The Turing machine tape is represented as a doubly linked list
	of pointers.  The forward and backward links are XOR'd together
	and stored in one pointer.  If we always keep one of the links
	on hand, we can recover the other link at any time.  The
	variable q is the scan head (and a pointer at some tape cell),
	and p is a "previous" link.  The state of the tape is stored in
	the low order bit of the pointer.  Since we always allocate an
	even number of bytes, the low order bit carries no information
	(see portability below.) Memory representing a tape cell is
	allocated when the cell is first scanned.  Thus the simulation
	begins with a tape effectively the size of virtual memory set
	to all zeros.  Since a header can be added to any Turing
	program to write initial data and position the scan head, this
	is little loss of generality.

	The simulated Turing machine has a single tape with either an 1
	or a 0 in each cell.  The Turing machine language format is a
	string of three bytes.  The first byte is the current state.
	The second byte is the next state.  (The last bit of states is
	ignored, e.g., B and C are the same state, in an attempt to be
	able to have interesting words in the program.)  The third byte
	is composed of bits.  Bit 1 (2&byte) is the symbol scanned,
	i.e. an instruction is selected for state and for a match with
	the symbol under the scan head.  Bit 2 (4&byte) is the new
	symbol to be written to the cell.  Bit 3 (8&byte) is the
	direction to move the scan head: 0 for left and 1 for right.
	If bit 4 (16&byte) is true, the next character is sent to
	stdout.  (I added this feature so programs could print
	results.)

	The Turing machine has next state 'j' when it begins.  The
	cycle is 1) exit if the state is 'x', 2) find the next
	instruction (given the state and the character under the scan
	head).  [The program string is searched forward for the next
	matching instruction.  If the end of the string is reached, the
	search begins again at the first of the string.  Thus states
	can be used as local labels in different places.]  3) change to
	the next state, 4) print a character if indicated, 5) write the
	tape symbol, and 6) move the scan head.  The cycle then repeats
	with step 1.  A call to the trace routine is just before step
	2, but is commented out.

	The following ROT13'ed text is a quick outline of the actual
	Turing program:

		Urer vf n dhvpx bhgyvar bs gur Ghevat cebtenz: gur
		cerivbhf naq pheerag Svobanppv ahzoref ner xrcg va onfr
		1 sbez jvgu gur pheerag ba gur evtug.  Gur svefg guerr
		fgrcf frg hc gur svefg gjb ahzoref, 1 naq 1.  Gura
		[ortvaavat jvgu "@ ("] n znexre bs VVV vf perngrq naq
		gur pheerag ahzore vf pbcvrq gb gur evtug bs gur
		znexre.  Gura [ortvaavat jvgu "BI "] gur ahzore vf
		pbairegrq gb ovanel ol ercrngrq qvivqvat ol 2 yrnivat V
		sbe erznvaqre 1, naq VV sbe erznvaqre 0.  Arkg
		[ortvaavat jvgu "JI "] gur ovanel ercerfragngvba vf
		cevagrq naq vgf flzobyf naq gur znexre ner renfrq.
		Svanyyl [ortvaavat jvgu "RRa"] gur gjb ahzoref ner
		nqqrq naq gur pheerag ahzore pbcvrq gb gur yrsg gb
		orpbzr gur cerivbhf.  Gura gur plpyr ercrngf.

	The program requires that the lowest bit of a pointer to be 0.

	I could have squeezed the program under 1024 bytes without the
	trace subroutine, but I felt it was important for understanding
	the program.  Besides it is fun to watch the tape zooming back
	and forth as the program runs.  A much better debugger or trace
	could easily be added.

Copyright (c) 1989, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
