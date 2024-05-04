Playing the game is very simple but because there are many different modes I
have included much more than just the input keys and a few printouts of the
game. For normal play you probably don't even need this file at all unless it be
for the input keys.

<div id="toc">
1.  [Testing terminal environment/capabilities](#support)

2.  [Input keys](#input)

3.  [Gameplay](#gameplay)

    *   [The initial screen](#initial)
    *   [Playing the game](#playing)
    *   [Walls](#walls)
    *   [Cannibalism](#cannibalism)
    *   [Stretching &#x28;shedding&#x29;](#shedding)
    *   [Winning](#winning)
    *   [Quitting](#quitting)


4.  [Gameplay modes](#modes)

    *   [**Photosensitive epilepsy/Stimulation overload trigger warnings**](#warning)
    *   [Drawing / Practice mode](#drawing)
    *   [Computer playing / Automatic mode &#x28;Photosensitive epilepsy/Stimulation overload trigger&#x29;](#auto)
	    *	[Variations](#auto-variations)
    *   [Grow-Shrink &#x28;Positive/Negative Winning&#x29; mode](#grow-shrink)
    *   [Hypnotic / Sleepy mode &#x28;Photosensitive epilepsy/Stimulation overload trigger&#x29;](#hypnotic)
    *   [Stimulation / Calming mode](#stim)
    *   [Other ideas](#other-ideas)

5.  [Scripts](#scripts)

    *	[Colours selection](#colours)
    *	[Automate the above gameplay modes](#preset)


6.  [Other game variables](#variables)

    * [WAIT		    -	Snake speed](#wait)
    * [EVADE		    -	Bug evasion frequency](#evade)
    * [SIZE / MAXSIZE	    -	Initial snake / max sizes](#sizes)
    * [GROW / SHEDS	    -	Growth / Shedding sizes](#growth)


7.  [Conclusion &#x28;and inspirational words for everyone&#x29;](#conclusions)
</div>


<div id="support">
# 1. <a href="#toc">Testing terminal environment/capabilities</a>
</div>

Most people probably won't have any issue at all but for those who have any
problems with the terminal see the [terminals.html][]
file for more information on the terminal capabilities testing utility I
include.

For troubleshooting other problems see [troubleshooting.html][]
and [bugs.html][].


<div id="input">
# 2. <a href="#toc">Input keys</a>
</div>

-   Left, right, up and down **arrow keys**: move that direction.
-   `q` (and `Q`): quit the game.
-   Space: pause/resume the game (direction keys will also resume).
    Note that no other keys will resume the game; however if you press a key
    that `getch()` picks up on and the game is not paused then it will be as if
    you pressed the current direction key (assuming you already moved the snake).


<div id="gameplay">
# 3. <a href="#toc">Gameplay</a>
</div>

Here I will show the initial screen as well as what a few things look like. If
you don't feel you need this but you want to configure colours jump to [colour
selection](#colours). You can also jump to [gameplay modes](#modes) or [game
variables](#variables).

The bug colour by default is white; the snake head colour is red and the snake
body colour is green. The walls are cyan.


<div id="initial">
## <a href="#toc">Gameplay: The initial screen</a>
</div>

When you load the game you will see a screen that looks something like the
below. Note that the top line is the score/status line: the top wall is at line
1 and the left wall is column 0. Below I use the coordinates in the X/Y order
(ncurses is the opposite: Y/X). I will parenthesise the numbers below to refer
to the number in the diagram:

```
    X:24/49 Y:8/16 S:5/658 B:0
    ##################################################
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                       +                        #
    #                                                #
    #                                      *         #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    ##################################################
```

-   The snake (`+`) is at (24),(8). The bug char is `*` and the wall char is
    `#`. When the snake moves the head will be an arrow facing the direction it
    is moving; the body is 'o'.

-   The top wall is always line (1), the left wall is always column (0), the
    bottom wall is line (16) and the right wall is column (49). If walls are
    impassable and you run into any of these the game is over (you can slither
    at the edge of the wall); else you'll come out the opposite side.

-   The snake size is (5): but until you start to move it's technically 1 (even
    if you set **SIZE=0** this applies). This is so that you can decide which
    direction from the centre of the screen. By default the head colour is red;
    the body is green. The snake will grow by one until it reaches the right
    size.

-   The maximum snake size is (997): this is the default; it can be changed but
    it will always have an upper limit depending on the terminal size.

-   The number of bugs eaten so far is 0.


<div id="playing">
## <a href="#toc">Gameplay: Playing the game</a>
</div>


```
    X:39/49 Y:8/16 S:5/658 B:0
    ##################################################
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                  oooo>         #
    #                                                #
    #                                      *         #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    ##################################################
```

I let the snake grow to its full size (with the head at (39),(8)) and I'm two
places above the bug so let's go down:

```
    X:39/49 Y:9/16 S:5/658 B:0
    ##################################################
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                   oooo         #
    #                                      v         #
    #                                      *         #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    ##################################################
```


Now you see that the snake is going down and in one move the bug will be eaten.
Let's do that:

```
    X:36/49 Y:10/16 S:10/658 B:1
    ##################################################
    #                                                #
    #                                                #
    #                                                #
    #                 *                              #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                   ^  o         #
    #                                   oooo         #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    ##################################################
```

Observe that the bug was eaten and a new bug spawned elsewhere. I went left
three and then up one and could slither on to the bug.


<div id="walls">
# <a href="#toc">Gameplay: Walls</a>
</div>

By default walls are passable (**WALLS=1**). Let's get to full size and go
through the top wall:


```
    X:36/49 Y:15/16 S:10/658 B:1
    ##################################################
    #                                   o            #
    #                                   o            #
    #                                   o            #
    #                 *                 o            #
    #                                   o            #
    #                                   o            #
    #                                   o            #
    #                                   o            #
    #                                   o            #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                   ^            #
    ##################################################
```

There you can see I have grown to the full size and went through the top wall;
the head is now at the opposite wall. Continuing:

```
    X:36/49 Y:11/16 S:10/658 B:1
    ##################################################
    #                                   o            #
    #                                   o            #
    #                                   o            #
    #                 *                 o            #
    #                                   o            #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                   ^            #
    #                                   o            #
    #                                   o            #
    #                                   o            #
    #                                   o            #
    ##################################################
```

I might then have turned to the left and then shortly go up to get the bug. This
goes on until you lose, quit or win the game.


When you specify **WALLS=0** the walls become an obstacle that end the game. It
might look like (I set the starting size to 150 and had only just started):

```
    X:20/49 Y:2/16 S:150/658 B:0
    ##################################################
    #                   ^                            #
    #                   o                            #
    #                   o          *                 #
    #                   o                            #
    #                   o                            #
    #                   o                            #
    #                   ooooo                        #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    ##################################################
```

If I continue going up I will see:

```
    OUCH!
    X:20/49 Y:1/16 S:150/658 B:0
```


<div id="cannibalism">
# <a href="#toc">Gameplay: Cannibalism</a>
</div>

By default cannibalism is disabled (**CANNIBAL=0**)  so if you run into yourself it might look
something like:

```
    X:45/49 Y:10/16 S:10/658 B:1
    ##################################################
    #                                                #
    #                                                #
    #                                                #
    #                 *                              #
    #                                                #
    #                                                #
    #                                                #
    #                                          ooooo #
    #                                            ^ o #
    #                                            ooo #
    #                                                #
    #                                                #
    #                                                #
    #                                                #
    ##################################################
```

If I were to do any movement but turn to the left I would run into myself. I'll
go to the right two spaces:

```
    OW!
    X:47/49 Y:10/16 S:10/658 B:1
```

But **CANNIBAL=1** can look very funny both in movement and still especially
when you go through yourself several times when the snake is rather long. For
example going through walls and the snake a few times:

```
    X:4/49 Y:12/16 S:165/658 B:3
    ##################################################
    #oo                        o    ooooo  o o      o#
    #                          oooo o      ooo      o#
    #                             ooooooooooooooooooo#
    #                               o                #
    #                 oooooooooo    o                #
    #                 o        o    o                #
    #                 o  oooo  o    o                #
    #                 o  o     o    o                #
    #                 ooooooooooooooo                #
    #                    o     o*                    #
    # oo>                o     o                     #
    # o           oooooooo     o                     #
    #oooooooooooooo            o        oooo oooooooo#
    # o                        o        o  o o       #
    ##################################################
```

I'll go back through myself now:

```
    X:6/49 Y:14/16 S:165/658 B:3
    ##################################################
    #oo                        o    ooooo  o o      o#
    #                          oooo o      ooo      o#
    #                             ooooooooooooooooooo#
    #                               o                #
    #                 oooooooooo    o                #
    #                 o        o    o                #
    #                 o  oooo  o    o                #
    #                 o  o     o    o                #
    #                 ooooooooooooooo                #
    #                    o     o*                    #
    # ooo                o     o                     #
    # oo          oooooooo     o                     #
    #ooooo>oooooooo            o        oooo oooooooo#
    # o                        o        o  o o       #
    ##################################################
```

If you note that the head is at (6),(14) I will go one more to the right and you
will see that the arrow has moved over:

```
    X:7/49 Y:14/16 S:165/658 B:3
    ##################################################
    #oo                        o    ooooo  o o      o#
    #                          oooo o      ooo      o#
    #                             ooooooooooooooooooo#
    #                               o                #
    #                 oooooooooo    o                #
    #                 o        o    o                #
    #                 o  oooo  o    o                #
    #                 o  o     o    o                #
    #                 ooooooooooooooo                #
    #                    o     o*                    #
    # ooo                o     o                     #
    # oo          oooooooo     o                     #
    #oooooo>ooooooo            o        oooo oooooooo#
    # o                        o        o  o o       #
    ##################################################
```

Try this: get a reasonable length and then go back on yourself (if you're going
left go right etc.) and then after some length (but before you get beyond the
snake) turn (so that you go perpendicular) and then watch as the snake starts
unwinding at one place and then suddenly unwinds another direction.

An example of extreme cannibalism is in the [cannibalism.log.html][]
file. It explains information about the file
including how to find the bug, head and tail of the snake, at least where it was
documented. The first run has several dumps.  The final example has the snake
inside itself.


<div id="shedding">
# <a href="#toc">Gameplay: Shedding (stretching)</a>
</div>

This feature will make you grow by the value of **SHEDS** for every **SHED**
movements (the counter isn't incremented when you eat a bug). Basically growing
without eating a bug (stretching would be better name here).


<div id="winning">
# <a href="#toc">Gameplay: Winning</a>
</div>

If you ever get to the **MAXSIZE** the game is won. You can force a win by
setting the max size to a smaller value than the size you specify (or the
default) or setting the size to higher than the default (or < 0 which will end
up being > the max size though I suppose there might be some value that makes it
less than again - I'm not going to try and figure that out however). Anyway:

``` <!---sh-->
    SIZE=-1 ./prog
    YOU WIN!
    X:24/49 Y:8/16 S:658/658 B:0
```

Observe that the size isn't the default 997: because the screen size is too
small for that value (see [terminals.md][]).

The reason I chose 997 is that it leaves a bit of a challenge for some (maybe
most) people but it's still winnable. Previously even I couldn't have won unless
maybe a much bigger screen, if both cheat modes were disabled. I probably could
win without any cheat mode enabled on my 24" monitor but I probably would need
at least one cheat mode on my 16" laptop (I don't need both enabled). I don't
think I need either for 997.

The beauty though is the game can be winnable by anyone since you can define the
max size to win. Games are meant to be fun: who enjoys games that can never be
won? Very few probably do and those who do enjoy them it probably are games that
are relaxing and stimulating (which admittedly this game can be - but still I
want it to be winnable too).

Another reason I chose 997: it's prime and the judges love prime numbers.
Actually, this is the main reason for the number: I had changed it down to 1000
but then it occurred to me that there are prime numbers close to 1000 so why not
choose one instead (that was less than 1000)? And so I did. Another fun fact: at
the default starting size and growth size of 5 the number of bugs needed before
the game is won is 199 - also a prime!


<div id="quitting">
# <a href="#toc">Gameplay: Quitting</a>
</div>

If you wish to quit you can hit 'q' (case-insensitive). For example:

```
    X:24/49 Y:8/16 S:5/658 B:0
```


<div id="modes">
# 4. <a href="#toc">Gameplay modes</a>
</div>

Here I list a number of different modes of play. In the [bugs.html][]
file I even show how there's a built-in test unit for some
modes! There are certainly other modes that could be imagined: the modes below
happened over time and some were simply an accidental discovery or something I
thought of by a chance; others were thought out from the beginning but were
improved over time.

The [play.sh][] script sets up some of these automatically; I describe it after
the modes below.


<div id="warning">
## <a href="#toc">Photosensitive epilepsy/Stimulation overload trigger warnings</a>
</div>

If you have **photosensitive epilepsy please be careful** especially with low values
for both **WAIT** and **EVADE**. It appears that the [number of hertz (flashes)
per second triggering seizures][] is wide but depending on the variables it
easily can be in the range.

There are different patterns and lights flashing at different speeds so please
exercise caution. This could trigger seizures and **it might also be too much
stimulation for some people.**

**Please be careful of these if these types of things have ever affected you or if
you have any form of epilepsy. Thank you.**


<div id="drawing">
## <a href="#toc">Gameplay mode: Drawing / Practice mode</a>
</div>

If you want to draw the snake wherever you like on the screen you can do this by
modifying the wait time (for input) to -1 (or any value < 0): then the snake
does not move until you press a movement key. For example:

``` <!---sh-->
    WAIT=-1 ./prog
```


When you eat a bug the snake will grow and you can draw more. If you want to
make it so you can go through yourself:

``` <!---sh-->
    WAIT=-1 CANNIBAL=1 ./prog
```

If you don't want to start out so small (i.e. you want to be able to draw more
quickly) you can just set the size to a bigger number (and you could do the same
with growth and moult/shed):

``` <!---sh-->
    SIZE=50 CANNIBAL=1 WAIT=-1 ./prog
```

Do note that although you're a bigger size you still grow one movement at a
time.

Okay but then if you get too many bugs the drawing will be over. If this proves
to be a problem simply do:

``` <!---sh-->
    SIZE=100 CANNIBAL=1 WAIT=-1 GROW=0 ./prog
```

Or something like that (maybe make the size bigger but that's up to you). You
could also set the max size to be the highest possible by saying

``` <!---sh-->
    MAXSIZE=-1
```

Which I've done in the [play.sh][] script.

I discuss how this mode works in [spoilers.markdown][].

Here's an example run where I spelt 'SNAKE'. As you can see it's far from
perfect: the snake after all does not leave gaps and the game does not support
diagonal movement and I also made a mistake and had to modify what I was aiming
for. But you can consider this mode drawing or practice mode.

```
		   oooooooooo   ooooo    o  oo  ooooo
		   o     o  oo  o   oo   o ooo  o
		   oooo  o   oo ooooooo  oooo   ooooo
		      o  o    ooo     oo o ooo  o
		   oooo  o     oo      ooo  oooooooo>
```


<div id="auto">
## <a href="#toc">Gameplay mode: Computer playing / Automatic mode (Photosensitive epilepsy/Stimulation overload trigger)</a>
</div>

**Photosensitive epilepsy/stimulation overload trigger warning:**
For those who have epilepsy or are susceptible to stimulation overload from
flashing lights please do be careful with this mode. Depending on your
susceptibility this could very well trigger seizures or other discomforts and I
wouldn't want that to happen to anyone. This mode has a lot of flashing of
different colours and depending on the exact parameters you specify it could
easily be in the trigger range for epilepsy but potentially stimulation overload
too.

If you're still here you can create this effect like:

``` <!---sh-->
    WAIT=0 WALLS=1 CANNIBAL=1 ./prog
```

As long as the bug evades you'll find that the snake is growing because it's
actually eating bugs; the computer is actually playing the game by itself! You
can still move the snake though it won't seem like you have much control over
it. If you pause the game you can see that it's bigger (you probably will be
able to even without pausing it).

Basically the snake is moving so fast that because the bug evades the bug will
inevitably move in the snake path's and therefore be eaten.

You might find it goes quicker if you set the evade count to a lower value for
example 1. Or you might not. But as long as the bug moves the computer can play
by itself.

Quick tests suggest that bigger dimensions it gets bigger quicker. But it also
seems to take longer for it to get a bug as it gets longer. I believe these
happen because the bug has to find a X and Y coordinate that's not occupied and
so with fewer available it has a harder time finding a place in that one line.


<div id="auto-variations">
### <a href="#toc">Computer player variations</a>
</div>

Here's how to make the bug move every time the snake moves:

``` <!---sh-->
    CANNIBAL=1 WALLS=1 WAIT=0 EVADE=1 ./prog
```


#### Help the computer win fairly quickly

If you want to see the game 'win' try something like:

``` <!---sh-->
    CANNIBAL=1 WALLS=1 WAIT=0 EVADE=1 MAXSIZE=10 ./prog
```


#### Negative growth (Shrink) Automatic mode

Here's a fun one I just thought of (a long time after these other modes were
thought of):

``` <!---sh-->
    WAIT=0 EVADE=1 GROW=-1 SIZE=9 MAXSIZE=10 CANNIBAL=1 ./prog
```

What you'll see is that first the snake will get to the size of 9 - whether it
shows to be 10 characters depends on whether or not it gets a bug before it can
get to that length - and then it'll start shrinking until it's just the head
then the head again (i.e. 1 then 0 in size) and then win! This is also in the
[play.sh][] script.


#### Adjusting the time/speed

Of course you can also do something like:

``` <!---sh-->
    WAIT=5 WALLS=1 CANNIBAL=1 ./prog
```

Which although might not seem like it is significantly slower.

#### Moving the snake about to create patterns

If you press different direction keys in some pattern you will see a pattern
form too (entirely dependent on how fast you react, what keys you press and I
suppose also how much the bug moves and the chance of being eaten also).

#### Other ideas

Here's an idea: how many moves is needed to make it possible to have some sort
of success in catching bugs? Obviously the dimensions will affect this value.

How long will it take for the snake to run into itself? For instance by doing:

``` <!---sh-->
    WAIT=0 ./prog
```

On my 13" MacBook Pro (replaced later by a 16") at the default settings going
horizontally the snake ran into itself at:

```
    OW!
    X:57/156 Y:20/41 S:155/997 B:30
```

What if you set the size to a high value? The lowest? There are bound to be
other games to play with this feature!


<div id="grow-shrink">
## <a href="#toc">Gameplay mode: Grow-Shrink mode (Positive and Negative Winning)</a>
</div>

In this mode you're simultaneously growing and shrinking but because the max
size is unsigned you can win both by shrinking to the point of losing your body
or growing to the full size directly. This is how it works:

You have a negative shedding growth and a positive growth size: negative and
positive winning. Depending on the parameters specified it might go one way over
the other. Try:

``` <!---sh-->
    SIZE=150 SHEDS=-5 GROW=10 SHED=50 MAXSIZE=250 ./prog
```

What this does is set the size to 150 (to make it not go down so quickly) and
then for each bug you eat it adds 5 to the size; for every 50 moves (that you
don't get the bug) you shrink by 5. You will find that at times you might only
decrease in size but then at other times - depending on size of screen and how
lucky you are with where the bug is relative to where it last was - you might be
growing. Combining this with the drawing mode could be interesting but I never
actually tried it.

The parameters above were chosen after playing with the mode a bit to find a
value that wouldn't take that much time but still would pose a challenge. One
could reverse it so that one shrinks more than growing.

The [crazy.log.html][] file has several screen
dumps with this idea.

You could also have it so that eating a bug makes you shrink and moving so many
moves you grow. I tried this and for me it was far more fun. The [play.sh][]
also has this mode:

``` <!---sh-->
    SIZE=100 SHEDS=5 GROW=-10 SHED=50 MAXSIZE=250 ./prog
```

Obviously there are many other variations. The [play.sh][] script has some
of them (the above is option 5; others are 4, 15 and 16 but only options 4 and 5
are called Grow / Shrink).


<div id="hypnotic">
## <a href="#toc">Hypnotic / Sleepy mode &#x28;Photosensitive epilepsy/Stimulation overload trigger&#x29;</a>
</div>

**Photosensitive epilepsy/stimulation overload trigger warning:**
For those who have epilepsy or are susceptible to stimulation overload from
flashing lights and patterns please do be careful with this mode. Depending on your
susceptibility this could very well trigger seizures or other discomforts and I
wouldn't want that to happen to anyone. The default wait time is 231ms, the
typical range of seizures is 3 to 30 flashes per seconds (but can be higher) and
that means that at **EVADE=1** every 231ms there will be a flash in addition to the
snake moving too.

Anyway this might sound absurd but it can be somewhat hypnotic by doing:

``` <!---sh-->
    EVADE=1 CANNIBAL=1 ./prog
```

And just moving the snake about not trying to catch any bugs - just let whatever
happens happen.


<div id="stim">
## <a href="#toc">Gameplay mode: Stimulation / Calming mode</a>
</div>

If you just need something to stimulate your mind to keep you calm or simply you
want to play a game without having to worry about winning or losing you can set
the growth size to 0 and then just move the snake round and round eating bugs
until you want to quit. You can enable cannibalism so that you don't have to
worry about even running into yourself and losing:

``` <!---sh-->
    GROW=0 CANNIBAL=1 ./prog
```


<div id="expansibility">
## <a href="#toc">Gameplay mode: Expansibility</a>
</div>

As I was writing this document and the game modes I have thought of other game
modes (they were added) and I have come back to this document to add more modes.
That's the beauty of the variables I have implemented: together with the
imagination and even just chance different modes of play can be devised. The
drawing mode was a happy chance of how the `timeout()` function works for
example.

As a person who was heavily involved in MUD development and design I know very
well how games need to be fun and have different options, not be too easy but
not be too hard either. And a game developer who does not play their games is a
game developer who is detached from their player base and the wants and needs
are therefore disregarded if even heard. I have played this game a lot for this
reason as well as I simply enjoy it and thinking up new modes.


<div id="scripts">
# 5. <a href="#toc">Scripts</a>
</div>

The following scripts are provided to simplify and automate some of the things
this file discusses as well as allowing to easily change the colours.


<div id="colours">
## <a href="#toc">Colours selection: snake-colours</a>
</div>

To do this use the [snake-colours.sh][] script like so:

``` <!---sh-->
    ./snake-colours.sh
```

If you want to pass in specific variables you can do that too e.g.:

``` <!---sh-->
    CANNIBAL=1 ./snake-colours.sh
```

The script will prompt you for the colour of the walls, snake head, body and the
bug.


<div id="preset">
## <a href="#toc">Automate the above gameplay modes</a>
</div>

The [play.sh][] script has the gameplay modes described in this file and is menu
based (there might be differences and some of the modes I include a variation).
The script tests the terminal (allowing you to continue even if problems are
detected), prompts you if you want to select colours (like those in
snake-colours.sh above) and then gives you a list of game modes to play. You can
pass in the game variables but note that if you pass in a variable that the mode
you choose uses then the script will override what you pass in.

To use you can do something like:

``` <!---sh-->
    ./play.sh
```

Or to make it so walls are an obstacle:

``` <!---sh-->
    WALLS=0 ./play.sh
```


<div id="variables">
# 6. <a href="#toc">Notes about some of the game variables</a>
</div>

The game variables can be used for a variety of things including different
gameplay modes (as shown above) but here are some general notes about a few of them.


<div id="wait">
## <a href="#toc">WAIT: Snake speed</a>
</div>

Besides the different game modes, if you find it too fast/slow you can change it
to a value that's better for you. Remember it's a wait time so if you want the
snake to move slower you have to increase the wait time!


<div id="evade">
## <a href="#toc">EVADE: Bug evasion frequency</a>
</div>

For every **EVADE** snake movements the bug will try and find a new place to
occupy. It might be very close to it and I do not ensure it's a new place at
all.

Each time the bug is placed the counter will be reset whether from eating the
bug or not reaching it in time. Default 300 moves.

This can help you get out of a trap but it can also sometimes make it harder.


<div id="sizes">
## <a href="#toc">SIZE / MAXSIZE: Initial / Max snake sizes</a>
</div>

997 might be a bit high for many people. Or maybe you don't have enough time. Or
you're not in the mood to lose. Or you want to get close to a size you were last
time but quickly. It might be in conjunction with drawing mode.

Note on snake size: there's a stated size (in the score line) which is what
the snake will 'populate' in the snake arrays and the visible size: as I have
discussed here and there the snake doesn't grow immediately so it takes time
before the snake is visibly that many characters. In other words just because it
says SIZE 29 doesn't mean it will instantly be 29 characters on the screen.


<div id="growth">
## <a href="#toc">GROW / SHEDS : Growth / Shedding sizes</a>
</div>

Similar to the initial size. Notice that the above point on size applies here:
it will take the number of movements before it is 'its full size'.


<div id="conclusions">
# 7. <a href="#toc">Conclusion &#x28;and inspirational words for everyone&#x29;</a>
</div>

I believe that this file has given more than enough information for anyone to
get an idea of what is possible with my implementation of Snake. I realise also
that most people won't have read this far and that's quite all right; I'm very
thorough and pay attention to details obsessively. Creating this game was a
delight and I am quite proud of what I have done.

Thank you for whatever level of attention you felt you could or wanted to give
and enjoy it in whatever way you see fit!

**Much more importantly is that Snake aside I hope I have demonstrated how with
the imagination and creativity almost anything is possible.** This is something
**that applies in our world in every way and *everyone* can do something amazing if
they believe in themselves!** I would have never thought this the case for me
years ago but I know it's true now. **Believe in yourself. Always.**

[terminals.html]: terminals.html
[troubleshooting.html]: troubleshooting.html
[bugs.html]: bugs.html
[spoilers.html]: spoilers.html
[snake-colours.sh]: %%REPO_URL%%/2020/ferguson1/snake-colours.sh
[number of hertz (flashes) per second triggering seizures]: https://www.epilepsysociety.org.uk/photosensitive-epilepsy#.Xjgpwi2ZOgQ
[termcaps.c]: %%REPO_URL%%/2020/ferguson1/termcaps.c
[cannibalism.log.html]: cannibalism.log.html
[crazy.log.html]: ferguson1/crazy.log.html
[play.sh]: %%REPO_URL%%/2020/ferguson1/play.sh


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
