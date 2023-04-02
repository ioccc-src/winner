# Most Obfuscated Packaging:

Don Dodson
AG Communication Systems
17239 N. 19th Ave. #1003
Phoenix, AZ 85023  
USA

## To build:

        make all

## To run:

	./dodsond2

## Judges' comments:

The original source file may be found in [dodsond2.gz](dodsond2.gz).  For people
who don't have `gunzip`, an unzipped version is provided as
[dodsond2.c](dodsond2.c).

Each year people find new ways to squeeze more and more out of the
contest rules.  Next year, entries that use compression utilities
to get around the size limit will find themselves squeezed out of
the contest!

## Author's comments:

Go searching for the Wumpus in the Caverns of Doom!  But be careful...
There are pits and bats waiting to seal your fate, as well as a 
stealthy robber lurking in the shadows.  Move through the rooms by 
typing the number of the adjacent room you wish to visit.  You can 
feel a breeze if there is a pit in an adjacent room.  A rustling sound 
will tell you that bats are nearby.  The scent of the evil Wumpus can 
be detected from 2 rooms away.

To win, you must find one or more arrows, determine where the Wumpus 
is, and shoot him, all without falling into a pit or becoming the 
next meal for the Wumpus.  To shoot an arrow, type "s".  Then give a 
list of the rooms you want to shoot into.  The rooms must be 
connected in the order you list them, or else the arrow may bounce 
back and hit you.  An arrow can go through as many as four rooms.  
But beware, because shooting an arrow and missing the Wumpus may
awaken him.

There is a robber who waits in an unknown room. If you enter
that room carrying an arrow, he will steal that arrow from you
and move to a new room.  If he steals all the arrows in the
Caverns, you may catch him and recover all of them.  Doing this
gives you a bonus on your score.

You can quit at any time by typing 'q'.  Typing 'i' will tell
you how many arrows you are carrying.  'l' prints the description
of the current room again.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
