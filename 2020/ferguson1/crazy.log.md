The following are a few screen dumps of:

``` <!---sh-->
    SIZE=100 SHEDS=5 GROW=-10 SHED=50 MAXSIZE=250 ./prog
```

As you will see it took 17 bugs to get down to below 0. Notice how I had to get
down to 0 more than once: because I moved enough times before I got the last
bug that I grew by 5 in size. I then however moved a bit more and ate a bug
which brought me down to -5 therefore winning at the max size of 250. This then
showed:

```
    YOU WIN!
    X:62/89 Y:5/25 S:250/250 B:17
```

Observe all the arrows on the screen; that's where a bug was that I ate and
then I split off losing 10 in size. The first dump I'm already at 15/250:

```
    X:17/89 Y:15/25 S:15/250 B:13
    ##########################################################################################
    #                         <ooooooooo        o                <ooooooooo*                 #
    #                                           o   o>                                       #
    #                                           o ooo                        oooo            #
    #                                           o o         ooooooooo>       o  v            #
    #                                           o o  oo                      o               #
    #                                           o o   o                      o               #
    #                                           o o   o                      o               #
    #                                         <oo o   o                      o               #
    #                                                 o                                      #
    #                                                 o                 o                    #
    #                                                 o                 o                    #
    #                                                 o                 o          o         #
    #                                                   <ooo            o          oooooooo> #
    #                <oooooooooooooo                       o            o                    #
    #                                                      o            o                    #
    #                                                      o            o                    #
    #             < ooo                                    o            o                    #
    #                                                      o            o                    #
    #                                                      o            v                    #
    #                                           oooooo>                                      #
    #                                                                o                       #
    #                                                                o    o>                 #
    #                                                                oooooo                  #
    ##########################################################################################
```

But here now I'm at 0; the head is marked `H` and it's moving left.

```
    X:19/89 Y:12/25 S:0/250 B:16
    ##########################################################################################
    #                         <ooooooooo        o                <oooooooo  <ooooooo         #
    #                                           o   o>                             oo        #
    #                                           o ooo                        oooo            #
    #                                           o o         oooooo*oo>          v            #
    #                                           o o  oo                   o oo>              #
    #                                           o o   o                   o oo               #
    #                                           o o   o                   oooo               #
    #                                         <oo o   o                      o               #
    #                                                 o                                      #
    #                                                 o                 o                    #
    #                  H                              o                 o                    # <- *HEAD, LEFT*
    #                                                 o                 o          o         #
    #                                                   <ooo            o          oo ooooo> #
    #                                                      o            o                    #
    #                                                      o            o                    #
    #                                                      o            o                    #
    #             < ooo                                                 o                    #
    #                                                      o            o                    #
    #                      <oooooooo                       o            v                    #
    #                                           oooooo>                                      #
    #                                                                o                       #
    #                                                                o    o>                 #
    #                                                                oooooo                  #
    ##########################################################################################
```

I ended up moving enough times where my size went back up to 5.

Below the snake is moving right and its head is indicated by a `H` with the line
marked at the right; the bug is marked as `B` and is also marked at the right.
Notice how it's in the body of the snake (but see below)!

```
    X:55/89 Y:4/25 S:5/250 B:16
    ##########################################################################################
    #                         <ooooooooo        o                <oooooooo  <ooooooo         #
    #                                           o   o>                             oo        #
    #                                                  ooooH                 oooo            # <- *HEAD, RIGHT*
    #                                           o o         ooooooBoo>          v            # <- *BUG*
    #                                           o o  oo                   o oo>              #
    #                                           o o   o                   o oo               #
    #                                           o o   o                   oooo               #
    #                                         <oo o   o                      o               #
    #                                                 o                                      #
    #                                                 o                 o                    #
    #                                                 o                 o                    #
    #                                                 o                 o          o         #
    #                                                   <ooo            o          oo ooooo> #
    #                                                      o            o                    #
    #                                                      o            o                    #
    #                                                      o            o                    #
    #             < ooo                                                 o                    #
    #                                                      o            o                    #
    #                      <oooooooo                       o            v                    #
    #                                           oooooo>                                      #
    #                                                                o                       #
    #                                                                o    o>                 #
    #                                                                oooooo                  #
    ##########################################################################################
```

But did you see anything strange? The bug is on the fourth line below the upper wall.
However it appears to be inside the body of the snake! But actually that's just where
the snake split off at some point: the snake no longer occupies that place and indeed I
could safely go through that part of the screen.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
