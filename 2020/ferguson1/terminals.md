# Terminals

Terminals are very easy to mess up and for that reason they deserve their own
file. I discuss terminal capabilities, dimensions (setting and how to restore
sanity if it causes any problems) as well as colours (limitations etc.).


<div id="toc">
-   [Capabilities support testing program](#termcaps)
-   [Setting the game dimensions](#dimensions)
    *	[The LINES and COLUMNS environmental variables](#linescolumns)
    *	[Terminal insanity](#insanity)
    *	[Restoring the terminal](#restore)
    *	[Terminal size abuse](#abuse)
-   [Terminal limitations](#termlimitations)
-   [Terminal colours](#colours)
    *	[Curses background](#background)
    *   [Monochrome terminals](#monochrome)
    *   [Colour limitations](#colourlimitations)
    *   [Disabling colour](#disablecolour)
</div>


<div id="termcaps">
# <a href="#toc">Capabilities support testing program</a>
</div>

Although it should be playable without the features I use (except that cursor
movement is required) I have provided a source file that can test your terminal
for the capabilities I use in the entry.

It also tries to determine the minimum number of columns to play without the
status line overflowing - even with the dynamic length. Try:

``` <!---sh-->
    $ make test
```

This compiles the program [termcaps.c](%%REPO_URL%%/2020/ferguson1/termcaps.c) and runs it; you should see something like:


```
    terminal supports cursor movement
    terminal supports making cursor invisible
    terminal supports bold
    terminal supports colours

    terminal rows  41 (38  playable)
    terminal cols 155 (153 playable)

    snake size:   997 (max size: 5776)
	  bugs:   199 (max size: 1155)

    at least 34 columns (currently 155) recommended for snake size 997
    at least 37 columns (currently 155) recommended for capped snake size 5776

    No problems detected.
```

Terminal rows and cols are the current values (the number of columns shown later
as well). The snake size is the default size to win (based on the variables, see
below). The `max size: 5776` is the capped size (or 'capsize'). The 199 bugs is
approximately the `snake_size / growth_size` i.e. how many bugs it
will take to win the game. The max bugs in the `bugs` line is approximately
`max_snake_size / growth_size` i.e. how many bugs it'll take to win at the
maximum (capped) snake size.

If I pass in any of the variables **GROW**, **MAXSIZE**, **SIZE** and/or
**LINES** or **COLUMNS** it bases its calculations on those variables. For
example:

``` <!---sh-->
    terminal supports cursor movement
    terminal supports making cursor invisible
    terminal supports bold
    terminal supports colours

    terminal rows  41 (38  playable)
    terminal cols 155 (153 playable)

    snake size:  5776 (max size: 5776)
	  bugs:  5771 (max size: 5771)

    at least 37 columns (currently 155) recommended for snake size 5776
    at least 37 columns (currently 155) recommended for capped snake size 5776

    No problems detected.
```

As you can see it tells you the max size (the 'capsized' snake) as well as the
requested max size (if the requested size is bigger than the capped size then it
will be set to that value instead) of the snake. The capped size is like in the
Snake game itself but the suggested minimum number of columns is based on a
number of variables.


If I were to do the above but set columns to less < 35 then there would be a
problem. But why if the utility recommends at least 37? This is because the
max size of the snake also depends on the terminal size. This utility is not
perfect: I don't consider shedding; I set growth to 5 if it's 0 (since it would
be indeterminate how many bugs are possible before 'winning' since there would
be no 'winning'); and there are probably other things too.

As for capabilities: besides cursor movement the others are just nice to have.
From my tests keeping the cursor visible doesn't ruin gameplay but it is less
distracting if nothing else to have it invisible (in fact due to the sequence of
function calls the cursor would mostly appear to be not in the game field itself -
from memory at least).

Maybe there are other capabilities I should check for that I'm unaware of but
this should give you an idea.

If there are any problems it will say how many (fatal and otherwise). The fatal
problems are if curses fails to initialise or if movement of cursor cannot be
done (both seem unlikely to happen nowadays).

Both scripts run this utility and prompt if there are any problems;
you can continue either way.


<div id="dimensions">
# <a href="#toc">Setting the game dimensions</a>
</div>

There are a number of ways to do this and only one will keep the terminal sane
all the time but that's by running it under a terminal emulator that you can
resize the window with first. But what if you want exacts?


<div id="linescolumns">
## <a href="#toc">The LINES and COLUMNS environmental variables</a>
</div>

To specify the lines/columns of curses program per instance use the `LINES` and
`COLUMNS` environmental variables.

For demonstration consider the following:

``` <!---sh-->
    $ echo $LINES $COLUMNS
    42 157
```

Note: I subtract 1 from the max y/x and the max coords in the game output
include the walls and score line but these values are for the terminal itself.

Say you want 55 columns:

``` <!---sh-->
    $ COLUMNS=55 ./prog
```

This will force curses to detect the max columns (X) of your terminal (for the
game dimensions) - to be 55; it might look like this instead:

	    X:27/54 Y:20/41 S:5/997 B:0

But problems can arise with messing with dimensions: in my tests this held only
to lines.


<div id="insanity">
## <a href="#toc">Terminal insanity</a>
</div>

Terminal sanity can be compromised and it can cause all sorts of output
problems; it might not appear right away but it will show its ugly head
eventually if you use it. For example pager output might be screwy, echo might
be turned off, output of commands might overwrite the input of those commands,
etc. For the game you might not see the final score.


<div id="restore">
### <a href="#toc">Restoring the terminal</a>
</div>

In my tests there is one thing that at least allows you to see the final score
and that is by running `clear` before running the program. That's what the
prog.alt version does. You might run it as one of:

``` <!---sh-->
    LINES=20 ./prog.alt
    LINES=20 ./snake.alt
```

Even if the final score is visible though the terminal may very well still be
messed up. There are numerous things you might try but probably the easiest is
to run the game again without modifying the dimensions (and then just quit) or
even just the `reset` command.


The Linux man page says:

```
    You might have to run the `reset` tool like:

		   <LF>reset<LF>

	       (the line-feed character is normally control-J) to get the terminal
	       to work, as carriage-return may no longer work in the abnormal state.
```

If you don't have the reset utility you can try:

``` <!---sh-->
    echo -e \\033c
```

Otherwise try `clear; stty sane` (that will turn on echo also) or if all else
fails log out and back in.

For more information on this subject generally see the [Linux keyboard and
console HOWTO][] (specifically [Linux keyboard and console HOWTO section 4][]).
Yes this works under macOS (at least it did for me).


<div id="abuse">
### <a href="#toc">Terminal size abuse</a>
</div>

So players 1, 2 and 3 are content with not meddling with the terminal sizes
outside what's actually possible with their screen. But then player 4 comes
along and thinks he/she will be clever and mess with the dimensions a bit. Let's
say they have a 13" monitor and they think it'd be funny to see how 997 lines
would work; they might try something like:

``` <!---sh-->
    LINES=997 ./prog
```

What then? Well expect trouble; curses will not know any better and the max
number of lines will be 997. If they were to do:

``` <!---sh-->
    COLUMNS=997 ./prog
```

Then they will see a different effect. Again the same reason: the player trying
to be funny.

The game will try and be funny in return and you can expect it to not function
properly. Because that's what funny means in this context.


<div id="termlimitations">
# <a href="#toc">Terminal limitations</a>
</div>

It'd be nice if curses could detect hitting more than one arrow key at the
same time so that diagonal directions would be possible but unfortunately it's
not (`cat -v` confirms this). Even if I were to define four extra keys what
would they be? And what about the head character? The [HACKING.html][]
file has information on this.

I also limit the terminal size to 10 lines/columns but most likely it would
require the cheat modes to win and in any event allowing certain low values
causes problems e.g. **LINES=6 COLUMNS=6** and **LINES=3 COLUMNS=3** caused some
nasty issues.


<div id="colours">
# <a href="#toc">Terminal colours</a>
</div>

N.B.: If all you're after is wanting to change the colours see the script
[snake-colours.sh][] instead. The rest of this file was mostly notes for the
judges; here I discuss the background, foreground as well as limitations (in
particular runtime limitations).


<div id="background">
## <a href="#toc">Curses background</a>
</div>

The documentation I have seen says that the background will always be black and
from a quick test this holds even with a terminal that has a white background.
There is a way to force the background to remain white though that's by way of
monochrome (so no colours); I discuss that and another related terminal specific
in the troubleshooting guide (there's another way but it would take me over the
iocccsize; I talk about it in the [HACKING.html][].


<div id="monochrome">
## <a href="#toc">Monochrome terminals</a>
</div>

According to my tests for monochrome terminals the screen has the white and
black background; if terminal is configured to be black background white
foreground that is the order it is too. You can try that like:

``` <!---sh-->
    TERM=linux-m ./prog
```

But I do not specifically check if the terminal has colours. Is there a curses
implementation that has a problem here? Below I explain what to comment out
should you need colours to be disabled but I personally have not run into any
problems even with monochrome terminals. Later I say what to do to remove colour
support in the source code itself.


<div id="colourlimitations">
## <a href="#toc">Colour limitations</a>
</div>

According to X/Open Curses, Issue 7 (pg. 57):

```
    With init_pair() and pair_content(), the value of pair must be in a range
    from 0 to and including COLOR_PAIRS-1. (There may be an
    implementation-specific upper limit on the valid value of pair, but any such
    limit is at least 63.) Valid values for f and b are the range from 0 to and
    including COLORS-1.
```

The manpage for `init_pair()` says this:

```
    These limits apply to color values and color pairs.  Values outside these limits are not legal, and may result in a runtime error:

    [...]

	COLOR_PAIRS corresponds to the terminal database's max_pairs capability, (see terminfo(5)).
```

Based on the two as well as the fact that monochrome terminals (I've tried under
both Linux and macOS) seem to work fine I believe I am fine here too. And to
confirm this I wrote the following code with the output below:

``` <!---c-->
    #include <curses.h>

    int main()
    {
	initscr();
	start_color();
	printw("COLORS: %d\nCOLOR_PAIRS: %d\n", COLORS, COLOR_PAIRS);
	getch();
	endwin();
    }
```

``` <!---sh-->
    TERM=linux-m ./colour_pairs
    COLORS: 0
    COLOR_PAIRS: 0
```

Without specifying the TERM I get:

```
    COLORS: 256
    COLOR_PAIRS: 32767
```

In the case that colour is supported the standard states that there will be more
possible colour pairs than I have used so that's not a problem either. Perhaps
even it would only be a runtime error if the colours are supported and the
number is out of the range? To try and figure this out I did another test:

``` <!---c-->
    int main()
    {
	initscr();
	start_color();

	init_pair(COLOR_PAIRS+1, COLOR_WHITE, COLOR_GREEN);
	bkgd(COLOR_PAIR(COLOR_PAIRS+1));
	init_pair(1, COLOR_WHITE, COLOR_BLACK);
	attron(COLOR_PAIR(1));
	printw("COLORS: %d\nCOLOR_PAIRS: %d\n", COLORS, COLOR_PAIRS);

	getch();
	endwin();
    }
```

Running it like

``` <!---sh-->
    TERM=linux-m ./colour_pairs
```

I got the output as if colours weren't used: 0 and 0. With coloured terminals
however it was not visible. If I however comment out the call to `bkgd()` I get
instead:

```
    COLORS: 256
    COLOR_PAIRS: 32767
```

Which leads me to believe that if you try using a value outside the range it
won't work for a colour-capable terminal but it doesn't matter for monochrome
terminals one way or another. And since I don't go beyond the ranges (as I cited
earlier) there shouldn't be any problem here.


<div id="disablecolour">
## <a href="#toc">Disabling colour</a>
</div>

Nevertheless if it is a problem and you don't want to use a monochrome terminal
(or can't):

First comment out the code that has `start_color();` and then add `return;` to the
top of the `C()` function (the rest of the code won't be reached). If necessary
you can also comment out the `init_pair()` calls.

Perhaps you only need to add the `return;` to `C()`. My guess is that's the case
but I do not know for certain.

[HACKING.html]: HACKING.html
[Linux keyboard and console HOWTO]: https://www.tldp.org/HOWTO/Keyboard-and-Console-HOWTO.html
[Linux keyboard and console HOWTO section 4]: https://www.tldp.org/HOWTO/Keyboard-and-Console-HOWTO-4.html
[snake-colours.sh]: %%REPO_URL%%/2020/ferguson1/snake-colours.sh


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
