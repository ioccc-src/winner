## To build:

``` <!---sh-->
    make
```

There is another version which lets you use the arrow keys rather than the more
awkward `,` and `.` keys. See [alternate code](#alternate-code) below.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2001/kev in bugs.html](../../bugs.html#2001_kev).


## To use:

``` <!---sh-->
    ./kev # in one terminal

    ./kev hostname # in another terminal
```

NOTE: each player's paddle is at the bottom and the opponent at the top.


## Try:

``` <!---sh-->
    ./kev                   # in one terminal

    ./kev localhost         # in another terminal on the same host
```

If you need to change the speed you can reconfigure it like (say
for over a network and not the same host):

``` <!---sh-->
    make clobber SPEED=50 all # original default value which is very fast
```

If you wish to change the port you can do so like:

``` <!---sh-->
    make clobber PORT=3773 all
```

Of course if you want a port < 1024 you'll need to be root so don't do that.

And if you know what you're doing you can redefine the call to the `socket(2)`
syscall with the `l_` macro, changing the `L` variable like one would `PORT`. Of
course you can do more than one at the same time. For instance to change the
speed and port:

``` <!---sh-->
    make clobber SPEED=512 PORT=3773 all
```

If you have `xterm` try on one system:

``` <!---sh-->
    xterm -geometry 80x40 -fg green -bg black -fn 9x15bold -e ./kev &
```

and then the other, the client system:

``` <!---sh-->
    xterm -geometry 80x40 -fg green -bg black -fn 9x15bold -e ./kev localhost&
```

This might look nicer than just the terminal itself.


## Alternate code:

This version allows you to use arrow keys on the keyboard rather than the more
awkward `,` and `.` keys to move your paddle.


### Alternate build:

``` <!---sh-->
    make alt
```

You can reconfigure the macros described above in the same way.


### Alternate use:

Use `kev.alt` as you would `kev`.


What happens if you use both, one in one terminal and the other in another
terminal?


### Alternate try:

If you have `xterm` try on one system:

``` <!---sh-->
    xterm -geometry 80x40 -fg green -bg black -fn 9x15bold -e ./kev.alt &
```

and then the other, the client system:

``` <!---sh-->
    xterm -geometry 80x40 -fg green -bg black -fn 9x15bold -e ./kev.alt localhost&
```


## Judges' remarks:

Continuing with this year's "retro game" theme, this is another old game;
arguably, one of the oldest.  Requires a functioning network, and curses.

The graphics aren't the impressive part; the graphics and network are.
How many games come out at $50 and still require you to wait for a patch
to come out before you can play multiplayer?  This one works out of the
box.


## Author's remarks:

**NETWORK PONG!**

### REQUIREMENTS

* TCP sockets
* curses
* `usleep(3)`

### DESCRIPTION

This program is a two-player networked version of the eighties arcade classic,
[Pong](https://en.wikipedia.org/wiki/Pong). It uses standard TCP sockets to
communicate over the net, and `ncurses` for display.  It supports variable
terminal sizes (though both players must have the same terminal size) and game
speeds.  Each player has a paddle to hit the ball, and you get points for
getting the ball past your opponent's paddle.  It's pretty fun!  :)


### RUNNING

Run the server first without any command line arguments, i.e.

``` <!---sh-->
    ./kev
```

Then run the client with a single command line argument which is
the name of the machine running the server, e.g.

``` <!---sh-->
    ./kev localhost
```

Make sure that the terminals on both ends are the same size.  Also, the TCP port
number (by default 5455) specified in the [Makefile](%%REPO_URL%%/2001/kev/Makefile) mustn't be
blocked by a firewall.

Here's a good quick example to see it in action on your own
machine, assuming you have `Xwindows`:

``` <!---sh-->
    xterm -geometry 80x40 -fg green -bg black -fn 9x15bold -e ./kev &
    xterm -geometry 80x40 -fg green -bg black -fn 9x15bold -e ./kev localhost&
```


### PLAYING

Your paddle is the one at the bottom of the screen, your opponent
is at the top.  To move your paddle left, hold down `,` (i.e. `<`
but don't press shift).  To move your paddle right, hold down `.`.
To quit, either player may press `q`.

The current score is shown on the left side of the halfway line.
Your score is the lower number, your opponents score is the upper
number.  Your score is the number of times your opponent has
missed the ball.

You can control the speed of the ball by the motion of your paddle
when the ball hits it.  If your paddle is still, then the ball
just bounces normally off it. If your paddle is moving in the
same direction as the ball, then the ball's speed in that
direction will increase. If your paddle is moving in the opposite
direction to the ball, then the ball's speed in that direction
will decrease (or if the ball is going slowly enough, it'll turn
around).

You might want to increase your keyboard repeat rate before
playing.  On the Linux console try `kbdrate -r 24.0 -d 250`
(`kbdrate` might be "hidden" from normal users in `/sbin`, and you
might need to be root anyway), in `Xwindows` try `xset r rate 250
24` (find out your current rate first with `xset q`, so that you
can reset it later).

Look below in the Building section for info on how to speed up or
slow down the game (useful if you increase or decrease the
terminal size).


### BUILDING

Just run `make` to use the Makefile as above.  The `SPEED` variable in the
Makefile controls the speed of the game (defaults to `50`).  This speed is the
delay between frames in milliseconds.  Thus a value of 0 will make the game go
as fast as your network can handle, and values less than 50 are useful for
larger terminals or more exciting games.  The program needs bandwidth equal to
1/s bytes per second (where `s` is the speed value).  Any latency on the network
will be added to `s` - so you should probably subtract any latency from the
value of `s` you want to have.  Given that `loopback` and fast Ethernet LANs are
both much less than 1ms of latency, you should only need to worry about this if
you plan on playing over a slower link like a cable modem, DSL, or (God-forbid)
dial-up.

The TCP port to use for network communications is specified by the
`PORT` variable in the Makefile.  If the default of `5455` is
blocked for whatever reason, you can change it to something else.
Of course if you use a port < 1024, you'll need to be root.


### OBFUSCATION

The program's broad structure is fairly straightforward, but
individual tasks are rarely done in a straightforward manner.  ;)

Identifier names have mostly been chosen to resemble paddles and
balls, and to generally decrease readability.

The source has been cleverly formatted to resemble one of the
paddles from the game, rotated 90 degrees.  ;)  (The "source
paddle" has approximately the same aspect ratio as the game at 80
columns wide, which is 1:10.)

Finally, the number of "non-whitespace characters" (as defined by
the rules) in the file is exactly 2048, which I think is rather
unexpectedly cool.  :)


### BUGS

There are 3 warnings when I compile with gcc 2.95.3 (`-Wall -ansi
-pedantic`) on my Linux system, but all are completely harmless.

I don't like the curses and/or termcaps/terminfos on IRIX and
Solaris (the only two non-Linux systems I have access to).
Despite calling `timeout(0);`, `notimeout(win, TRUE);`, `nodelay(win,
TRUE);` and/or `keypad(win, FALSE);`, it still seems to force a delay
into calls to `getch()` - I'm guessing at a termcap/terminfo level.
At any rate, I can't seem to force no delay.  This is a shame,
because it basically plays havoc with the input code, particularly
the read-ahead canceller.  It still works, but not nearly as well
(key presses are dodgy and holding down keys doesn't always work),
and so I _much_ prefer and recommend Linux `libncurses`.

Sometimes when `q` is pressed in one, the other will crash out
with `Broken pipe`.

If the specified port can't be bound or connected to, the program
segfaults.

If your terminal is too wide (we're talking gigantic here - over
500 characters wide) then the program can segfault.  It's also
possible to crash the program a player scores over a billion
points (1e9).  Maybe you can consider that the goal...  ;)

If you run the client and server on different architectures, both
architectures need to have the same character systems (i.e. don't
try mixing ASCII and EBCDIC).  It is independent of endianness
though.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
