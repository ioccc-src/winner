# Best 2D puzzle

        Gil Dogon
        1 HaBeer Alley
        Jerusalem
        Israel
        gil_jade@netvision.net.il

## Judges' comments

This entry takes editorial in how it deals with its output.  After using
vi to look at the source, use vi to look at its output.   We especially
recommend it on a 78 column xterm while leaning on Control-F.

Do you really understand expressions, then understand this:

      s=s^(b=s&s-1^s)

... and understand why it is found in the source code.

### To build

      cc giljade.c -o giljade

### To run

      giljade > out

Open an xterm with 78 lines

      vi out

Press ^F repeatedly

## Author's comments

### So what do we have here ?

Just run the executable with no command line args and look at the output. In
order to properly enjoy it you will need two good old programs: xterm and vi.
Do the following: open an xterm with precisely 78 lines, and use the tiny font
size for best results. Then vi (vim will also do) the output. Type ^F's and
enjoy the show ...

The program solves (very very fast) a sliding block puzzle. There are many
variants of such puzzles which are usually made from wood or plastic pieces.
The start position can be recognized by looking at the program itself. The
goal is to move the big piece (2 by 2) to the center top, which takes 179
steps in the shortest move sequence.

Notice: the step count used by the program is longer than the traditional step
count for such puzzles, as normally if the same piece is moved twice in a row
it is counted as only one step, but here it is counted as two.

The printout of the solution however is in a rather unorthodox form, as can be
easily discerned. As you have probably suspected each of the steps in the
solution printout is a C program which compiles to result in - surprise
surprise! - the original (well almost).

Actually, This program is smarter than merely printing ITSELF in 180 different
layouts. It is self-improving, in that the programs it prints have three
advantages over the original:

1. Their layout is more precise (Notice the annoying \ at the 10'th line of
the original program which is actually a 'layout bug'

2. Their binary output does not rely on the source file being in the same
directory, and will not dump core like the original if it doesn't.  :)

3. They have much more comments (Not very helpful ones though).

In addition as we all know bugs can creep on us in the most unexpected of
places, and checking that indeed the output is composed of 180 legal C
programs by hand can be quite tedious, hence the program also include a self-
test mode. Just run it with the output file as command line argument. It will
then try to compile each of the programs (printing the line number where the
program starts) It will stop where any compilation fails and the culprit
program would be in the file 'c.c'. The exit code of the self-test will be
non-zero in that case. In case this entry wins, I do hope nobody by the name
of 'c' also wins this year otherwise that part of the program would have to be
changed!

Notice that the self-test does not try to run the result of the compilations
but this can easily be done. try it and diff the output of any of the 180
results with the original output. Of course all 180 programs also include the
self-test mode.

### Why I think this program is obfuscated.

  * Because its says so, and twice is better than once!
  * All the usual suspects i.e. ?: && || , used to compress code length in the
noble tradition of this contest, meaningless one character variable names,
etc...
  * The board representation is efficiently compressed hence obfuscated, and
the algorithm that is used to generate possible moves is extremely efficient.

In fact it can compute several moves in parallel on one processor! Moreover
Only the most efficient bitwise logical operations, shift,and subtraction by
one is used. No inefficient conditional tests and jumps are needed in that
part of the program.

  * The single expression I'm most proud of, and would have submitted to the
category of 'best obfuscated short expression' if there was one is:

        s=s^(b=s&s-1^s)

Can you figure out what it does (very efficiently) and how it fits in the
scheme of things?

  * IMHO the program is easier to understand before running cpp on it. It is
also shorter that way to be sure.
  * It even takes care to obfuscate the comments in the output programs.
  * Having the output programs a bit different than the original is more
interesting.
  * I have written an earlier version of the program about half a year ago and
when returning to it now I had to sweat quite a lot to understand the f***ing
mess I've made.

### Known Bugs/problems/warnings/portability issues

Some CPPs issue a warning about empty macro parameters.

-pedantic informs me that 'ISO C' does not allow extra ; outside of a
function, and I to this I say ISO what ???

-Wall of course will suggest adding a lot of parenthesis, function prototypes,
and remove some unnecessary expressions, and to this I say: if I listen to you
where is my freedom to obfuscate in style?

As mentioned earlier if you try to run the original program without its source
nearby it will dump core.

The program relies heavily on the ASCII coding system (have I seen this
comment before ?). It also implicitly assumes that sizeof(int) = sizeof(FILE
*). On systems when that is not the case expect a core dump...

### Challenges

What use are the ;; for ?

Why do I use 126& in the program? (except for the rather obvious fact that it
serves as comment obfuscater).

Why not write s^= instead of s=s^ In the expression I'm most proud of ?

What is 40-(h&62) doing ?

Use the program to solve for a different starting position. It is not that
difficult. Notice however that if there are more than two empty spaces the
outputs would not compile as the layout would not be sufficient to contain the
program.

Use the program to solve for board size different than 4*5. Thats a bit more
tricky.

### Hint for the challenges

Just try to change the program, and use the self test to see what happens ...
