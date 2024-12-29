## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./meyer [SEED]
```


## Try:

``` <!---sh-->
    ./meyer [SEED]
```

For your first input try:

```
    a 0 1
```

where `a` is the row (`a`-`i`), `0` is the column (`0`-`8`) and `1` is the
number (`1`-`9`).

**NOTE**: if you do not input three different 'words' it will block. You can input
more text to fulfil the program's requirements.

**NOTE**: if your move is invalid it will prompt you again but not show the board.


## Judges' remarks:

This entry turns a newspaper solitaire puzzle into a competition
with the computer to be the last one moving.  The object of this
[source code](%%REPO_URL%%/2006/meyer/meyer.c) is to determine the object of this [source
code](%%REPO_URL%%/2006/meyer/meyer.c)!  :-)


## Author's remarks:

I wanted to submit a fully object-oriented entry to show that
object-orientated code:

1. is ridiculously bloated.
2. is unreadable.
3. isn't '`WYWIWID`' ('what you write is what it does') anymore.

But I just totally failed. No, I didn't fail in showing any of
the points above. Before I even had the chance to prove any of
these claims, (1) already brought me to my knees. The code got
so bloated up, that I missed the size limit by a few hundred
bytes. Therefore, I broke the only rule in this contest, I think
you shouldn't break in any case: Rule Nr 2, The size of ...

The degree of claim (2) actually depends on the compiler. As I
_manually_ translated it from a generic object-oriented programming
language to C, it didn't just end up unreadable, but awfully
messed up, i.e. obfuscated.

As it is already (pre)translated to C, you could also call it an
object-disoriented program.

Comparing this program to a potential object-oriented implementation,
it is obvious, that object-oriented code isn't '`WYWIWID`' ('what
you write is what it does'). It may be tempting to think that

```
    Object o;
```

might do something similar as

``` <!---c-->
    struct not_an_object o;
```

But this program reveals that it doesn't. Even worse, this program only
reveals the tip of the iceberg, what kind of black magic is involved in
a simple declaration of an object.

A few things you can explore about object-orientation in this program
include:

- constructors (invoked by the new operator).
- new operators (every class gets its own new operator at compile time).
- virtual method tables (all the virtual method tables have been combined to a
single [vtable](https://en.wikipedia.org/wiki/Virtual_method_table) table).
- runtime method binding.
- [inheritance](https://en.wikipedia.org/wiki/Inheritance_&lpar;object-oriented_programming&rpar;)
and [polymorphism](https://en.wikipedia.org/wiki/Polymorphism_&lpar;computer_science&rpar;).

It is left as an exercise to the reader to find a corresponding
implementation in a popular object-oriented programming language.


### Starting the game

``` <!---sh-->
    ./meyer [SEED]
```

### Gameplay

It is a [sudoku](https://en.wikipedia.org/wiki/Sudoku) based game. The goal of
the game is to be able to do the last valid 'move'.

On your turn you have to set a free cell to a value between 1 to 9 without
breaking the following rule. Any number must be unique in its:

1. row
2. column
3. 3x3 block.

Expected input for your move:

```
    row column number
```

where

```
    row:    [a-i]
    column: [0-8]
    number: [1-9].
```

The game can be aborted with `q`.

The one who can do the last move wins the game.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
