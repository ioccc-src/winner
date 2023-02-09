# "For the Birds!" Award

Chris Mills  
Twitter: @MisterXopher  


## Judges' comments:
### To use:

    make
    
    ./prog

### Try:

    Pressing the up arrow and the down arrow at the right time.

### Selected Judges Remarks:

Did you find that mobile application game a bit frustrating?
Well you can adjust the makefile parameters to make life a
bit easier for you:

    make clobber all DW=199999 DW=22 DH=16 DA=50 DI=-150

From the makefile:

    # Game parameters
    #
    DU=99999        # Time between steps in microseconds.
		    # Make it larger if the game is too fast for you.

    DW=28           # Pipe-to-pipe spacing, in columns.
		    # Farther apart is easier.

    DD=20           # Space between pipes.
		    # The difference between DD and DW is the width of a pipe.
		    # Narrow pipes are easier to fly though.

    DH=8            # Height of gap in pipe.
		    # Make this larger to make the game easier.

    DA=100          # Acceleration due to gravity (scaled by 256).
		    # Smaller values make you glide slower.

    DI=-200         # Impulse velocity of a flap (scaled by 256).
		    # Make larger if you want an less intense tapping experience!

    DB='"<o^="'     # Sprite for player when gliding.
		    # HINT: Try using various emoji.
		    # NOTE: The string MUST be enclosed inside double quotes.

    DF='"<ov="'     # Sprite for player when flapping.
		    # HINT: Try using various emoji.
		    # NOTE: The string MUST be enclosed inside double quotes.

    DG='"Tap to Flap!"'     # Instruction text.
			    # Change to your native tongue.
		    # NOTE: The string MUST be enclosed inside double quotes.

Enjoy! 

    TAP!! TAP!! TAP!!
    FLAP! FLAP! FLAP!

## Author's comments:

The Program
===========

Better late than never to jump on the bandwagon of 2014's most successful
mobile game.  The game is called Tappy Bird, and has all the sophisticated
gameplay of the original, except with an exciting twist! (you get to fly to
the right instead of to the left).

In addition, the game features exciting new customization options!  Too hard?
Ran into that damn wall too many times?  Now you can change physics!  Change
any of a number of parameters (speed, gravity, etc.) of the game to suit your
gameplay!

You can even make the game more challenging -- resize the terminal window to
make the world taller or shorter.  You'll never be able to get through the
pipes when they are four times as tall!

Instructions
------------

The instructions are printed at the start of the game:  Tap to Flap!

Hit any key to make your bird fly.  Navigate her between the gaps in the pipes.
Your score is shown in the upper left, along with your current high-score.

Customization options
---------------------

To customize the gameplay, change any of the following options on the compile
command line:

 * `-DU`: Time between steps in microseconds.  Make it larger if the game
   is too fast for you.
 * `-DW`: Pipe-to-pipe spacing, in columns.  Farther apart is easier.
 * `-DD`: Space between pipes.  The difference between `D` and `W` is the
   width of the pipe.  Narrow pipes are easier to fly though.
 * `-DH`: Height of gap in pipe.  Make this larger to reduce the challenge.
 * `-DA`: Acceleration due to gravity (scaled by 256).  Smaller values
   make you glide slower.
 * `-DI`: Impulse velocity of a flap (scaled by 256).  Make this smaller
   if you want an intense tapping experience!
 * `-DB`: Sprite for player when gliding.
 * `-DF`: Sprite for player when flapping.  
 * `-DG`: Instruction text.  Change to your native tongue.

Feel free to try out physics or playfield options to make the game more
interesting.  Try setting the player sprites to change the game completely --
maybe you can be a fish, or a pig -- the options are limitless!  Try using
emoji -- you can be a flying beer mug!

Note that since the `curses` library on POSIX doesn't natively support wide
characters (needed for UTF-8 support, which is needed for emoji), you may need
to make some changes to the `Makefile` to get emoji to work on your system.
To help you get started, I've included some example substitutions for emoji
sprites and instruction text; for example, type

    make EMOJI=beer LANGUAGE=spanish

or

    make EMOJI=globe

for some examples (the full list of options is in the `Makefile`).  Don't
forget to `make clean` first.  If the output doesn't look right, you may need
to link with the "wide" version of `ncurses`.  On MacOSX 10.11, it should work
with the current `-lcurses`; on Linux, you probably need `-lncursesw`.
See the `Makefile` to make this change if you need to.  Or buy a Mac.

You will also need a UTF-8 compatible terminal and an emoji font installed,
and you will need to have your `LANG` environment variable set to use UTF-8.
Again, if this is too complicated, maybe just go and get that Mac.

Future additions
----------------

Future versions of the game will include monitization via the freemium model
with micropayments for customization options, play-to-win and of course
live-streamed targeted video advertising.



--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2016, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
