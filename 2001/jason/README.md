## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./jason
```


## Judges' remarks:

You are in a maze of twisty little passages, all alike.

The really amazing part of this is that it's a text adventure, and there's
not a single word in the source that isn't a C keyword or function name,
being used as such.

The interface isn't very tolerant of errors, but you can't really
expect that from something this small.

Of particular interest:  Go ahead, run it through the preprocessor.  You
*still* won't see the words that are used in the game.

If you run it through a beautifier you might cause a crash as most of the
whitespace is significant. Also, if you attempt to change one character
identifiers to longer names expect problems. Even swapping the `Y` and `Z` can
cause problems. Go ahead, try it! :-)


## Author's remarks:

TED Shroyer came up with the idea that made it possible to hide all
the text.  Thanks, TED.  You won.  :)

``` <!---sh-->
    cc -o jason jason.c
    ./jason
    you are in a maze of twisty little passages
    caves lead:  left forward back
    you see
       a lamp
    > _
```

This program is a rather nostalgic little labyrinth game.  Start
out by typing "`get lamp`", then use the direction words "`left`",
"`right`", "`forward`", and "`back`" to explore the caves.  Note that
these words can refer to different passages depending on which way
you're facing.  "`back`" always takes you back the way you came.
Type "`quit`" to quit.

The maze is randomly generated each time you play.  The algorithm
ensures that you start at least 6 hops away from the exit.  All
passages are two-way.

(There is a trick, well-known among
[Adventure](https://en.wikipedia.org/wiki/Colossal_Cave_Adventure) game fans, to
keeping one's bearings in games like this.  Unless you know the
trick, it can be very difficult to find your way around.  Try it
out first; I'll give away the secret at the bottom of this
document.)

The goal is to collect 8 treasures (plus the lamp) and escape into
the sunlight - or moonlight, as the case may be.  After a few
minutes, the lamp runs out of oil, and things become perilous.

If you manage to escape, you score 50 points for your hide, 50
points per item, and bonus points for speed.

Why I think this program is obfuscated:

* 70% more `#` symbols than the average entry.

* Where are all the messages?  The game is downright chatty for
  only having two string literals (`"%d \n"` and `"Y\n : ! ,.?>"`).

* There is exactly one loop in the program, a `for` loop, and it is
  clearly the product of a deranged mind.  Running the
  preprocessor only makes it worse.

* Microsoft Visual C++ won't even compile this program, even
  though it is plain ANSI C (*innocent look*) and limits itself to
  the most standard and portable of the standard library
  facilities.

* Most of the whitespace is significant, so attempts to
  beautify it can easily lead to segmentation faults.

* Attempts to replace the one-character identifiers with longer,
  more meaningful names will likewise cause problems.  In fact,
  simply changing all the `Y`s to `Z`s and vice versa results in
  some unexpected side effects.

When all warnings are enabled, some compilers express the desire
to see a few more parentheses.  I respectfully submit that there are
plenty of parentheses in the program (370 in all.)  Besides, any
more would put me over the size limit.  `gcc` also generates a
warning about some calculations not being used.  Having just spent
19 hours staring at this program, sweating over every character, I
swear gcc is wrong.

The program is formatted as a poem, to make it more readable.
I find the plaintive chorus "B?  B?" particularly poignant.
Also, smiley faces are formatted flush left.  (If you don't find
the game entertaining, see if you can find

```
    the fish scales              Q)++j<
    the shooting star         -~- ~ -~i +
```

in the source code.)


### NOTICE to those who wish for a greater challenge:

**If you want a greater challenge, don't read any further**:
just try to understand the program via the source.

If you get stuck, come back and read below for additional hints and information.


### GAME STRATEGY

The trick, of course, is to drop items in empty rooms to mark them.  That way
you usually know if you're in a room you've seen before.  It greatly aids
mapping.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
