# About this document

In this document I provide information to the herpetologist hackers to help them
modify certain things and add features for their studying of snakes. Or if
you prefer you can be the snake studying the herpetologist. Whichever character
you prefer to play doesn't really matter.

# Warning / caveat about this document

WARNING: There are some things cited in this document that are no longer
correct, might be misleading or otherwise not clear. This is both intentional
and unintentional. This is especially true for claims that something means
something specific. Put another way just because the table says something
doesn't mean it's the whole truth: no misleading comments but misleading
document that talks about some parts of the code!

Please do not assume that just because something is in this file means that it's
complete or will work without any changes (see above). As I have changed the
game over development stages some features have been dramatically changed and
some of these ideas could be incompatible now or otherwise impractical. Also you
might find in fact that some of these leave more questions than answers (e.g.
some require making decisions for specific problems one might encounter)!

With that said here's the C sibilancy (the herpetologist programmer's and
snake's syllabary) for all snake and herpetologist programmers alike.

# Modifying and adding additional features to the code

* Modifications

    - Modifying the colours
	- Background colour
    - Modifying the characters for the wall, bug and snake
    - Modifying input keys
    - Modifying the status/score line
    - Make it so the snake starts at a random location

* Additions

    - Health (and/or Lives)
    - Saving the game
    - Different types of walls
	- Blockades
    - Diagonal movement
    - Special abilities
    - Obstacles
    - More than one bug
    - Power-ups
    - Snakeskin shedding (becoming an obstacle)
    - Snake moves faster over time
    - Max times the bug evades before game over

# Modifications

Here I include information on modifying the game in various ways depending on
the preference of the herpetologist (or if you prefer you can be the snake
studying the herpetologist).


## Modifying the colours

As I already said I provided a script that prompts you for colours and then
compiles the game with those colours (default if invalid input).

The parts of the game that are coloured are the WALL(s), the snake HEAD and
snake BODY. In the published alternate version (prog.alt.c) the bug is also
colourable. This means that there are a total of four configurable colour pairs.
It only supports the eight standard colours. Each colour is a pair: foreground
and background.

To change the colours use the snake-colours.sh or play.sh scripts. Hit enter for
defaults if you don't want to change the colour.

## Background colour of the game field

I prefer black backgrounds but this is the basic idea behind changing it. You
initialise a pair (make it 5 so as to not interfere with the script
customisability) and then you use the bkgd() function with the colour pair.
Something like this:

``` <!---c-->
    init_pair(5, COLOR_BLACK, COLOR_WHITE);
    bkgd(COLOR_PAIR(5));
```

I played with this after winning and I came across some problems with colours
but that changes the background of the program anyway.

The standard colour identifiers are:

``` <!---c-->
    COLOR_BLACK
    COLOR_RED
    COLOR_GREEN
    COLOR_YELLOW
    COLOR_BLUE
    COLOR_MAGENTA
    COLOR_CYAN
    COLOR_WHITE
```


See [Linux Journal for more information
article](https://www.linuxjournal.com/content/programming-color-ncurses)
for more details.


## Modifying the characters for the wall, bug and snake

For the wall, bug and snake body characters you can replace the following in the
source code (**include the single quotes!**) respectively:

```
    '#'

    '*'

    'o'
```

## Modifying input keys

Let's say you don't want to use arrow keys or you don't have arrow keys. Instead
you might want the keys `l`, `r`, `u` and `d` for the directions. Find the case
statements:

``` <!---c-->
    case KEY_LEFT:
    case KEY_RIGHT:
    case KEY_UP:
    case KEY_DOWN:
```

Replace `KEY_LEFT` with:

``` <!---c-->
    'l'
```

and do the same thing for the other directions too. If you want more than one
key e.g. the arrow keys and the letters just add another case statement e.g. for
left it might be:

``` <!---c-->
    case KEY_LEFT: case 'l':
```

Yes the single quotes matter. You can do similar for the other input keys.
Please note that modifier keys like ctrl aren't detectable or at least I'm
unaware of how to do so.


## Modifying the status/score line (table of variables/stats below)

### SPOILER WARNING

Below I give a table of some variables/expressions along with the data types and
their respective format specifiers of the data. Originally it was a lot more
detailed but as I started obfuscating things variables started to disappear and
I decided to remove those variables from the table outright. Again also remember
that it's outdated.

Please note that this set of information is the same that will be seen at the
end of the game; I leave that as an exercise to the reader to implement two
different sets. Please also be aware that if you don't want any information you
must set it to the below at the very least; defining it without a value is not
enough (it amounts to the parameters to a printf call):

``` <!---c-->
    #define J " " );
```

If you don't care about brief displays of 'o' at 0,0 you can just have:

``` <!---c-->
    #define J "");
```

That's the bare minimum. Notice also that it's been a long while since I've
tested this part but I think this is right.

Anyway as I said the score line has basic statistics that's relatively easy to
change if you want more or less or different information e.g. the location of
the bug.

Initially there was no display of where the (head of the) snake was at nor the
maximum size (that is the size calculated by ncurses) - though the astute hacker
would notice that the maximum dimensions size is not what the status line says:
this has to do with the walls and the status line - coordinates.

At that point the only time the top stats were updated is when the snake got a
bug. This however was something I didn't quite like: I like having the
coordinates of where the snake is plus the other things that are there (a number
of which were added over time). Obviously this would take many bug sized bytes
(bites) even once let alone twice! Thus I made it into a define:

``` <!---c-->
    #define J Z(X:%d/%d Y:%d/%d S:%zu/%zu B:%zu\n), Y, y[-2], X,*y,A,g, c);
```

With the table below you can show a variety of other variables/statistics.

There's another reason for changing this line though: depending on the terminal
width the line could cover the top wall; this can even happen only part of the
game because the line length is not constant: most of the variables change
throughout the game play and as these are displayed the length of the line
changes. Use `make test` to get an estimate (it's not perfect).

This is not the fault of my entry but rather how text wraps. But this is another
reason it's easy to change: if the terminal size is too short then you can
update it; but if you want additional or different information you can also
update it. Remember that if you modify the score data the termcaps algorithm
might not remain as correct!

But the game needs to have the walls drawn and the score line is also important;
well it's important in that the row number of the top wall is in fact used and
so if this line wasn't there it would require changes to make it work right.

For an example this would only include the size of the snake and the number of
bugs eaten (I think I have this correct; I've made many changes to the point of
not wanting to mess with anything that's unnecessary):

``` <!---c-->
    #define J Z(SIZE: %zu BUGS: %zu\n), A, c);
```

More generally the following expressions and data types (with format specifiers)
come to mind as information that might be of interest.

```
    DESCRIPTION		    EXPRESSION		TYPE	FORMAT SPECIFIER

    Snake size		    A			size_t		%zu

    Y coordinate	    Y			int		%d
    of snake head

    X coordinate	    X			int		%d
    of snake head

    Max snake size	    g			size_t		%zu

    Bugs eaten		    c			size_t		%zu

    Bug line (Y)	    *U			int		%d

    Bug column (X)	    *V			int		%d

    Snake size		    A			size_t		%zu

    Growth size (per	    N			size_t		%zu
    bug)
```


## Make it so the snake starts at a random location

Quite simply change:

``` <!---c-->
    X = H / 2; Y = *x / 2;
```

To be something like:

``` <!---c-->
    X = R(1,H-1);
    Y = R(2,*x-1);
```

Or whatever you might want it to be... (question to answer: will this work at
all? You decide!)


# Additions (+)

Here are some things you could add (including a bit of code).


## Health (and/or Lives)

This was something I thought of a number of times but I opted for other features
instead. Here are some ideas on how one might choose to implement something like
this. Or maybe it's more like what sorts of things do you have to consider and
answer?

0. If the snake runs back into itself - thus dying - the snake would actually be
slithering inside itself (a rather creepy thought - though they sort of do when
they shed their skin). How then would the lives be of any value? If that would
constitute as running into itself wouldn't it very quickly lose all lives?

    I can think of a number of ways to answer this question: by defining
    specific rules (as in what would be allowed and what wouldn't be) and also
    by when to decrement the lives.

1. If the snake hits a wall and it's not allowed to where would the snake be
placed? This is similar to (1) but maybe not as many things to consider.

2. Should the snake lose its size? WHAT does having another life even MEAN?

3. Do you want (you do not necessarily need) a new variable that says how many
lives you want? Either way probably be good that it can be specified by the
player.

The simplest rules I can think of off the top of my head is that the snake loses
its size but it keeps the bugs count. So if the lives are three and the snake
has three lives, has eaten 15 bugs and then runs into itself it will start out
again at the original size (remember there's a fair bit more than just changing
the size of the snake to do in order for it to be of use!) but it then the next
bug it eats will be the 16th bug.

Of course you could also say that the first time the snake eats a bug (on the
next life) it grows to the size it once was. This would actually be one way to
deal with some issues that I sort of alluded to above. Of course it also has
some other complications.

You could do similar for health only maybe the size of the snake decreases or
you use the variable you would have used for lives to be health instead.

Vital issue to resolve: where is the snake? And if the snake size is decreased
will you be careful enough that you don't run into the snake where it actually
isn't?


## Saving the game

A few things would have to be done to do this. Maybe more than a few: some
decisions and some code.

First obviously is you would need a hook to save the game: that is what if you
don't want to save? You could save every time the snake moves so that you keep
the highest size (though this could theoretically slow the game down more as the
snake gets bigger and bigger). Or you could say that hitting the key 's' saves
the game by calling a save function.

Second is you need a save function. You would need to save the dimensions of
the game, all the coordinates the snake is currently at (from head to tail),
where the bug is, decide whether or not to save the direction (if it's 0 the
snake isn't moving which would mean the player could decide when to resume) and
the number of bugs eaten so far. Alternatively you could have the bug simply be
placed somewhere where the snake isn't after replacing (can you replace
something with itself?) the snake.

Question: do you have to save the WALLS and other environmental variables?
You wouldn't have to but you could: if you didn't it would mean that the player
could change the growth size on another run for example, or they could disable
or enable a feature.

Of course you would also need a restore routine. This would mean you would want
to parse the command line so as to know which file should be read in (easiest
way would be if the first arg is some value then it tries to load in whatever
you decided to name the save file). How would this work?

You would have to make sure that the dimensions of the terminal are valid for
what was saved and you would have to compensate that maybe the dimensions have
to be slightly adjusted for the screen (I have given more than enough
information on this elsewhere as to why this is). Obviously you have to
initialise ncurses, allocate the arrays, draw the walls, snake, bug etc. You
wouldn't initialise ncurses or its features more than once (i.e. keep track of
whether or not you have initialised these things due to a file being read or
starting anew). Clearly you would have to come up with a file format and have
error detection too. I can think of an easier way to make sure you don't
initialise the ncurses twice however. It would do the same things only with a
bit less code and maybe simpler logic.

It might seem like a difficult task but it's actually not that difficult. It
didn't take much time for me to do something like this: as far as saving and
loading the values and even setting up ncurses: I just didn't go beyond that.

Tip: **DON'T TRY** `scr_dump()`/`scr_restore()`/`scr_init()`/`scr_set()`. After a quick
test in the way I have things set up it seems to cause some problems (also
`scr_dump()` quits the program).

You would have to instead identify that restoring is requested, then read in the
file (including the coordinates) and then populate the snake arrays, drawing it
on screen.


## Different types of walls

The game has two modes with walls: if you run into it the game is over (you
die) OR you go through it and come out on the opposite side. There certainly are
other possibilities though. Here I give some ideas that could be implemented
(and one I have some code for).

### Different types of walls: Blockades

I did this once before as an experiment so it can work fine: let's say instead
of the snake either dying or going through and out on the other side what if
it's just that the snake is momentarily dazed and unable to move again until it
comes round sort of like what happens with some people who pay more attention to
their ruddy phone instead of where they're walking (even when crossing a busy
street!).

If you look at the walls code you will see a ternary operator for both `X` and `Y`
coordinates. This of course is very different now but the idea remains the same:

``` <!---c-->
    if (p && !(*O>=O[1]||H>=M(1)))
    {
	if (X<1||X>=H)
	    X = X<1?H-1:1;
	if (Y<2||Y>=*O)
	    Y = Y<2?*O-1:2;
    }
```


You can ignore the first if if you like; I'm not going to explain that part. The
inner if statements however are testing if the new snake coordinates are beyond
the walls (off screen). Depending on where the snake is it will set the
coordinates to the correct new location.

If however you wanted the walls to act as a barrier you could do something like
this instead (omitting the inner if statements here):

``` <!---c-->
    X=X<1?1:*H-1;

    Y=Y<2?2:*O-1;
```

Again though that's just the idea; the code is dramatically different. The above
incidentally is not even complete.

You could also have it so depending on the WALLS value have it go through
walls, end game or act as a blockade. If you really wanted you could have some
walls you can go through and some you can't (maybe different colours would be
needed?).

Oh and yes you might find it can look a bit funny this way. For instance if
you're slithering left along top wall and you hit up the snake will still be
horizontal (after the thing I warned about is resolved of course! - And that's a
very important one unless you want negative coordinates - and you don't!) since
it'll have stopped. If you were to then hit the direction you had been going you
will see that it continues going that way in a straight horizontal line. In
other words the snake will just appear to be not moving as if the game had been
paused.


## Diagonal movement

I said this is impractical so how could it be done? Well you have to decide
which keys would take you up and right, up and left, down and right or down and
left. The trouble is ncurses can't detect both right and up at the same time.
Besides that though it would only be a matter of updating both `Y` and `X`
coordinates rather than just one or the other. That's easy enough to do. The
only impractical part of this is deciding the keys and unfortunately rule 2b
(and probably 2b) would have been broken and so have no chance of winning (now
that I won it's too much effort and I've forgotten most of the stuff too to say
nothing of getting the format right).

Anyway it's just a matter of updating both `X` and `Y`. But what about going
through walls mode? Does it matter? I'll let you figure it out!

Looking back at the missing features, this is the feature I wanted more than any
other.

## Special abilities

Could the snake jump over itself if it wanted to? How would this be implemented?
The head would simply be moved one beyond but then you would have to keep track
of where the part that was jumped over is and what part of the snake has to do
the same thing. I can think of a much easier way though. This very paragraph
actually includes it! Then it would only be a matter of deciding what key does
what.


## Obstacles

Similar to walls only that it's inside the field. You would have to consider
the behaviour of running into the obstacles: should the snake die? Should it
lose health/lives (if implemented)? Can it go through them? And also: the bug
placement would have to be updated too. You would also need to figure out what
character to use for the obstacles: I personally would just reuse the wall
character. Also to make it simpler if the walls are passable then so too would
be the obstacles; else you would die (or if you had health/lives then those
would apply).

## More than one bug

The main thing to consider would be the test if the snake has eaten a bug would
have to check an array (and: how big? Where does the size come from?) as well as
the placement routine (though I guess you could have a value for each array
meaning that if you run into a bug spot that has more than one bug you would eat
that many bugs).


## Power-ups

You would need to decide what power-ups exist, what they do, how many can there
be (and how many can the snake have at one time), what makes them show up plus
you would have to add code to handle the power-ups.


## Snakeskin shedding (becoming an obstacle)

I.e. at some point the snake would split back to some (arbitrary) size but then
the snakeskin left would act as the snake in the sense that if the snake runs
into it it's the same as running into the snake. More realistically the
snakeskin would be the same size the snake was and the snake would grow as it
slithered out. But that would fill the screen very quickly of course. Maybe the
snakeskin has some other purpose?


## Snake moves faster over time

In the game [Surround](https://en.wikipedia.org/wiki/Surround_&#x28;video_game&#x29;) you
have no control over the speed. I believe there are five different speed levels
but the player has no control over it except the drawing mode. It would be
possible to make it so the snake moves faster over time. How often and by what
amount would probably vary but importantly it would need to not go so fast
there's no controlling - or go below 0 which puts it in blocking mode. Probably
it would be that it gets faster up to a certain per cent of the original speed
so that it doesn't get too fast. But even that would have to be customisable.

## Max times the bug evades before game over

Basically so that the player is on a time schedule of sorts. The same could be
done for maximum number of movements before game over. These would both be
rather easy to implement but personally I would only consider the max number of
evasions (I just don't have many more bytes left!) - unless maybe that there is
no default limit on max moves.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
