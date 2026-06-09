Award: Ping pong prize

## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog | tee prog1.c | cc -xc -o prog1 - ; ./prog1 | diff - prog1.c
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:


### Alternate build:

``` <!---sh-->
    make prog.alt
```


### Alternate use:

``` <!---sh-->
    ./prog.alt | tee prog1.alt.c | cc -xc -o prog1.alt - ; ./prog1.alt | diff - prog1.alt.c
```


## Judges' remarks:

This presses so many of our buttons, not just W and E!

Nevertheless, please resist the urge to write "Quine Doom" as a next year's
IOCCC submission.


### A fun challenge


#### Fun challenge 0

Write alternate version of [try.sh](https://github.com/ioccc-src/winner/blob/master/2025/uellenberg/try.sh)
that detects when the quasi-quine, left to its own iterative devices, starts to repeat.

If you do not attempt to move the paddle, and let the game run on its
own, the game will "evolve" to other "modes", and eventually cycle back
to the original style of game play.

**UPDATE**: We are in the process of changing how we present fun challenges,
and present potential solutions to those challenges.  Please stay tuned for an update.


#### Fun challenge 1

Implement an additional game mode using only the original game objects
(the ball and two paddles).
For example, you could implement a "flappy bird" game using the ball
as the bird and the paddles as the pipes.

As an extra challenge, try to keep the original behavior of the program
the same, with this new game mode added on top.

**UPDATE**: We are in the process of changing how we present fun challenges,
and present potential solutions to those challenges.  Please stay tuned for an update.


#### Fun challenge 2

Create a version of the game that "plays itself", running through all
the gameplay without user input and returning to the exact source code
it started with.

**UPDATE**: We are in the process of changing how we present fun challenges,
and present potential solutions to those challenges.  Please stay tuned for an update.


## Author's remarks:


### Quine Pong

This is my version of pong with a killer upgrade - it requires a C compiler
to use! Running the program produces the source code to generate the next
frame, formatted to display the current frame. By repeatedly compiling
and running each successive frame, you can play the game. To move,
pass either "w" (up) or "e" (down) as an argument. You play as the
paddle on the right, and your opponent is the computer. If you don't
love the thought of running the same commands over and over again ( :(
), you can just run try.sh, which automates this process and lets you
interact directly using your keyboard.

Make sure you win against the computer at least once, there's a fun
surprise waiting for you (spoilers in the next section)! Go on, go play
the game, I'll still be waiting for you when you return.

<br>

Now that all the obfuscated C fans are distracted, it's time I
let you in on what's really going on. See, this code isn't really
obfuscated. It never was. No, it's **compiled**. That's right, not a
single nibble desecrated by human hands, only purified in the unfeeling
steel of liveness analysis, constant folding, variable reallocation,
and compile-time evaluation. And the best part? There's a source file
out there, just waiting to be read. Comprehendible variable names,
comments explaining the justification for every block of code, and not
a magic number in sight (well, maybe a few - no one's perfect). Imagine
that! Don't believe me? [Let me show you](%%REPO_URL%%/2025/uellenberg/prog.int).

If you want to take a closer look at the code, [prog.c](%%REPO_URL%%/2025/uellenberg/prog.c)
is the obfuscated version of the code, [prog.alt.c](%%REPO_URL%%/2025/uellenberg/prog.alt.c) is
a version with indentation and newlines and without define compression
(which you can run with try.alt.sh), and [prog.int](%%REPO_URL%%/2025/uellenberg/prog.int) contains
the original source code. [prog.alt.c](%%REPO_URL%%/2025/uellenberg/prog.alt.c) is also a quine, and is otherwise
identical to prog.c except for formatting, although it's very long and
doesn't fit well in terminal windows, so playing it is difficult. The quine
compiler is available at [https://github.com/uellenberg/Insert](https://github.com/uellenberg/Insert), which
you can use to modify the program and create your own quines!

I've been informed that going into too much depth on how the obfuscated
code works can be considered condescending, and considering that I've
already directed you to the non-obfuscated source code, I have to assume
that any mention of functionality will cause you to implode under the
sheer rudeness of it all. So, I'll instead be talking mostly about
the compiler, and some of the fun tricks that I've implemented to make
the output smaller. There are a lot of optimizations, so I'll skip over
everything typical of a boring compiler (such as gcc, which you probably
used to run it - or maybe you're a clang person, I don't know).

The one thing I will go into more detail on is that the second jumping
game is actually a modified version of pong, and heavily uses its
code to save on size, including the collision, quine update/printing,
and display code (although I like to imagine that in the jumping game,
the ball is actually a dinosaur and the paddles are cacti).

This is inspired by the work of Yusuke Endoh, especially his self-similar
quine. The programs he's created are magnificent, and are what originally
got me interested in quines.


### Usage

I recommend running try.sh and try.alt.sh, as they allow you to play the
game in real-time. Once the game is running, just press "w" to go up
and "e" to go down. Note: I've only tested this under Linux, and your
terminal must be at least 70 characters wide and 60 characters tall,
otherwise the formatting won't display correctly and/or you won't have
the full game in frame. You can also remove the "cp prog.c prog.quine.c"
from try.sh, which will make it resume from the last frame rather than
starting from the beginning.

If you want to run it manually, either use make, gcc prog.c, or clang
prog.c. Both gcc and clang compile cleanly on my machine (GNU compiler
extensions for asprintf are required though), either with or without
-O3, although -Wall complains about some missing parentheses. Then,
call the resulting executable as follows: "./prog w" to move upwards,
"./prog e" to move downwards, and "./prog" to not move at all. Then
compile the output and repeat.

There are two games included in this program. The first is single-player
pong, where you play as the right paddle and the computer plays as the
left paddle. While perfect pong path prediction is an invigorating field,
I do want the user to see the second game, so you will always win against
the computer after a certain number of turns (and I've otherwise kept
the gameplay simple, e.g., reflection is constant regardless of impact
position).

The second game is a jumping game where you try to avoid obstacles moving
towards you by jumping over them. To beat it, all you have to do is avoid
colliding with the left edge (it ends up being way too challenging to
play if the top edge is also an obstacle, and it saves me some bytes ;)
). It's based on the Chrome[tm] Dinosaur game, but I prefer Firefox[tm]
so I needed an alternative.

Each time you beat one of these games, it transitions into the other,
and you can keep playing both forever (I think you'd have more fun trying
to figure out the code, though).


### Obfuscations

The following obfuscations were used in this program:

* The output is a quine, which by its nature makes the program harder to analyze.
* Variables are, naturally, used for multiple purposes including local variables during runtime and global variables copied over between quine iterations.
* Both games share a lot of the same code, and in particular the pong -> jump transition code is intentionally confusing.
* Magic numbers are used everywhere and sufficiently incomprehensible, though I've seen a lot of non-obfuscated code that uses this technique as well, so it might not count.
* Repeated sections of code are replaced with defines, so you get to learn my custom C dialect that's very efficient and also only I know how to use properly (this one might not count either).
* All identifiers (except for built-in functions, of course) are single characters. That means it's okay to use the variable for multiple different things, since it had no meaning to begin with.
* Iteration tastefully replaced with recursion.
* The data array itself has certain characters replaced with others, making it harder to analyze, and also has static and mutable data intermixed.


### Quine Compiler

You may be curious why someone would devote their time to building
a compiler for self-modifying quines, and I would encourage you to
instead ask why someone would devote their time to building obfuscated
C programs. It turns out to be the same answer (although deriving it
is left as an exercise to the reader). You may also be curious how much
free time I have, and I would answer your question with a question and
swiftly change topics.

Silliness aside, I think there is a bit of merit for a compiler like
this. I love obfuscated and clever code, but by its very nature it's
difficult to understand. There's a lot of fun in deciphering a puzzle
like that, but I also want to be able to create something that someone
can easily follow (not to mention myself, if I ever decide to change
something in the future). That was really my goal with this project,
to put readable source code in and get a clever program out, and I'm
quite proud of the results. I also never intended to obfuscate anything,
just compress the output as much as possible, although that's often the
same thing. Paradoxically, when the compiler fails to optimize something,
the output also looks obfuscated. I can only conclude that the purpose
of a compiler is to take readable input and scramble it up until the
pieces are too small to put back together again.

Overall, it was one of my favorite projects, and implementing all the
optimizations to push the size below the maximum was super rewarding.

#### Quines

I first want to say that I'm not completely satisfied with the way quines
work in the compiler. If you take a look at the source code you can see
a lot of compiler magic surrounding this, especially where the compiler
replaces spaces and newlines with automatically chosen characters. In
a future version all of this will be moved into user code, allowing
a lot more flexibility with the different types of quines that can be
implemented. I already have a full compile-time interpreter (currently used
for static and const evaluation), which will allow writing post-processing
code that allows modifying the quine array and other pieces which are
injected into the program.

Quines are implemented using three features: markers, bindings, and
quine variables. Markers are used to divide up the input into sections,
and those sections are carried through to the output code. For example:

```
    let a: i32 = 10;
    marker afterA;
    let b: i32 = 20;
```

Gets compiled into:

``` <!---c-->
    int a = 10;
    // <-- marker afterA
    int b = 20;
```

Bindings are essentially two-sided markers, and are used to mark an expression in the output. For example:

```
    let a: i32 = binding myBinding (b + c);
```

Gets compiled into:

``` <!---c-->
    int a = /* myBinding */ b + c /* myBindingEnd */;
```

On their own they do nothing, but they're very important for quines
(especially self-modifying ones). When you create a marker or binding,
it makes it easy to edit a specific part of the program's source code
during runtime, so we could update the expression at binding "myBinding"
with "c + d", print the quine, and the new source code would contain
that expression instead.

That leads me to quine variables. A typical quine looks like this:

``` <!---c-->
    static quineArr: &[string] = $quine;

    function main() {
        for let i: i32 = 0; i < $quineLen; i += 1; {
            // The compiler will emit an empty string
            // for where the quine array should be printed.
            if quineArr[i][0] == '\0' {
                printQuineArr(quineArr);
            } else {
                printf("%s", quineArr[i]);
            }
        }
    }
```

The compiler will compile this down to C code, leaving the quine variables
preserved. Then, it uses this nearly complete output to generate the
quine variables and inject it into the program.


#### Variable Merging

Or, written more confusingly (but cooler!), variable reallocation. This
is essentially the same as a standard compiler's register allocation,
except instead of registers, we're allocating variables. Take a look at this code:

``` <!---c-->
    int val1 = 1;
    printf("%i", val1);

    int val2 = 2;
    printf("%i", val2);
    ```

There's no good reason we need two variables here, we can merge val2
into val1 like this, and save the bits of an extra variable declaration:

``` <!---c-->
    int val1 = 1;
    printf("%i", val1);

    val1 = 2;
    printf("%i", val1);
```

This is especially important because I have some abstractions like inline
functions, which create variables all over the place and would bloat the
output. It also lets you write code using multiple distinct variables
without having to worry about the declaration cost, which makes the code
much easier to read. Where it gets really interesting is when you start
considering references:

``` <!---c-->
    int val1 = 1;
    printf("%i", val1);

    int *val1Ref = &val1;

    int val2 = 2;
    printf("%i", val2);
```

If this is all the code, of course we can do the transformation, val1Ref
is never used. But what if it is? And what if another pointer aliases
it? What if we create a pointer to val1Ref?

A straightforward way of solving this is by computing a list of
transitive references (i.e., if a references b, and b references c,
then a references b and c). Then, at every spot where a variable is no
longer live, its transitive references are no longer live as well. We
have to be careful about loops and if statements, but with this we can
start inserting drops for each variable:

``` <!---c-->
    int val1 = 1;
    printf("%i", val1);

    int *val1Ref = &val1;

    int val2 = 2;
    printf("%i", val2);
    drop val2;

    printf("%i", *val1Ref);
    drop val1Ref;
    drop val1;

    int val3 = 3;
    printf("%i", val3);
    drop val3;
```

Now with our drops in place, we can reuse any variable that have already
been allocated (and also remove dead code). Here's the code after the
transformation:

``` <!---c-->
    int val1 = 1;
    printf("%i", val1);

    int *val1Ref = &val1;

    int val2 = 2;
    printf("%i", val2);

    printf("%i", *val1Ref);

    val1 = 3;
    printf("%i", val1);
```

Combined with other passes, these optimizations can be extremely
impactful. Liveness analysis in particular allows us to remove dead code,
and when combined with inlining/constant folding, can further reduce the
number of variables in the output (at the benefit of many magic numbers,
which is of course conducive to obfuscation).


#### Define Compression

This was one of the most daunting parts of the compiler, and I have
to come clean and say that my implementation is far from optimal (both
in terms of time and final output), but it is able to compress C code
pretty well. If we have code with many repetitions of the same text,
we can compress it using a define:

``` <!---c-->
    int a = 1;
    int b = 2;
    // ... many usages of int ...
```

Becomes:

``` <!---c-->
    #define i int
    i a = 1;
    i b = 2;
    // ...
```

There are several factors that make this challenging, namely that this has
to operate on C tokens (not the raw output string), it has to be aware
of the rules for where spaces are required in C, it has to know which
identifiers are available (plus their size, since it affects the cost),
and it has to create defines that compress multiple merged tokens when
profitable. I'll focus on that last point, since it's the trickiest.

The way I approached this was by merging together tokens when that
merge was more profitable, then extracting tokens into defines when
that define is profitable. I'll focus on the merges, since they're
a bit more interesting. The core problem is pretty easy to state:
in a typical program, the token "else" is often followed by an "if",
but not always. So, is it more profitable to merge "else" with "if"
("else if") and create a define for it (and perhaps one for "else"
as well), or is it more profitable to only create a define for "else"?

We can figure this out by estimating the change in bytes (profit;
negative or positive) of creating a define for every pair of tokens,
then greedily merging tokens where the profit of the combined tokens
plus the new profits of each individual token (which now excludes every
instance of the newly merged pair) is greater than the status quo.

From there, we can just greedily pick the tokens (which are now merged)
with the largest profit and create defines for them. This merging step
is extremely important, since half of the defines created for the pong
program are merged tokens. Consider "v 92);", which merged together ["v",
"92", ")", ";"]. Individually, these are certainly not worth a define, but
when merged they tip the scales and start reducing the size of the program.

My goal is to eventually support defines with arguments, but doing so
is even more complex as it requires some sort of fuzzy matching, so I'm
leaving it on hold for now.


<!--

    Copyright © %%DATE_RANGE%% by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
