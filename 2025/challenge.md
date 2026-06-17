# Return to [%%DESCRIPTION%%](index.html)

A "**fun challenge**" for a winning IOCCC entry is a puzzle or task
that an [IOCCC judge](../judges.html) suggested people consider solving.
After you figure out what a given winning entry does, we encourage you
to attempt the fun challenge(s).

Some fun challenges ask you to explain something about a winning
IOCCC entry. Other fun challenges ask you to produce a variant of the
`prog.c` program that has a different or enhanced behaviour. And still,
other types of fun challenges may be posed.

**NOTE**: Some of these challenges are easier than others.

See also the
FAQ on "[fun challenges](../faq.html#what_fun_challenge)"
and, to provide a solution, the
FAQ on "[submitting a solution to a fun
challenge](../faq.html#solve_fun_challenge)".


<div id="ayu">
## Fun challenge for [2025/ayu](ayu/index.html)
</div>

This fun challenge for **2025/ayu** is **CLOSED**.

Modify `prog.c` so that the code allows for `N` to be
defined for values larger than `11`, e.g., that works with `-DN=12`,
and up to some reasonable limit.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="ayu_solution">
#### Fun challenge solution for [2025/ayu](ayu/index.html)
</div>

[Master-Hash](https://github.com/Master-Hash) on **2026 Jun 09** presented this
[2025/ayu fun challenge solution](https://github.com/Master-Hash/ioccc--ayu-2025-fun-challenge).


<div id="cable">
## Fun challenge for [2025/cable](cable/index.html)
</div>


<div id="cable_0">
### Fun challenge 0
</div>

This fun challenge for **2025/cable** is still **OPEN**.

Use the [toolchain](https://github.com/adriancable/eternal) to compile your own
software to run on this VM.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="cable_1">
### Fun challenge 1
</div>

This fun challenge for **2025/cable** is still **OPEN**.

Produce a variant of the vmlinux bootimage that contains a C compiler for this
VM.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="cesmoak">
## Fun challenge for [2025/cesmoak](cesmoak/index.html)
</div>

This fun challenge for **2025/cesmoak** is still **OPEN**.

Modify `prog.c` so that the code supports the FORTRAN **READ** statement.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="diels-grabsch">
## Fun challenge for [2025/diels-grabsch](diels-grabsch/index.html)
</div>

This fun challenge for **2025/diels-grabsch** is still **OPEN**.

Explain the purpose of the constant `9018655` as used in `prog.c`.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="dogon">
## Fun challenge for [2025/dogon](dogon/index.html)
</div>


<div id="dogon_0">
### Fun challenge 0
</div>

This fun challenge for **2025/dogon** is still **OPEN**.

Explain why `prog.c` prints the number of digits of the **constant** that it
prints.


<div id="dogon_1">
### Fun challenge 1
</div>

This fun challenge for **2025/dogon** is still **OPEN**.

Given the "*constant*" that is printed, explain the last line of output:

``` <!---sh-->
    ./prog | tail -1
```


<div id="dogon_2">
### Fun challenge 2
</div>

This fun challenge for **2025/dogon** is **CLOSED**.

Modify `prog.c` so that the code that prints **IOCCC 2025** at
the very end, in honor of the contest year in which it won, instead of
**IOCCC 2026**.  Of course, the digits printed beforehand should remain
the same.


<div id="dogon_2_solution">
#### Fun challenge 2 solution for [2025/dogon](dogon/index.html)
</div>

[Samantha Howard](https://github.com/psymar) on **2026 Jun 09** presented this
[2025/dogon fun challenge 2 solution](https://github.com/psymar/IOCCC-dogon-2025-fun-challenge-2).


<div id="dogon_3">
### Fun challenge 3
</div>

This fun challenge for **2025/dogon** is **CLOSED**.

Additionally, observe the [try.sh](%%REPO_URL%%/2025/dogon/try.sh) script uses the
following display the program's output:

``` <!---sh-->
    ./prog | cat
```

However, the following may, for some environments, print what seems like garbage:

``` <!---sh-->
    ./prog
```

Explain why this command:

``` <!---sh-->
    ./prog | cat > foo
```

may produce, for some environments, different output than the following command:

``` <!---sh-->
    ./prog > bar
```


<div id="dogon_3_solution">
#### Fun challenge 3 solution for [2025/dogon](dogon/index.html)
</div>

[Ilya Kurdyukov](../authors.html#Ilya_Kurdyukov) on **2026 Jun 09** presented this
**2025/dogon fun challenge 3 solution**:

In [2025/dogon/prog.c](%%REPO_URL%%/2025/dogon/prog.c) we find:

``` <!---c-->
    int *e; e=(int*)calloc(-~(e==e)<<-~(!(e>e)<<-~-~-~!(e<e)),-~!(e>e));

```

The pointer to the integer `e` is uninitialized in the expressions that
form both arguments to the `calloc(3)` library call.

In some environments, the clang compiler might compile that C code as:

``` <!---c-->
    int *e; e=(int*)calloc(2, 1);

```

In some environments, the gcc compiler might compile that C code as:

``` <!---c-->
    int *e; e=(int*)calloc(262144, 2);

```

If you move the declaration of the pointer to the integer `int*e;` out of
`main()` and into global variable space where it will be initialized to 0,
the standard output will be "normal".

For example, and ignoring the fun layout of [2025/dogon/prog.c](%%REPO_URL%%/2025/dogon/prog.c):

``` <!---patch-->
    --- prog.c      2026-06-09 11:26:01
    +++ prog.fix.c  2026-06-17 00:25:40
    @@ -2,10 +2,11 @@
     #include <stdlib.h>
     #define E printf
     #define F char
    +int*e;


                                                                                                                                         main()
    -           {                                                                                                                    int*e;for(                      e
    +           {                                                                                                                          for(                      e
               =(                                                                                                                   int*)calloc                      (-
              ~(                                                                                                                    e==e)<<-~(!                       (e
              >e                                                                                                                    )<<-   ~-~-                        ~!
```

When you compile `prog.fix.c` into `prog.fix`, the standard output will be "normal".


<div id="endoh1">
## Fun challenge for [2025/endoh1](endoh1/index.html)
</div>

This fun challenge for **2025/endoh1** is still **OPEN**.

Modify `prog.c` so that the code also works with UPPER CASE LETTERS.
You would certainly have to
[embiggen](https://en.wiktionary.org/wiki/embiggen#English)
the tube size to better distinguish individual letters and digits.
Such code would be a [cromulent](https://en.wiktionary.org/wiki/cromulent#English)
addition to [2025/endoh1](%%REPO_URL%%/2025/endoh1/index.html) code.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="endoh2">
## Fun challenge for [2025/endoh2](endoh2/index.html)
</div>

This fun challenge for **2025/endoh2** is still **OPEN**.

Modify `prog.c` so that the code prints a line instead of varying brightness of a yellow line,
using [256 ANSI Color Codes](https://color-palette.hexdocs.pm/ansi_color_codes.html).
Choose a colors/brightness palette to represent the charge intensity.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="endoh3">
## Fun challenge for [2025/endoh3](endoh3/index.html)
</div>

This fun challenge for **2025/endoh3** is still **OPEN**.

Explain why the `git-am` patch generator must be used about 25 times (see
[try.sh](%%REPO_URL%%/2025/endoh3/try.sh) for details) to produce a unified diff tool.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="ferguson">
## Fun challenge for [2025/ferguson](ferguson/index.html)
</div>


<div id="ferguson_0">
### Fun challenge 0
</div>

This fun challenge for **2025/ferguson** is still **OPEN**.

Modify `prog.c` so that the code
allows for different [map projections](https://en.wikipedia.org/wiki/List_of_map_projections).
Add `-p projection` as a command line option to change the default projection.
Add this to a `debug.c` as well for extra points.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="ferguson_1">
### Fun challenge 1
</div>

This fun challenge for **2025/ferguson** is still **OPEN**.

Explain why there are four args (in one invocation) but yet the value of argc, `g`, is
only checked once, besides `g!= 3 && g < 5` (which should tell you the two forms of
invocation).

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="ferguson_2">
### Fun challenge 2
</div>

This fun challenge for **2025/ferguson** is still **OPEN**.

Modify `prog.c` so that the code renders smaller (or larger) sized
arrows, making sure that coordinates at the edge of the map are placed
correctly as well as the other coordinates. Add a `debug.alt3.c` with the same
updates.

**Hint**: To test that the arrows fit on the edge of the map, you should
test coordinates such as `0 0`, `90 180`, `-90 0`, etc. (I.e., coordinates that
cause the arrows to be at the very edge of a map).

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="ferguson_3">
### Fun challenge 3
</div>

This fun challenge for **2025/ferguson** is still **OPEN**.

Modify `prog.c` the code that solves [challenge 2](#ferguson_2),
with a `-p projection` option.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="ferguson_4">
### Fun challenge 4
</div>

This fun challenge for **2025/ferguson** is still **OPEN**.

Explain why `d` has to start at `-1` (bonus: experiment with different values
and explain what happens and specifically why) and why you can't change
the `!=1` in the code:

``` <!---c-->
    if  (d=(c!=e==!d!=d!=d==1&&e!=c)!=1||/* NOW YOU KNOW d IS 1! */fread(c, -*(S[F])-d*3 ,
        b*j,q)^j *j *2)X;
```

**Hint**: the above are related to each other.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="howe">
## Fun challenge for [2025/howe](howe/index.html)
</div>

This fun challenge for **2025/howe** is still **OPEN**.

Modify `prog.c` so that the code is
slightly harder to play by allowing the closest invader to be killed.
Compensate slightly for that difficulty increase by allowing the **shift TAB** key
to cycle in the opposite direction of the **TAB** key.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="jhshrvdp">
## Fun challenge for [2025/jhshrvdp](jhshrvdp/index.html)
</div>

This fun challenge for **2025/jhshrvdp** is still **OPEN**.

Modify `prog.c` so that the code that has an "**Amulet of Yendor**".

In particular, add an "**Amulet of Yendor**" (similar to the "`,`" comma character in the
[rogue 5.4](https://github.com/lcn2/rogue5.4) game) to floor 26. If the
player descends below floor 26 without the amulet, place it on that lower
floor until the player eventually acquires it. Block the player’s ascent
(to a lower floor number) unless they possess the amulet. If the player
returns to the top floor 0 with the amulet, display a winning message, and exit.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="jingp49">
## Fun challenge for [2025/jingp49](jingp49/index.html)
</div>

This fun challenge for **2025/jingp49** is still **OPEN**.

Modify `prog.c` so that the code displays **IOCCC 2025** instead of **DOCTOR WHO**.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="kurdyukov">
## Fun challenge for [2025/kurdyukov](kurdyukov/index.html)
</div>

This fun challenge for **2025/kurdyukov** is still **OPEN**.

Modify `prog.c` so that the code allows for the use of numbers in the
interval `[1, 2^31)`, or even the interval `[1, 2^63)`.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="mattpep">
## Fun challenge for [2025/mattpep](mattpep/index.html)
</div>

This fun challenge for **2025/mattpep** is still **OPEN**.

Explain how the argument to `./prog` determines if input is encoded or decoded.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="ncw1">
## Fun challenge for [2025/ncw1](ncw1/index.html)
</div>


<div id="ncw1_0">
### Fun challenge 0
</div>

This fun challenge for **2025/ncw1** is still **OPEN**.

Create a 32K ROM file that tests if `2^p-1`, is a Mersenne prime using the
[Lucas–Lehmer primality test](https://en.wikipedia.org/wiki/Lucas–Lehmer_primality_test).

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="ncw1_1">
### Fun challenge 1
</div>

This fun challenge for **2025/ncw1** is still **OPEN**.

Create a 32K ROM file that tests if `h*2^n-1` is prime, using the
[Lucas–Lehmer–Riesel primality test](https://en.wikipedia.org/wiki/Lucas–Lehmer–Riesel_test).
You may find the pages related to the **Riesel Test** in the
[A Grand Coding Challenge](http://www.isthe.com/chongo/tech/math/prime/prime-tutorial.pdf)
helpful.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="ncw2">
## Fun challenge for [2025/ncw2](ncw2/index.html)
</div>

This fun challenge for **2025/ncw2** is **CLOSED**.

Modify `prog.c` so that the code with a modified `p[]` array prints
the string `IOCCC 2025` followed by a newline.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="ncw2_solution">
#### Fun challenge solution for [2025/ncw2](ncw2/index.html)
</div>

[Antoine Mathys](https://github.com/antoine-mathys) on **2026 Jun 09** presented this
[2025/ncw2 fun challenge solution](https://github.com/antoine-mathys/IOCCC-2025-ncw2-fun-challenge).


<div id="ncw3">
## Fun challenge for [2025/ncw3](ncw3/index.html)
</div>

This fun challenge for **2025/ncw3** is still **OPEN**.

Modify `prog.c` so that the code draws a Julia set.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="tompng">
## Fun challenge for [2025/tompng](tompng/index.html)
</div>

This fun challenge for **2025/tompng** is still **OPEN**.

Explain the purpose of the constant `.5`, used several times in `prog.c`.
How does changing `.5` to a different value affect the generated sound?

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="uellenberg">
## Fun challenge for [2025/uellenberg](uellenberg/index.html)
</div>


<div id="uellenberg_0">
### Fun challenge 0
</div>

This fun challenge for **2025/uellenberg** is still **OPEN**.

Write an alternate version of `try.sh` that detects when the quasi-quine,
left to its own iterative devices, starts to repeat.

If you do not attempt to move the paddle, and let the game run on its
own, the game should "evolve" to other "modes", and eventually cycle back
to the original style of game play.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="uellenberg_1">
### Fun challenge 1
</div>

This fun challenge for **2025/uellenberg** is still **OPEN**.

Implement an additional game mode using only the original game objects
(the ball and two paddles).

For example, you could implement a "flappy bird" game using the ball
as the bird and the paddles as the pipes.

As an extra challenge, try to keep the original behavior of the program
the same, with this new game mode added on top.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="uellenberg_2">
### Fun challenge 2
</div>

This fun challenge for **2025/uellenberg** is still **OPEN**.

Create a version of the game that "plays itself", running through all
the gameplay without user input and returning to the exact source code
it started with.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="yang1">
## Fun challenge for [2025/yang1](yang1/index.html)
</div>

This fun challenge for **2025/yang1** is still **OPEN**.

Modify `prog.c` so that the code allows for integers, somewhat
larger than `9999`, to be tested for primality.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="yang2">
## Fun challenge for [2025/yang2](yang2/index.html)
</div>

This fun challenge for **2025/yang2** is still **OPEN**.

Modify `prog.c` so that the code implements the compression algorithm
used in the entry as a standalone program outputting a bitstream, and
compare its performance with `gzip -1`.

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".


<div id="yang3">
## Fun challenge for [2025/yang3](yang3/index.html)
</div>

This fun challenge for **2025/yang3** is still **OPEN**.

Explain the purpose of the constant `114` in `prog.c`.
Are there any alternative values that could replace `114` without affecting the
program’s functionality?

See also the
FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".
