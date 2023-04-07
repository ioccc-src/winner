# Most explosive

Yusuke Endoh
Twitter: @mametter

## To build:

```sh
make
```

## To run:

```sh
./prog
```

## Try:

```sh

# Try resizing the terminal window before the first click.

# Try resizing the terminal window after the first click.

./prog ioccc.txt

./prog unwinnable.txt
```

### Alternate code:

An alternate version of this entry, [prog.alt.c](prog.alt.c), is provided.  This
alternate code lacks the additional rule to flag all unprobed cells.  See the
Author's comments for more details.

To compile this alternate version:

```sh
make alt
```

Use `prog.alt` as you would `prog` above.

## Judges' comments:

When playing Minesweeper, a misclick might ruin a game, so why not leave the
routine to the computer?  This program automatically uncovers mines according to
several rules, and leaves guessing (and applying the most straightforward of the
rules -- just for fun, perhaps?) to the user.

Try creating your own input files according to the author's remarks. Did you
encounter any problems?

The submission was in violation of the "2053" size rule by one character, likely
a late typo. It was easy to fix.

## Author's comments:

### Semi-automatic Minesweeper:

Minesweeper is a game to sweep mines, as you know.  The task consists of two parts:

A) choose a random cell based on your sixth sense
B) identify a non-mine cell based on logical inference

However, (B) is error-prone, and a waste of time.  You must use a computer to do
such a boring task!

This program is a semi-automatic minesweeper which does Part (B) automatically.
All you have to do is (A).  You can test if you are lucky or not.

#### How to use:

It uses ncurses:

```sh
gcc -o prog prog.c -lncurses
./prog
```

You will see a terminal-wide field of a minesweeper.  Probe a cell by mouse
click.

If a cell turns out to have a mine (or not), the program determines whether its
neighbors have a mine or not, and automatically probes (or flags) the cell.

##### Keyboard commands:

* `R`: new game (You can also click the smiley face at the top line.)
* `Q`: quit

#### Internals:

The program uses four types of local inference:

##### Rule 1:

If the number of a cell is equal to the count of the flagged neighbors, all the
unprobed neighbors are probed.

Example:

```
? ? ?      . . .
? 3 ?  =>  . 3 .
! ! !      ! ! !
```

Note that `?` is an unprobed cell (it is unknown whether the cell has a mine or
not); `!` is a flagged cell (it is already known that the cell has a mine); and
`.` is a probed cell (it is already known that the cell has no mine).

##### Rule 2:

If the number of a cell is equal to the count of the unprobed or flagged
neighbors, all the unprobed neighbors are flagged.

Example:

```
. ? ?      . ! !
. 4 ?  =>  . 4 !
. 2 !      . 2 !
```

##### Rule 3:

Consider two number cells A and B.  If A is equal to the difference of B and the
count of B's unprobed and flagged neighbors that are not A's neighbors, all A's
unprobed neighbors that are not B's neighbors are probed.

Example:

```
? ? ?        . . .
? 1 ? ?  =>  . 1 ? ?
? ? 4 .      . ? 4 .
  ? . !        ? . !
```

A and B are probed cells whose numbers are, respectively, 1 and 4.  The count of B's unprobed and flagged neighbors that are not A's neighbors is three (one `!` and two `?`s).  Since A (1) == B (4) - the count (3), the left and top unprobed cells are probed.

#### Rule 4

Consider two number cells A and B.  If B is equal to the difference of A and the count of A's unprobed and flagged neighbors that are not B's neighbors, all A's unprobed neighbors that are not B's neighbors are flagged.

```
? ? ? ?      ! ? ? ?
? 3 1 2  =>  ! 3 1 2
2 2 . .      2 2 . .
```

A and B are probed cells whose numbers are, respectively, 3 and 1.  The count of A's unprobed and flagged neighbors that are not B's neighbors is two (left `?`s).  Since B (1) == A (3) - the count (2), the left unprobed cells are flagged.

#### Note

Interestingly, these complex rules can be integrated to one simple rule.  Analyze the code.

#### One more thing

You can also play with a prepared map.

```sh
 ./prog ioccc.txt
 ```

The format of the text is:

```
width height number-of-mines priorities-of-each-cell...
```

There are mines in a cell whose "priorities-of-each-cell" is less than "number-of-mines".
(But the mine in the first-clicked cell is removed.)

#### Bug fixes and Credits

The judges pointed out a bug of the original version that I submitted (prog.alt.c).  Because this program does not provide a feature to flag unprobed cells manually, we can do nothing if the number of unprobed cells are equal to the number of mines remaining; unwinnable.txt is an example for such a case.
Thus, I implemented an additional rule to flag all unprobed cells in such a case into the final version (prog.c).

Ilya Kurdyukov also pointed out a warning "ignoring return value of 'fscanf'" only when "-O3" is used.  So I changed the code a little to pretend to use the return value of fscanf.

Don Yang (omoikane) contributed another example map "megumin.txt" which is the Explosion Arch-Wizard.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
