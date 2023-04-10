# Worst Driver:

    Chris King
    115 Foster Center Road
    Foster, RI, 02825
    USA

## To build:

```sh
make
```

## To run:

```sh
./ctk
```

[Yusuke Endoh](/winners.html#Yusuke_Endoh) provided a patch to fix the ANSI
escape codes. It became apparent to [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) (when he was looking at the source
code of this entry) that it was no longer valid ANSI escape sequences. He has
used them before (who hasn't ?) but that was a long time ago and with Yusuke's
patch it works.  Cody notes that this fix will not just work for linux but macOS
too. Thank you Yusuke for your assistance!


## Try:

```sh
echo "Do or do not. There is no try."
```

Make sure to hit 'q' to exit or else your terminal will be messed up (to restore
it you can try `stty sane` or `reset`).

## Judges' remarks:

No matter how careful you are, this guy eventually crashes.  Most people
can make at least one successful road trip without crashing.

This is, of course, another of the retro games.

## Author's remarks:

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

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
