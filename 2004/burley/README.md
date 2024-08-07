## To build:

``` <!---sh-->
    make
```

**NOTE**: We FORCE the use of `-O0` even if someone overrides it because this entry
will not work with it enabled.


## To use:

``` <!---sh-->
    ./burley
```

**NOTE**: you need to input a number first. See judges' remarks below for
information on how to play.


## Judges' remarks:

This is a [draw poker](https://en.wikipedia.org/wiki/Draw_poker) program.  You
start with $100.  Input alternates between your bet and which cards to keep.

### Example:

Here is an example.

First, enter your bet (say `5`) (for $5, defaults to $1). You might then see
something like:

> J Q J 9 5<br>
> C H D S C

That indicates your hand is Jack of Clubs, Queen of Hearts, Jack of Diamonds, 9
of Spades and 5 of Clubs.

Now enter what cards you want to keep (enter 0 to 5 digits between 1 and 5).
Let's say you want to keep 1, 2 and 3 so you enter `123`. You should see
something like the following after you hit enter:

> J Q J J Q<br>
> C H D S C

which tells you that your new hand is Jack of Clubs, Queen of Hearts, Jack of
Diamonds, Jack of Spaces and Queen of clubs. You might now see something like:

> $145 (45)

which tells you that your new balance is now $145. You had a Full House so your
payoff is 9 times your bet == 45.

#### Payout:

The payout is according to "Vegas rules":

- **Straight Flush**
    * 50 times your bet
- **Four of a Kind**
    * 25 times your bet
- **Full House**
    * 9 times your bet
- **Flush**
    * 6 times your bet
- **Straight**
    * 4 times your bet
- **3 of a Kind**
    * 3 times your bet)
- **2 Pair**
    * 2 times your bet
- **Jacks or Better**
    * 1 times your bet

### Other things:

The program allows you to go into debt.  However I'm sure you would never
control-C to kill the program just because you got behind, right?  On the other
hand the program never willingly exits, so you have to leave even when you are
ahead.  :-)

Can you figure out a winning betting "strategy"?  Then can you modify
the program so this "strategy" no longer works?

Notice the clever use of `setjmp(3)` and `longjmp(3)` calls.  Can you keep track
of what state is being saved and restored?

**NOTE**: the author talks about how it is a single statement. This might not be
strictly true in 2023 for the fixes for it to work so you can look at the
original file [burley.orig.c](%%REPO_URL%%/2004/burley/burley.orig.c) to see
what is meant.


## Author's remarks:

This program plays draw poker.  What is unusual about it is that it
is written as a single statement -- count the semicolons!  (OK, there
are really three statements if you count the variable declarations.)  To
keep things simple, I have avoided the C preprocessor and tricky
statements such as `if`, `for`, `do`, `while`, `switch`, and `goto`.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
