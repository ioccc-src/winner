# Worst Driver:

    Chris King
    115 Foster Center Road
    Foster, RI, 02825
    USA

# To build:

```sh
make
```

### To run:

```sh
./ctk
```

### Try:

```sh
echo "Do or do not. There is no try."
```

NOTE: this does not show well on the default terminal macOS. It's untested
whether another terminal emulator will work. Make sure to hit 'q' to exit or
else your terminal will be messed up (to restore it you can try `stty sane` or
`reset`).

## Judges' comments:

No matter how careful you are, this guy eventually crashes.  Most people
can make at least one successful road trip without crashing.

This is, of course, another of the retro games.

## Author's comments:

This is a game based on an Apple ][ Print Shop Companion easter
egg named 'DRIVER', in which the goal is to drive as fast as
you can down a long twisty highway without running off the
road.  Use ',./', '[ ]', or 'bnm' to go left, straight, and
right respectively. Use '1234' to switch gears. 'q' quits. The
faster you go and the thinner the road is, the more points you
get. Most of the obfuscation is in the nonsensical if statements
among other things. It works best on the Linux console: you
get engine sound (!) and the * Lock keyboard lights tell you
what gear you're in (none lit=4th).  The 'q' argument (no
leading '-') will silence the sound. It won't work on a terminal
smaller than 80x24, but it works fine with more (try it in an
XTerm with the "Unreadable" font and the window maximized
vertically!).
