# Best 3D puzzle

        Anonymous

## Judges' comments

Taking the 4x4 board with 15 tiles to a whole new level, this entry
takes this puzzle to a whole new dimension!  While you puzzle out
this puzzle, we invite you to take a good LONG look how and WHY
main is recursively called and how the run-time stack is used.

## To build

        cc -o anon anon.c

Or, if the above does not work

        cc -DNO_STTY -o anon anon.c

## To run

        anon 4 4
        anon 3 3 3

## Author's comments

### ABOUT THE GAME ITSELF

Remember Sam Loyd's Fifteen Puzzle? It consists of a 4x4 board with 15 tiles
numbered 1 to 15, and an empty spot. The goal of the game is to slide the
tiles around without lifting them off the board, so that they become sorted.

Well, that was then. This program is the 21st century version of the Fifteen
Puzzle: not only does it allow arbitrary board sizes, it also supports _3D_
boards! The tiles are numbered from 1 to N, where N is one less the number of
spaces on the board, and the goal is to rearrange them so that they appear
sorted in the order they appear on the screen.

The program takes 2 or 3 arguments, specifying the dimensions of the board.
For example, to play the original version of the Fifteen Puzzle:

        anon 4 4

To play in a 3D board, do something like this:

        anon 3 3 3

**[WARNING: do NOT run the program with more than 3 command-line arguments.
This will trigger a bug that will cause it to crash or do something strange.
:-)]**

Also, resist the temptation to create very large puzzles. The program does not
attempt to resize your terminal for you, and will produce confusing output. It
may also crash on you if you insist on running it with excessively large board
dimensions. :-) (10x10x10 is considered a safe upper limit.)

The empty space on the board is represented by a space filled with '#'
characters instead of digits. To slide the tiles around, use the following
keys:

        i | Slide the tile above the current empty space downwards.
        j | Slide the tile to the left of the current empty space to the right.
        k | Slide the tile below the current empty space upwards.
        l | Slide the tile to the right of the current empty space to the left.
        o | Slide the tile behind the current empty space forwards.
        n | Slide the tile in front of the current empty space backwards.

To quit the game:

        q | Quit the game.

Note that, for example, sliding the tile above the current empty spot
downwards will fill up the empty spot, and create a new empty spot above where
the current empty spot was. Hence, you could think of the movement keys in
terms of how they effectively "move" the empty spot:

        i | Move empty spot up
        j | Move empty spot left
        k | Move empty spot down
        l | Move empty spot right
        n | Move empty spot forwards
        o | Move empty spot backwards

**NOTE:** as a measure of alleviating counter-productivity due to addiction to
this game, particularly for those hardcore gamers who insist on solving a 
10x10x10 puzzle during work hours, and also to give an upper bound to user
frustration when the program generates an impossible puzzle (which it does
roughly half the time, just to hook you), the program will, after a very large
number of moves (which is system-specific) terminate itself by forcefully
destroying its own runtime stack. This will result in a core dump and/or an
abnormal termination message; but this is a feature, not a bug! :-)

### COMPILE NOTES

This program complies with ANSI/C99. It uses ANSI terminal control sequences,
and so requires a terminal that understands ANSI sequences, such as vt100 or
xterm.

Some compilers may emit lots of warnings about how things ought to be
parenthesized (e.g. `gcc -Wall`). This is deliberate, since if everything were
parenthesized "properly" the program would fail to work. It (ab)uses C
operator precedence to accomplish some cool hacks. :-) However, there are no
compiler errors. I have tested this with `gcc -pedantic -std=c99`.

The program also uses `stty cbreak`. If this breaks on your system, compile it
with -DNO_STTY. The game interface will be a bit annoying (you will need to
hit enter after every key), but it works.

The game requires lots of space on the runtime stack space due to deep
recursion, among other things. :-)

See spoilers below for more notes about portability.

### ABOUT THE CODE

Clearly, the author is very, very confused. Although he has broken up the file
into sections labelled with helpful headings, and although he has left ample
whitespace between all those #define's to make them easier to read, :-) and
although he has helpfully formatted the code with beautiful indentation,
something is clearly very, very wrong.

In fact, the closer you look at this code, the more you realize something is
horribly wrong with it. For example, why is it that the first statement in
main() is a return? What do all those nested do-loops do? (pun intended) Why
is the first statement inside the first do-loop a mere integer literal? Why
are there such strange statements, like that empty string on line 64, or that
isolated || on line 67?

But wait... why aren't any statements terminated by semicolons? Why is there
only ONE semicolon in the entire program?! Why is the author opening nested
blocks by such strange things as || and (, and closing them by || and ))? The
for-loop isn't a for-loop! The do-loop isn't a do-loop! Or... are they? Well,
the for-loop is defined in terms of a while-loop. But wait, the while loop is
defined in terms of the do-loop. And the do-loop is defined in terms of ...
Huh???

And that switch statement toward the end of the program... wait a minute, that's
not a switch statement! Why is a case defined in terms of a switch statement?!
And that initial return isn't a return! Well, it is... but not what you might
think!

Let's see if it all makes sense after we run it through CPP...

Uh oh. The result looks like the diseased imagination of a mind more confused
than the one who wrote the original code. Unfortunately, unless you're a Lisp
expert, it is probably easier to understand the program in its original form.
(And even then.) But that's just so, so wrong...

The entire program consists of a single expression, returned from main().
There are no if-statements, no for-loops or any looping or control constructs
besides the 'return', in spite of the misleading appearance of the original
source. :) Yes I know, this has been attempted before, using ?: and the bad
old comma operator. BUT this program does NOT use the ?: operator, and there
are only TWO comma operators in the entire program--and they are only there
because srand() and exit() return void.

The entire program consists of a single boolean expression returned from
main(). Looping is achieved by recursion, of course, and branching is achieved
by exploiting short-circuit evaluation of boolean expressions. `:-)`

But this is not all.

It is comprehensible that the program can achieve branching and looping using
only boolean expressions and recursion. But HOW does the program STORE DATA???
There are no variables of any kind in the program except for the two arguments
to `main()`. There are certainly no arrays declared anywhere. The program does
not call any memory allocation routines, nor any function that indirectly
returns allocated memory. Yet it happily looks up array references without
crashing. How??

One might be tempted to think that this program would be highly non-portable
because of such insane hacks. However, it has been tested and proven to work
on the following architectures:

  * i386/linux
  * sparc/solaris
  * parisc64/linux
  * arm/linux
  * s390/linux
  * mips/linux
  * m68k/linux
  * ia64/linux
  * sparc64/linux

It probably will also compile and work on many (all?) other *nix platforms as
well. How does it achieve this incredible feat?

### SPOILER

.

.

.

.

.

.

.

.

.

.

.

(Read the following only if you give up figuring it out `:-)`)

.

.

.

.

.

.

.

.

.

#### The Evil Hack

The program (ab)uses an implicit assumption underlying practically all
architectures, and that is that parameters to C functions are implicit local
variables allocated on the runtime stack. This runtime stack is a contiguous
section of memory, and therefore, after N recursive calls of main() to itself,
there is enough room on the stack to store whatever the program desires, so
long as it does not exceed the maximum stack size.

(Theoretically, the runtime stack doesn't **have** to be contiguous… but all
current architectures that are worth consideration make this assumption. I
submit that this implies this program is 100% portable, even though
theoretically it shouldn't even work in the first place.) `:-)`

There are two types of architectures the program must handle: those that
allocate the stack top-down, and those that allocate the stack bottom-up. The
program correctly detects this at run-time, and adjusts itself accordingly.
:-) (It is a simple matter of testing if the address of argc in a recursive
call is greater or less than in the parent call.)

To avoid having to handle issues of int sizes, memory alignment, what exactly
is on the stack between successive locations of argc, etc., the program
(ab)uses the fact that argc must necessarily be allocated on an aligned
address, and therefore, the range of memory between two argc's is aligned, and
therefore safe to use as an array of longs.[*] The program also compares the
pointers as (long*) pointers, so that it will not have to deal with mapping
bytes to larger types. The initial memory allocation is done by recursively
calling main() until there is enough space on the stack (the exact number of
recursive calls is, of course, architecture-dependent).

[*] long was chosen instead of int, in order to skirt around pointer-size
issues on architectures like ia64. It really can be made anything large enough
to hold both ints and pointers. `:-)`

After the stack is deemed to have grown deep enough to be a sufficiently long
array (pun intended), the program begins its real code. It uses argc to keep
track of what it's supposed to be doing (since main() is the only function),
and argv to point to the base of this array (which is computed differently
based on how the architecture allocates the stack). Since this fills up the
only two variables in the program, everything else is stored in the MASS [**]
array.

[**] for "Memory Allocated by Stack Smashing" `:-)`

Note that from this point on, all bets are off as to what the contents of the
runtime stack are below the current recursive call to main(). We are
overwriting frame pointers, return addresses, etc., with data. Hence, the
program must never return from this call, otherwise it will crash horribly.
That's why I had to call exit() even though it meant I can no longer claim the
program doesn't need the comma operator. :-) (I was going to skirt around the
issue by indirectly calling exit(), such as via bsearch() or raise(), but I
was getting too close to the size limit.)

#### Some notes about the macros

In spite of the frightening appearance, it is probably easiest to understand
the code in its original form. (Don't even try running 'indent' on it: on my
system it chokes and complains about nesting errors.)

Most of the #define's are just to keep the code size down, due to the abusive
amounts of type casting employed. The others define a bizarre "programming
language" (in the crudest, most twisted sense of the word) that the author
used to write this mess.

R(i) and W(i,j) are macros to read/write the i'th position of the MASS.

A(i) retrieves the i'th command-line argument. This is slightly tricky,
because by the time the MASS is setup, we no longer have access to the
original values of argc and argv. So what is done is that the initial memory
allocation code will save argc and argv into positions 8 and 9 in the MASS
after the allocation. It does this by using argv, which at that time contains
a pointer to the top-level argc, to compute the location of the top-level
argv. This is done before the rest of the MASS is used, since otherwise they
may be overwritten.

do(x,y) has nothing to do with do-loops. `:-)` It defines a "state" in main(),
essentially, what to do when main() is called with argc containing a
particular value. (This is why the user must never run the program with more
than 3 arguments. :-) The state number is x, and y is the code. The program's
boolean expression consists of a number of states &&'d together. Within each
state, it is assumed that statements are separated by ||. All statements are
assumed to evaluate to false. This makes it easy to write conditional
statements: "if (a) { b } ..." can simply be written "a && b || ...". All
states created by do(x,y) are assumed to evaluate to false. There is only 1
state which can return true or false: state 5, a "manually-implemented" state
which determines whether the system uses top-down or bottom-up stack
allocation. It's the only state that needs to return a value from the boolean
expression, since once the MASS is initialized any return value can simply be
stored in a well-known location in the MASS.

if(p,q,r,s) is, in fact, an if-statement. `:-)` It is equivalent to:

        if (p) { q; r } else {s}

Why are q and r split up? Because it's cleaner (in whatever twisted sense of
the word that can be applied to an IOCCC entry) to implement using boolean
expressions. Keep in mind that all statements are assumed to evaluate to
false. The proof that this macro in fact implements an if-then-else construct
is left as an exercise for the reader.

while(x,y,z) is actually a while-loop after all. `:-)` It implements the loop
using, of course, recursive calls to main(). However, this macro doesn't
actually run a while loop; it implements the loop in the state numbered x. It
is used for defining a while loop, which can then be called from another state
using f(x). (The reason we can't directly implement a while-loop inside
another state ought to be clear: we can't recursively call main() to enter
into the middle of a state.)

However, it _is_ possible to implement a for-loop directly inside a state! The
for(s,i,x,y,z,Z) macro does exactly this. Well, actually, technically speaking
this macro can only be used as the last thing in a state, because it secretly
closes the current state and opens a new one behind the programmer's back.
:-) Its intended usage is this: s is the state number for the loop body, and i
is the index variable (well, the index into the MASS of the index variable); x
and y-1 define the starting and ending values of i, and z is the loop body. Z
is the post-loop code in the current state. For example:

        for(s,i, 0, 10,
        some_code       ,
        other_code)

is equivalent to:

        for (i=0; i&lt;10; i++) {
                some_code;
        }
        other_code;

Note the "wrong" indentation in the former: the author prefers to write it
that way, since the analogy to the usual for-loop is clearer. This is why it's
easier to understand the pre-CPP code, since after CPP, the macro reshuffles
some_code after other_code so that it can close the current state and define
the one containing the loop body. (Have I told you that the author of this
program is horribly, horribly, confused? :-) This confusion also shows up in
the superficial appearance of the program, which heavily suffers from wrong
indentation.)

In spite of all appearances, switch() really is just a shorthand macro for
reducing code size. The evil choice of macro name is just to instill more
confusion into the would-be decipherer of this entry. :-) After all, case()
really _is_ the equivalent of a case statement, implemented using &&, and
conveniently encapsulating code common to the cases in the only switch-
statement in the program, which is the code that decides what to do with a
keypress. What could be more fun than to define such a case in terms of a
switch? :-)

Finally, for those who give up deciphering this horribly confused code, here
are the mappings of various locations of the MASS to their usage in the
program, and what the various state numbers are meant to do:

#### MASS usage map

        0  | Function return value
        1  | Function argument 1 
        2  | Function argument 2 
        3  | Function argument 3 
        4  | Scratch register 1 
        5  | Scratch register 2 
        6  | Scratch register 3 
        7  | Scratch register 4 
        8  | Value of original argv :-) 
        9  | Value of original argc :-) 
        11 | Zero register (always set to 0) 
        12 | Width of board 
        13 | Length of board 
        14 | Height of board 
        15 | Current position of hole 
        16 | Random seed for rand_r() 
        18 | Scratch register used by state 18 :-) 
        31 | field width for printing tiles 
        32 | Start of board data 

(**CAVEAT:** not all of these mappings ended up in the final version of the
program, mainly due to size limitations which entailed the trimming off of a
lot of neat features in the game. It is left as an exercise for the reader to
figure out which of these are actually used.)

Note that argv and argc necessarily needs to stay away from lower indices of
the MASS, because otherwise they may overwrite their original values when the
memory allocation code saves them. Index 8 is deemed "safe enough". (It seems
to be on all tested architectures.)

#### State number assignments

        1  | showhelp 
        2  | showhelp 
        3  | is 2D: start init 
        4  | is 3D: start init 
        5  | find allocation type 
        6  | MASS init, bottom-up 
        7  | MASS init, top-down 
        8  | main program 
        9  | generate() outer loop 
        13 | render() 
        14 | render() loop 
        15 | exit(0) 
        16 | pick a tile that hasn't occurred yet 
        17 | inner loop of 16.  
        18 | main loop 
        19 | checkwin() loop 

Note that some of the manually-implemented states (those not implemented by
do()) respond to multiple state numbers. Also note that states 1-4
conveniently correspond to what the program should do when 1-4 arguments are
given at the command-line. :-)

The original intention was to include a parity-checking routine in the game so
that it will always generate a solvable game. However, size limits
necessitated the removal of this code. And besides, the game is more addictive
when it's sometimes unsolvable. Especially when it taunts the user with a
smiley. :-)


