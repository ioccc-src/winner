## To build:

``` <!---sh-->
    make all
```

There is an alternate version with a trace routine that the author had commented
out. See [alternate code](#alternate-code) below for more details.


## Try:

``` <!---sh-->
    ./paul
```


## Alternate code:

This version was described by the author like:

> I could have squeezed the program under 1024 bytes without the trace
subroutine, but I felt it was important for understanding the program.  Besides
it is fun to watch the tape zooming back and forth as the program runs.  A much
better debugger or trace could easily be added.


### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./paul.alt
```


## Judges' remarks:

The author's comments are a detailed program explanation, if you wish to learn
more about the obfuscation method used.


### Historical note:

The original source contained a long line which caused many mailers to barf.
The original file may be re-constructed by removing the trailing `\` on line 12
and joining lines 12 and 13 together without a space.

However as this is no longer a problem the trailing `\` has been restored in all
versions, both the original and the fixed for modern systems version.


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


## Author's remarks:

This programs computes and prints Fibonacci numbers by
simulating a Turing machine with the proper program.
Understanding the C program, i.e., a Turing machine simulator,
is only the first and simplest step.  The Turing machine
program must be understood, too!  (it is trivial, perhaps even
natural to write incredibly obscure Turing programs.)

If the program is invoked with an operand, the operand is used
as the Turing program.  It includes a "trace" facility,
subroutine `r` (commented out for obscurity), to help write and
debug Turing programs.  Just the thing for some fun in a Theory
of Computation class.

The Turing machine tape is represented as a doubly linked list
of pointers.  The forward and backward links are `XOR`ed together
and stored in one pointer.  If we always keep one of the links
on hand, we can recover the other link at any time.  The
variable `q` is the scan head (and a pointer at some tape cell),
and `p` is a "previous" link.  The state of the tape is stored in
the low order bit of the pointer.  Since we always allocate an
even number of bytes, the low order bit carries no information
(see [portability](#portability) below.) Memory representing a tape cell is
allocated when the cell is first scanned.  Thus the simulation
begins with a tape effectively the size of virtual memory set
to all zeros.  Since a header can be added to any Turing
program to write initial data and position the scan head, this
is little loss of generality.

The simulated Turing machine has a single tape with either a `1`
or a `0` in each cell.  The Turing machine language format is a
string of three bytes.  The first byte is the current state.
The second byte is the next state.  (The last bit of states is
ignored, i.e., `B` and `C` are the same state, in an attempt to be
able to have interesting words in the program.)  The third byte
is composed of bits.  Bit `1` (`2&byte`) is the symbol scanned,
i.e. an instruction is selected for state and for a match with
the symbol under the scan head.  Bit `2` (`4&byte`) is the new
symbol to be written to the cell.  Bit `3` (`8&byte`) is the
direction to move the scan head: `0` for left and `1` for right.
If bit `4` (`16&byte`) is true, the next character is sent to
`stdout`.  (I added this feature so programs could print
results.)

The Turing machine has next state `j` when it begins.  The
cycle is (1) exit if the state is `x`, (2) find the next
instruction (given the state and the character under the scan
head).  (The program string is searched forward for the next
matching instruction.  If the end of the string is reached, the
search begins again at the first of the string.  Thus states
can be used as local labels in different places.)  (3) change to
the next state, (4) print a character if indicated, (5) write the
tape symbol, and (6) move the scan head.  The cycle then repeats
with step 1.  A call to the trace routine is just before step
2, but is commented out.

### Quick outline of the Turing program:

The previous and current Fibonacci numbers are kept in base
1 form with the current on the right.  The first three
steps set up the first two numbers, `1` and `1`.  Then,
beginning with '`@ (`', a marker of '`III`' is created and
the current number is copied to the right of the
marker.  Then, beginning with '`OV `', the number is
converted to binary by repeatedly dividing by 2 leaving I
for remainder `1`, and II for remainder '`0`'.  Next,
beginning with '`WV `', the binary representation is
printed and its symbols and the marker are erased.
Finally, beginning with '`EEn`', the two numbers are
added and the current number copied to the left to
become the previous.  Then the cycle repeats.


### Portability

The program requires that the lowest bit of a pointer to be 0.

I could have squeezed the program under 1024 bytes without the
trace subroutine, but I felt it was important for understanding
the program.  Besides it is fun to watch the tape zooming back
and forth as the program runs.  A much better debugger or trace
could easily be added.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
