# Best Game

James Bonfield\
University of Warwick\
7 Water End\
Wrestlingworth\
Sandy Beds\
SG19 2HA\
England


## To build:

```sh
make all
```


## To use:

```sh
./rince
```


## Judges' remarks:

This entry has been updated to allow most ANSI C compilers.


## Author's remarks:

This program is a simple puzzle type game. (I'll leave you to play
it to see the rest of it .. :-) .)  The general idea was to try and
write the smallest playable game, but keep the playability and
enjoyment high.

### Instructions:

Key to map:

```
			|
 ######                 | | | /\   /--\  ==|    /\ | |  Directonal keys\
 ######  Solid Wall     | ----||    \/     /\   ||----  (unlock doors of
 ######                 |     \/  ==|     \--/  \/       the same direction)
			|\
			|   <<                    >>    Doors. Unlocked by
	 Blank space    |   <<   vvvvvv  ^^^^^^   >>    the above keys.
			|   <<                    >>
			|\
   ___                  | o__O\   O__O   ^__^   /O__o\
  /   \  'Crushable'    | \___/  /----\ /----\  \___/  The four sprites for
  \___/    boulder      |  _/_\  _/  \_ _/  \_  /_\_   your character :-)
			|\
   ___   uncrushable    |   /\   Diamonds. They can either be found lying
  /@@@\    boulder      |  <  >  around (if only!) or manufacture by pushing
  \@@@/                 |   \/   two 'crushable' rocks together.
			|

The general idea of the game is to collect all the diamonds. This must
be done in the minimum amount of moves. I've allowed a margin of 5
moves which brings the moves allowed to 484. (alter the value of 'u' in
the program to set the max moves allowed)

There are two types of boulders. Both can be pushed around, but only
the hollow (crushable) ones can be turned into diamonds (by pushing it
onto another hollow one).

Of the four types of doors (and keys) only 3 have been defined. This
was done to keep the source as low as possible (as I only used 3 in the
map).  To unlock a door simply push a key into the corresponding door.
Take care that it's facing in the correct direction.
```

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
