# Implementation notes

Due to the long time this has been slowly evolving, it's hard to describe
quite whether it's been `implemented`. I think perhaps evolve is a better
term. The basic concept behind the program is to describe a game as a simple,
slightly cheaty, cellular automata system, with some of the transitions
bound to key presses.

For instance, assume you wish to make a boulder `o` roll off a hill `/`
A standard automata would have 2 rules something like this:

```
    o..			...
    \..  -->  'o'		.o.  -->  '.'
    ...			.\.
```

However, the system I devised, in order to keep things small and neat(!),
was to define a 3x3 to 3x3 map (instead of the 3x3 to 1x1 shown above).
Hence:

```
    .o.	  ...
    .\.  -->  .\o
    ...	  ...
```

This does of course have the odd problem with clashes. What if we want to roll
two boulders down simultaneously towards the same square.  I perform no
buffering, and so this situation is just a 'fight it out' and let which ever
transition has priority win. Such a case may produce the following change of
maps (depending on which 'roll' transition is used first).

```
    o.o			..o	    o..
    \./	  changes to	\o/  or to  \o/
    ...			...	    ...
```

I claim that it is possible to perform all of the 3x3 to 1x1 transitions in a
3x3 to 3x3 based system. One other feature added in is a workaround for the 'no
buffering' problem. If we define a space ship (as in the [Space
Invaders](https://en.wikipedia.org/wiki/Space_Invaders) example) to fly right,
and we are 'walking through' our map from top-left to bottom-right, then it is
easy to foresee a situation where our space ship would zip right as far as
possible in only the one cycle of the automata. However, a similar
leftwards-bound space ship would only move the required one square. For this
reason I have two lists of transitions and apply them independently of each
other; first top-left to bottom right, and the second in the reverse direction.
This means that I can make any 'object' move by any amount in a single
transition.

Now comes the key important addition to make it 'game' worthy - the
addition of external control by the user. This is done by requesting that
some transitions are only valid when a certain key has been pressed.
So for example, if we (an `@` symbol) wish to move right when the `l` key
is hit we have a transition like:

## Key: l

```
    * * *		* * *
    * @ .		* . @
    * * *		* * *
```

Here I also use wildcards. On the match side (left) of the transition, an
asterisk will match against any character. On the update side (right), an
asterisk means 'keep whatever was here before'. So the above example
simply means to swap the `@` and `.` around when `l` is pressed. For the
purposes of space saving, this transition is shrunk to a single line.

## Key: K

```
    a b c		1 2 3
    d e f		4 5 6
    g h i		7 8 9
```

is written as: `eabcdfghi512346789K`.

If there are no keys needed for this transition, the character `*1` should
be used instead. Now the format of the game description file is now
the following (angle brackets denote an 'entity' to be defined):


```
    <top-bot transition>*\n<bot-top transition>*\n<X size>[ \t]+<Y size>\n
    <map>
```

The `<X size>` should take into account the newline at the end of each line
of map, and hence should also be one larger than expected.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
