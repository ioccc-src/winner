# Extreme cannibalism in a Snake game

See the [2020 IOCCC 'Don't tread on me' Snake game source code](%%REPO_URL%%/2020/ferguson1/prog.c).

To give an idea what cannibalism can look like (it's I believe a unique feature
to any other version of Snake), this file shows just how extreme cannibalism can
get with a long snake. I made a few changes, described below, to make it easier
to distinguish what is what.


# Examples

In the below game dumps I have replaced the bug with **B**, the head with
**H** and where it is known, the tail with **T**, in order to help
distinguish where they are. Since the head is replaced with **H** I have noted
the direction it was moving above each dump as well as at the right of the line;
each line with a bug, the head or tail is marked with upper case text at the
right to make it easier to find.

The first run I include several dumps but there isn't much information about
most of them.


## Example 0: snake moving right

```
    X:45/89 Y:22/25 S:1675/2001 B:35
    ##########################################################################################
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo#
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo#
    #           o            o      o o o oooo                   o                           #
    #  oooooooooo            o      o o o    ooo              ooooooooo  oooo                #
    #  o               ooooooooooooooooooooooooo              o  o    o  o  o                #
    #  o     ooooooooooo  ooooooooooooooooooooooo    oooooooooooooooo o  o  o                #
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooo   o  o  o o  o  o              oo#
    #  o     o      ooooooooooooooooooooooooooooooooooooooo   o  o  oBo  o  oooo           o # <- *BUG*
    #  o     o      o   ooooooooooooooooooooooooooooooooooooooo  o  o o  o     o           o #
    #  o     o      o   o  o        ooo o  o   oo       oooooooooooooooooooooooo           o #
    #  o   ooooooooooooooooo   oooooooo o  o   oooooooooooo   ooooooooooooooooooooooooo    o #
    #  o   o o      o   oooooo o    o o o  o oooooooooooooooooooooooo o  o  o         o    o #
    #oooooooooooooooooo o  o o o oo o o o  o o oo        oo   o oo  o o  oooooooooooooooooooo#
    #  o   oooooooooooooooooooooooooooooooooooooooooooooooooooo oo  o o  oo o      o  o      #
    #  o     o      ooooooooooooooooooooooooooooooooooooooooooooooooo o  oo o      o  o      #
    #oooooooooo   oooo  o  o   o  o o o o   o  oo      o oooooooooooooooooo ooooooooooooooooo#
    # oooooooooooooooo  o  o   o  ooooooooo o  oo      o o    o  o  o o   ooooooooooooo      #
    # ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo  o  o o            o  o      #
    #oooooo  o        oooooo   o    o o o o o  o       ooooooooooooooooooooooooo   o  ooooooo#
    #        o          o      o    o o o oooo ooooooooooooooooo o  o          o   o  o      #
    #        o          o      oo   o o o   oooooH               o  oooooooo   ooooo  o      # <- *HEAD, RIGHT*
    #ooooooooo          ooooooooooooooooooooo                    ooooooooooo          ooooooo#
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo#
    ##########################################################################################
```


## Example 1: snake moving right

```
    X:79/89 Y:9/25 S:1680/2001 B:36
    ##########################################################################################
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo#
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo#
    #           o            o      o o o oooo                   o                           #
    #  oooooooooo            o      o o o    ooo              ooooooooo  oooo                #
    #  o               ooooooooooooooooooooooooo              o  o    o  o  o                #
    #  o     ooooooooooo  ooooooooooooooooooooooo    oooooooooooooooo o  o  o                #
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooo   o  o  o o  o  o              oo#
    #  o     o      oooooooooooooooooooooooo   oo         o   o oooooooooooooooooooH       o # <- *HEAD, RIGHT*
    #  o     o      o   oooooooooooooooooooooooooooooooooooooooooo  o o  o     o           o #
    #  o     o      o   o  o        o o o  o   oo   o   oooooooooooooooooooooooo           o #
    #  o   ooooooooooooooooo        o o o  o   oooooooooooo   ooooooooooooooooooooooooo    o #
    #  o   o o      o   oooooo      o o o  o oooooooooooooooooooooooo o  o  o         o    o #
    #oooooooooooooooooo o  o o   oo o o o  o o ooo       oo   o oo  o o  oooooooooooooooooooo#
    #  o   oooooooooooooooooooooooooooooooooooooooooooooooooooo oo Bo o  oo o      o  o      # <- *BUG*
    #  o     o      ooooooooooooooooooooooooooooooooooooooooooooooooo o  oo o      o  o      #
    #oooooooooo   oooo  o  o      o o o o   o  ooo     o oooooooooooooooooo ooooooooooooooooo#
    # oooooooooooooooo  o  o      ooooooooo o  ooo     o o    o  o  o o   ooooooooooooo      #
    # ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo  o  o o            o  o      #
    #oooooo  o        oooooo        o o o o o  o o     ooooooooooooooooooooooooo   o  ooooooo#
    #        o          o           o o o oooo ooooooooooooooooo o  o          o   o  o      #
    #        o          o           o o o   oooooo               o  oooooooo   ooooo  o      #
    #ooooooooo          ooooooooooooooooooooo                    ooooooooooo          ooooooo#
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo#
    ##########################################################################################
```


## Example 2: snake moving left

```
    X:53/89 Y:18/25 S:1690/2001 B:38
    ##########################################################################################
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo#
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo#
    #           o            o      o o o oooo                   o                           #
    #  oooooooooo            o      o o o    ooo              ooooooooo  oooo                #
    #  o               ooooooooooooooooooooooooo              o  o    o  o  o                #
    #  o     ooooooooooo  ooooooooooooooooo    o     oooooooooooooooo o  o  o                #
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooo   o  o  o o  o  o              oo#
    #  o  B  o      oooooooooooooooooooooooo   o          o   o oooooooooooooooooooo       o # <- *BUG*
    #  o     o      o   oooooooooooooooooooooooooooooooooooooooooo  o o  o     o   o       o #
    #  o     o      o   o  o        o o o  o   o    o   oooooooooooooooooooooooo   o       o #
    #  o   ooooooooooooooooo        o o o  o   oooooooooo o   ooooooooooooooooooooooooo    o #
    #  o   o o      o   oooooo      o o o  o oooooooooooooooooooooooo o  o  o      o  o    o #
    #oooooooooooooooooo o  o o   oo o o o  o o o o        o   o oo oooooooooooooooooooooooooo#
    #  o   oooooooooooooooooooooooooooooooooooooooooooooooooooo oo oo o  oo o      o  o      #
    #  o     o      ooooooooooooooooooooooooooooooooooooooooooooooooo o  oo o      o  o      #
    #oooooooooo   oooo  o  o      o o o o   o  o o     o  ooooooooooooooooo ooooooooooooooooo#
    # oooooooooooooooo  o  o      ooooooooo o  o o     o Hooooooooooo o   ooooooooooooo      # <- *HEAD, LEFT*
    # ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo  o  o o            o  o      #
    #oooooo  o        oooooo        o o o o o  o o     ooooooooooooooooooooooooo   o  ooooooo#
    #        o          o           o o o oooo ooooooooooooooooo o  o          o   o  o      #
    #        o          o           o o o   oooooo               o  oooooooo   ooooo  o      #
    #ooooooooo          ooooooooooooooooooooo                    ooooooooooo          ooooooo#
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo#
    ##########################################################################################
```


## Example 3: snake moving left

```
    X:61/89 Y:6/25 S:1815/2001 B:63
    ##########################################################################################
    #           oooooooooooooooooooooooooooooooooT                                           # <- *TAIL*
    #           o                                                                            #
    #     ooooo o      ooooooooooo                                                           #
    #  oooooooooo      o         o                B                   ooooooooooooooooooooo  # <- *BUG*
    #oooooo   o oooooooooooooooooooooooooooooooo                 Hooooooooooooooooooooooooooo# <- *HEAD, LEFT
    #  o   ooooooooooooooooooooooo             o              oooo    o  o  o  o     ooo     #
    #  o   o oooo          oooooooooooooooooooooooooooooooo   o  ooooooooooooooooooo ooo     #
    #  o ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo ooo     #
    #  o o o o     oooooooooooooooooooooooooooooooooooooooooooooo     o  o     o   o ooo     #
    #  o oooooooooooooooooooooooooooooooooooooooooooo o oooooooooooooooooooooooooooooooo     #
    #ooooooooooooooooooooooo               o   oooooooooo o   ooooooooooooooooooooooooooooooo#
    #  o   o o      o   oooooo             o ooooooooooooooooooooooooooooooooooooooooooo     #
    #oooooooooooooooooo o  o o   oo        o o   o    ooooo   o o  oooooooooooooooooooooooooo#
    #  o   oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo o  oo    oo      #
    #  o     o      oooooooooooooooooooooooooooooooooooooooooooooooooo   oo o  ooooooooooo   #
    #oooooooooo   oooo     oooooooooooooo        o    o   ooooooooooooooooo ooooooooooooooooo#
    # oooooooooooooooo     oo     ooooooooo      o    oooooooooooooo o    ooooooooooooooooo  #
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooo      o         oooooooooooooo#
    #oooooo ooooooooooooooooooooooooooooooooooooooooo         o    ooo                ooooooo#
    #       oo       o      oooo          oooo   o  o         oooooo                  o      #
    #       ooooooooooooooooo  ooooooooooooooooooo  oooooooooooooooooooo              o      #
    #ooooooooo       ooooooooooooooooooooooooooooooooooooooooooooo                    ooooooo#
    #                                                                                        #
    ##########################################################################################
```


## Example 4: snake moving left

```
    X:47/89 Y:5/25 S:1815/2001 B:63
    ##########################################################################################
    #           ooooooooooooooooT                                                            # <- *TAIL*
    #           o                                                                            #
    #     ooooo o      ooooooooooo                    oooo                                   # <- *HEAD, LEFT*
    #  oooooooooo      o         o                BHooo  o            ooooooooooooooooooooo  # <- *BUG*
    #oooooo   o oooooooooooooooooooooooooooooooo         oooooooooooooooooooooooooooooooooooo#
    #  o   ooooooooooooooooooooooo             o              oooo    o  o  o  o     ooo     #
    #  o   o oooo          oooooooooooooooooooooooooooooooo   o  ooooooooooooooooooo ooo     #
    #  o ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo ooo     #
    #  o o o o     oooooooooooooooooooooooooooooooooooooooooooooo     o  o     o   o ooo     #
    #  o oooooooooooooooooooooooooooooooooooooooooooo o oooooooooooooooooooooooooooooooo     #
    #ooooooooooooooooooooooo               o   oooooooooo o   ooooooooooooooooooooooooooooooo#
    #  o   o o      o   oooooo             o ooooooooooooooooooooooooooooooooooooooooooo     #
    #oooooooooooooooooo o  o o   oo        o o   o    ooooo   o o  oooooooooooooooooooooooooo#
    #  o   oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo o  oo    oo      #
    #  o     o      oooooooooooooooooooooooooooooooooooooooooooooooooo   oo o  ooooooooooo   #
    #oooooooooo   oooo     oooooooooooooo        o    o   ooooooooooooooooo ooooooooooooooooo#
    # oooooooooooooooo     oo     ooooooooo      o    oooooooooooooo o    ooooooooooooooooo  #
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooo      o         oooooooooooooo#
    #oooooo ooooooooooooooooooooooooooooooooooooooooo         o    ooo                ooooooo#
    #       oo       o      oooo          oooo   o  o         oooooo                  o      #
    #       ooooooooooooooooo  ooooooooooooooooooo  oooooooooooooooooooo              o      #
    #ooooooooo       ooooooooooooooooooooooooooooooooooooooooooooo                    ooooooo#
    #                                                                                        #
    ##########################################################################################
```


## Example 5: snake moving left with snake inside itsself

Another example invocation where the snake head is in the snake and where the snake
hadn't yet moved (that is it was still growing):

``` <!---sh-->
    CANNIBAL=1 SIZE=1500 GROW=2 MAXSIZE=1600 ./prog
```

It looked like:

```
    X:55/89 Y:11/25 S:1564/1600 B:32
    ##########################################################################################
    #                 oooo           ooooooooooooooooooooooooo       o                       #
    #                 o  ooooooooooooooooooooooooooooooooooooooooooooo ooooooooooooooooo     #
    #ooo              o            o                         o       o o               oooooo#
    #  o              o            o        oooooooooooooooooooooooooo o                     #
    #oooooooooooooooooooooooooo    o      ooo                o      oo oooooooooooooooooooooo#
    #oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo#
    #  o   o        ooooooooooooo oooooooooooooooooooooo    ooo     oo     o o           o oo#
    #ooo   o        o         oooooo      o         oooo    ooo     oo     o o           oooo#
    #  o   o        o           oooo      o         o oo    ooo     oooooooooooooooooo     oo#
    #  o   o        o ooooooooooooo  oooooooooooooooo oooooHoooooooooooooooooooooooooooooo   # <- *HEAD, LEFT*
    #  o   o        o o      ooooooooo    oooooooooooooooooooooooooooo     o o       o   o   #
    #  o   ooooooo  o o      o    oooooooooooooo       o    o o      o     o o       ooooo   #
    #  o         o  o o      o    o          o         o    o o      o     o o               #
    #  o         o  o o      o    o          oB    ooooooooooooooooooo     o o        ooo    # <- *BUG*
    #  o         o  o o      o    oooooooooooooooooooooooooooooooooooooooooooo        o o    #
    #  oooooooooooooo o      o    oo      o  o     oooooooooooooooooooooooooooooooooooooo    #
    #     o      oo   o      o    oo  oooooooooooooo   o    o o            oooooooooooo      #
    #oooooo      oo   oooooooooooooo  o   o  o         o    o o        ooo             oooooo#
    #            ooooo       o    o   o   o  oooooooooooooooooooooooooooooooo          o     #
    #             o  oooooooooooooo   o   o            o    o    ooooooooo  o          o     #
    #             o          o        oooooo           o    oooooooooooo    o          o     #
    #             oooooooooooooooooooooooooooooooooooooooooooooooooooo      ooo        o     #
    #                        ooooooooooo   ooooooooooooo             o        oooooooooo     #
    ##########################################################################################
```

...and no **_Preciouss_**: the _itsself_ was not a typo but intentional sibilance!


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
