# Best Abuse of Computation

Christopher Night
Harvard University
Department of Astronomy
Cambrige MA 02238
US
<http://www.people.fas.harvard.edu/~night/>

## Judges' Comments:

### To build:

        make night

### To run:

        ./night

You'd never guess, from looking at the code, that there is a
genetic algorithm involved.  Somewhere.  But what does it do?
Well, it might take you a while to navigate the results, let
alone the code.

## Selected Author's Comments:

Don't worry; this is not a self-reproducing program, as you might at
first guess from the layout. I would never be so foolhardy as to
submit an entry on an over-used theme!

Oh, wait a second... it is a maze-generating program. Oops!

### What it does:

This program solves an optimization problem, namely, generating a
challenging maze. It uses a very simple genetic algorithm: a maze
layout's DNA is represented as a 32-bit integer, and mutations consist
of flipping three different bits. The algorithm is simple in that it
doesn't employ sexual reproduction, only mutations, and it has a
population size of 1. So much for diversity!

This particular optimization problem, I believe, has a unique maximum:
there is but one maze out of 2^32 that requires 64 moves to solve. The
program will run until finding this global maximum, or if you get
bored, you can accept a sub-optimal solution by pressing any key. On
my system, it takes an average of 15 minutes to find the maximum,
whereas a random search would take an average of 3.5 days.

Should you take my word for it that the maze it generates requires as
many moves as I say it does? The answer is yes. But if you're not
convinced, you can try to solve it yourself. The goal is to traverse
from the upper-left to the upper-right and out the top, where the
number of moves remaining is printed. Use the arrow keys for suckers
(w, a, s, d) to move around. q quits and r restarts. Also, the maze
changes as you move through it, in a predicatable way. It should be
easy enough to figure out the pattern. For best results, use a display
with bold-text capabilities and color.

Finally, in the world of DNA, the medium is truly the message. There's
a short message encoded in here that will only appear when you
complete the optimal maze in the required 64 moves.

### Issues:

These depend on your compiler, and they were all intentionally
added for obfuscation purposes. No, really!

My compiler warns of nulls in a string literal, and the redefinition
of the macro T.

On one compiler, compilation took about two minutes.

`sizeof(unsigned short)` must be 2, and `sizeof(unsigned long)` must be 4.

CLOCKS_PER_SEC is assumed to be 1000000. If it's a lot less than that,
expect delays.

### Algorithmic obfuscation:

The representation of the maze layout in a 32-bit integer type is
pretty opaque. As a hint, the optimum layout's DNA is, in base 4,
2102231031201230. Try getting from there to the maze that appears on
screen.

The recursive function CGAC replaces a nested for loop in a handy way.

The maze-solving function TGA returns no solution both if no solution
exists, and if the search space grows too large, with a single test.

### Stylistic obfuscation:

Four-letter alphabets are confusing. I don't know how ribosomes
manage.

Overloaded symbols, such as G and G().

Who needs != when you've got ^?

Who needs if when you've got while?

For that matter, who needs fixed-iteration-count for and while when
you can just duplicate code with the preprocessor? Duplication by this
macro causes one particular graphics line to be replicated 512
times. On my system the preprocessed code is over 80KB in length,
hindering the preprocessor's ability to deobfuscate.

Keypad support was removed to save space. To restore, modify the
following two macros to:

        #define ATG srand(time(0)); initscr(); cbreak(); noecho(); start_color(); keypad(stdscr,1);
        #define AGG A&2?KEY_UP:KEY_DOWN:A&1?KEY_RIGHT:KEY_LEFT

Code on!
