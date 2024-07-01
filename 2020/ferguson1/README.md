## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please DO NOT fix
```

For more detailed information see [2020/ferguson1 in bugs.html](../../bugs.html#2020_ferguson1).


## To use:

``` <!---sh-->
    WAIT=N WALLS=[01] EVADE=N SIZE=N MAXSIZE=N GROW=N SHEDS=N SHED=N CANNIBAL=[01] ./prog
    # start pressing some arrow keys
```

where `N` is a number and `[01]` is either `1` or `0` (or more correctly zero
and non-zero).

### Variables:

* **WAIT**<br>
    positive or negative integer that changes how long to wait for
    a key press prior to moving again. < 0 blocks which allows
    for complete control over movement at your own pace. Default
    231; you can move faster by holding down or rapidly pressing an
    arrow key.

* **WALLS**<br>
    whether the walls are passable or impassable. Default passable,
    1; 0 makes walls impassable where you die if you hit a wall.

* **EVADE**<br>
    how many movements the Snake moves before the bug (well
    insect; see notes below about why bugs) will move to
    another location in the field. Default 300; 0 disables.

* **SIZE**<br>
    initial size of the Snake. Note that it grows by one per
    move so at the default 5 it will not initially be 5
    characters long! < 0 is likely an immediate win.

* **MAXSIZE**<br>
    the maximum size the Snake can become before the game is
    won. < 0 is the maximum size based on terminal dimensions;
    any other size will be capped based on the terminal
    dimensions to prevent problems. Note that when **SIZE+GROW >=
    MAXSIZE** you win _before_ you grow to the full size!

* **GROW**<br>
    size to grow every time you eat a bug. Default 5; negative
    values are allowed. 'Negativity' creates for fun gameplay modes with
    enough creativity. See [gameplay.html](gameplay.html)
    as well as [play.sh](%%REPO_URL%%/2020/ferguson1/play.sh) for some examples.

* **SHED**<br>
    every **SHED** movements you will grow (> 0), shrink (< 0) or
    stay the same length (0) by the **SHEDS** (below) value. Again
    with creativity you can create some fun gameplay modes.  NOTE:
    the concept of shedding in this game is a misnomer; see notes
    below.

* **SHEDS**<br>
    every **SHED** movements will impact what this value means: grow
    (> 0), shrink (< 0) or not at all (0). Exception: if the snake
    eats a bug the counter isn't incremented. Again with creativity
    you can create some fun gameplay modes here. For instance you
    can grow upon eating a bug but shrink every **SHED** movements
    and then it's a battle of whether you win by **SIZE < 0** or
    **SIZE >= MAXSIZE**. See [play.sh](%%REPO_URL%%/2020/ferguson1/play.sh) for examples.
    NOTE: the concept of shedding in this game is a misnomer; see
    notes below.

* **CANNIBAL**<br>
    whether you can go through the Snake or not. Default is 0
    (cannot - die if you try).


## Try:

``` <!---sh-->
    make test

    WAIT=75 WALLS=1 CANNIBAL=1 ./prog

    ./prog

    SIZE=-1 ./prog

    CANNIBAL=1 WALLS=1 WAIT=50 EVADE=200 ./prog

    WAIT=75 GROW=-1 SIZE=5 CANNIBAL=1 ./prog

    CANNIBAL=1 WALLS=1 WAIT=0 EVADE=1 MAXSIZE=10 ./prog

    ./play
    # allows you to configure colours and has various pre-configured gameplay modes

    ./snake-colours
    # allows for configuring colours
```


## Judges' remarks:

As the [Gadsden flag](https://en.wikipedia.org/wiki/Gadsden_flag) warns, beware of the snake!
This game has a number of configurable pitfalls including walls and snakes.

There is a good deal of useful documentation that is provided with this entry:

* [gameplay.html](gameplay.html)

Documented game *features* and gameplay modes!

* [terminals.html](terminals.html)

Information about terminal capabilities, dimensions (setting and how to restore sanity if it causes any problems) as well as colours (limitations etc.).

* [troubleshooting.html](troubleshooting.html)

Workarounds for various game *features*

* [bugs.html](bugs.html)

Bugs and things that might seem like bugs but are not.

* [chocolate-cake.html](chocolate-cake.html)

Because most of us could use some *Double-layered Chocolate Fudge Cake*!

* [obfuscation.html](obfuscation.html)

Read ***ONLY*** if you really must give up trying to de-obfuscate!


## Author's remarks:

### Feature-rich curses implementation of the Snake game (with many gameplay modes and options)

Snake has two cheat modes (passable walls and self [cannibalism]), a drawing (or
practising) mode, *can play by itself (**and win!**)*, is coloured (included
[snake-colours.sh][] and [play.sh][] scripts compile in player-selected colours)
and there are many other play modes (many more can be devised with the
imagination and the environmental variables; see [gameplay.html]
for many examples and [play.sh][] for preconfigured
modes) and options.  You can pause and there's even a built-in test unit for
some features!  The variables mentioned in the to run section at the top of this
file modify the behaviour of Snake.

Here are some other features of the game:

*   A drawing/practising mode (**WAIT** < 0 makes `timeout()` block).

*   Computer plays the game (**WAIT=0**).<br>
        - **EPILEPSY/STIMULATION OVERLOAD WARNING** included in the relevant
        section (this goes for a low **EVADE** value too).

*   Grow-Shrink mode (Positive and Negative Winning) mode (see
    [gameplay.html](gameplay.html) for more details).

*   The dimensions of the game (this is actually a terminal thing but I document
    how to do this and its potential pitfalls) (**LINES** , **COLUMNS**).

There are no complicated command line invocations; it's just a matter of passing
into the game descriptively named variables and I include a script that sets up
many different gameplay modes (see [gameplay.html](gameplay.html)
and [play.sh][]).

The [gameplay.html](gameplay.html) file has all the information on
what the game looks like, how to play, the different types of modes (that I have
thought of so far) including all those in the above list. Along with the
[play.sh][] and [snake-colours.sh][] scripts it's probably the most important
file for players.

The gameplay file is long but it includes game printouts as well as explaining
the many different gameplay modes.  The [play.sh][] script automates most (if
not all) of the gameplay modes described in the gameplay file (it also
allows you to change colours like [snake-colours.sh][]) as well as the judges'
suggestions (that I don't document so as to not deobfuscate them). You can pass in
environmental variables to both scripts though obviously some will conflict with
different options in play.sh.

Probably just as important is [chocolate-cake.html](chocolate-cake.html)
with an old but wonderful recipe (because the judges love chocolate and
who can blame them? - also it goes with one of the IAQs I include later).

The [troubleshooting.html](troubleshooting.html) file has some
advice on potential problems (and things that might appear to be problems at
first glance but are not) that I have thought of or encountered.

The [terminals.html](terminals.html) has a variety of information
specific to terminals from input/directions, dimensions, sanity and colours: a
sort of troubleshooting guide for terminals with some additional information.

The [obfuscation.html](obfuscation.html) has a variety of information
including some of the obfuscation techniques and a bit of how it works.

The [bugs.html](bugs.html) has a list of known bugs and things that
look like bugs but aren't as well as documenting a built-in test unit for some
features.

Because all IOCCC entries should have a man page I have included one (even
though much of it is what's also above). To render try:

``` <!---sh-->
    man ./snake.1
```

The [COMPILING.html](COMPILING.html) file has a few portability
notes and the [HACKING.html](HACKING.html) file has some
information on how one might modify things, things that could be implemented
(and how to/how not to go about some of the things) as well as some other
information on the entry (some of which is deliberately not true - a variation
of misleading comments). These files are probably insignificant.

I have more information about this entry at [https://ioccc.xexyl.net/2020/snake](https://ioccc.xexyl.net/2020/snake).

As noted for the files I recommend looking at the html files with a browser
unless on GitHub in which case I recommend the markdown files; this particularly
goes for the gameplay, bugs, terminals, troubleshooting ones along with the most
important one, chocolate cake. Most important for the cake as the formatting is
very important.


<div id="toc">
*   ['Bugs'](#bugs)
*   [NAQs/IAQs - Never/Infrequently Asked Questions](#naqs)
    -   [Do I have any inspirations for this entry?](#inspirations)
    -   [Are there any features I thought of that I wanted to implement but did not get to for some reason or another?](#features)
    -   [Are there ways that one can make this game easier?](#easier)
    -   [Are there ways to make it harder?](#harder)
    -   [How do snakes grow in real life?](#moult)
    -   [Any other interesting things about snakes?](#other)
    -   [Why can you go the opposite direction and so immediately die when not cannibalising?](#opposite)
    -   [Do you have any **DELICIOUS CHOCOLATE CAKE** recipes?](#chocolatecake)
    -   [What are the files prog.alt.c, prog.2.c, prog-j.c and prog.alt.c ?](#alt)


*   [Winning thoughts, dedications and thanks](#winning)
</div>


<div id="bugs">
### 'Bugs'
</div>

*   'The screen keeps showing bugs!' Well yes, that's rather the point! Help out
    by eating them. Keep eating them until you win! Then you will have the
    satisfaction of getting rid of the non-bug bugs (okay, insects, but that
    ruins a great pun and joke)! :)

*   The Snake in the game doesn't fly (yes there are [flying snakes][]). For
    other snake madness see the reports of '[human snakes][]'.

*   Technically walls, snakeskin and the snake itself would not be an obstacle
    in real life. The shed snakeskin is not an obstacle but walls can be and
    so can the snake itself.  Also snakes grow by moulting (technical term for
    shedding) so when the snake leaves its snakeskin behind it really ought to
    grow but instead it shrinks; this means negative shedding ought to have the
    snake grow and positive shedding have the snake - what?  It's a misnomer: it
    took fewer bytes and the negative shedding is a positive consequence of
    unsigned arithmetic.

On a more serious note look at [bugs.html](bugs.html).


<div id="naqs">
### NAQs/IAQs (Never/Infrequently Asked Questions)
</div>

<div id="inspirations">
#### Do I have any inspirations for this entry?
</div>

There are two in particular. First is a long time mate of mine wrote a bash
implementation of Snake several years ago (uncoloured, no cheat modes, hardcoded
dimensions etc. - in fact everything was hardcoded).

Back then I had thought of making a curses implementation of it but I never got
round to it. When the judges announced that the 2020 IOCCC contest would be open
from late December 2019 through 15 March 2020 I started thinking again on what
might be a good entry. By chance I thought of the Snake game and so wrote it
finishing the implementation of everything on 8 November 2019. Did I say
everything? That's an unintentional lie; I thought it was everything but I
implemented many new things after that. In fact I have numerous times thought I
was done only to have added yet another feature - or two or three or more!

Second is the old Atari game [Surround][] (according to Wikipedia it might even
be the origin of Snake itself). There were a few modes as I recall.
The object of the game was to surround your opponent so that they would run into
you, the wall or themselves. The opponent was either the computer or another
player.

In one mode you could go through walls (that's where I got the idea to do
likewise).  There was also a drawing mode where you could just move round making
different designs though that this is in my entry is a happy coincidence
(because `timeout()` will block when it gets a negative value). It's true that
in my Snake it's not quite the same but it's close enough. Perhaps it can be
made more like [Surround][] if it grows every movement but then depending on the max
size of the snake the game might be over fairly quickly (I don't remember how
it was done in [Surround][]).

In [Surround][] each move you made you would grow in size by one. This is what
inspired the shedding mode. Anyway I always loved the game and it's similar to
Snake in several ways.


<div id="features">
#### Are there any features I thought of that I wanted to implement but did not get to for some reason or another?
</div>

Yes. I thought it would be fun if there were other obstacles for the snake (in
my mind I was thinking of barriers like the walls but in the field).

I also thought it would be fun to have more than one bug at some point after say
the snake gets to be some size. One of the reasons I didn't do this is because I
was trying to save iocccsize bytes. I never got round to this though and I feel
that the features I have implemented are far more interesting and fun.

Another idea is having portals or teleportation but there are a number of
problems with those that would have to be worked out too.

I would have loved for it to be practical to support diagonal movement but as I
describe elsewhere it's not. That's perhaps what I regret most. It would be
possible to choose letters instead of arrow keys but even if that fit in the
size restrictions how would I show the head? I looked at the extended ncurses
character set and I didn't see any diagonal arrows. I suppose I could have it
not show the arrows but then that brings an old problem back.

Nevertheless I am quite happy with the features in the game and I hope everyone
who plays it enjoys it as much as I enjoyed writing/playing it.


<div id="easier">
#### Are there ways that one can make this game easier?
</div>

I can think of at the least the following:

-   Bigger screen will allow for freer movement (at least for more time?).
-   Increasing the movement (key press) wait to give you more time to choose
    (though this slows gameplay down).
-   Decrease the size of the snake (and growth size) though over time the size
    will become more and more problematic. But see the next item.
-   If you set a high growth size you don't have to worry as much about running
    into a wall or the snake itself for as long: because the check if you win is
    done when the snake size is increased: if you're 15 away from the max and
    each bug you eat you grow by 11 then it won't take as many bugs to win as it
    would if the grow size was 3. This applies to shedding size too.
-   If you want to show off keep walls passable and enable cannibalism.  It
    won't be a challenge then but at least you could show your final score?
-   Decrease the max size needed and if you want it even easier increase the
    terminal size.
-   And the one that applies to learning new things and getting more things done
    also applies here: remove all sources of distraction; turn the phone off,
    lock yourself in a soundproof room (refusing to get up for anyone or
    anything) and delete all your social media accounts for starters. Okay you
    don't really have to do the latter one but it can't be denied that they can
    be very distracting! As can phone (calls and otherwise). And visitors
    calling. And being on this planet.
-   If you don't want a challenge at all you could just set the start size to be
    the max size or very close to it. In fact if you have the shedding size to be
    even one on every move even if you normally can't win with the same size
    screen you might find it happens much more easily! You could of course play
    with these parameters in different ways together - there are certainly
    different combinations than I have given.
-   Of course you could also enable one or both cheat modes. You might be
    considered a filthy cheat but both modes are quite fun (one being enabled by
    default; does that mean it's not actually a cheat mode?).


<div id="harder">
#### Are there ways to make it harder?
</div>

-   Decrease the size of the game.
-   Decrease the size of the snake growth (and initial snake size).
-   Make the snake go faster (decrease the time the game waits for input).
-   Hold down the direction keys to move faster; this is something I do often
    though I have always had extremely fast reflexes and amazing eye hand
    coordination (at least after glasses and the three eye surgeries?).
    Admittedly I don't find this makes it any harder but it does make you have
    to react faster.
-   Be reckless (i.e. increase the chance of a wreck, a most amusing
    contradictory idea if you ignore etymology).
-   Look away for a moment every so often or have a conversation with your best
    mate, partner or family member whilst playing.
-   Make walls impassable and disable cannibalism.
-   Make the bug move more frequently (this can be a real problem when you can't
    go through the walls!).
-   Get used to going through walls and then try with it disabled.
-   Set the max size to the maximum (*`MAXSIZE=-1`* should do it).

And if you're a show-off you can try:

-   Closing your eyes (maybe better to practise with one eye open first or even
    in practice that is drawing mode?).
-   Have someone tickle you.
-   Watch a comedy show or have a laugh with a mate or partner or family member.
-   Have your partner tease you.
-   Speak on the phone with someone (paying attention to both). Come to think of
    it I have actually done this though not to show off but rather it's just
    something I'm capable of...
-   Watch a film at the same time.
-   Sneeze and/or cough.
-   Have breakfast, second breakfast, elevenses, lunch, afternoon tea, dinner or
    some other meal that you think of.
-   Get pissed out of your mind to make it difficult to think (please do not
    drive!).
-   Do more than one or all of the above at the same time (the longer the snake
    becomes the more often you should do these things).
-   Eat a [great chocolate cake][]. Actually you should do that whether you're
    trying to show off or not. Sleep, bath, eat chocolate cake, play Snake, eat
    chocolate cake, play Snake, sleep, ... For a great recipe see below.

But if that's not enough I don't know what to tell you other than suggest that
you make use of your talents for financial gain or at least a world record.
Either way I tip my proverbial snakeskin hat to you (animal cruelty but a pun is
a pun and every pun deserves to be shed).


<div id="moult">
#### How do snakes grow in real life?
</div>

They grow through a process called moulting - shedding their skin (other
creatures also moult). This takes place over some days and unlike humans snakes
never stop growing (though growth slows down as they mature). I chose the
variables **SHED** and **SHEDS** for simplicity and because the words are
shorter. I don't like the words because it's rather a misnomer but what I had
chosen before was longer - STRETCH and STRETCHES.

<div id="other">
#### Any other interesting things about snakes?
</div>

For the fascinating science behind snake slithering see [Snake walk: The physics
of slithering][]. For the bizarre thought of snake human hybrids see [human
snakes][]. The latter is hard to comprehend and there are some sad tails (tales)
in there too because I believe that people actually believe in this (how/why I
do not know) and they really do tell the truth as they see it (even if
impossible).

<div id="opposite">
#### Why can you go the opposite direction and so immediately die when not cannibalising?
</div>

When Ilya Kurdyukov was playing with this he questioned why this is possible
when other implementations don't have it this way. There are a few reasons.

First is that the friend's implementation had it that way and it had been a long
time since I had played it (if I ever did? I don't know now: I played so many
games over the years and the game most alike it that I played is [Surround][], as
below).

It also is the way it is in [Surround][].

It makes cannibalism mode very interesting.

And I happen to like it the way I have it. In the end a snake isn't an obstacle
for itself but in the game it is and I went all the way instead of only halfway.

It also would take more bytes and that's a problem with IOCCC rule 2b.

But if you have a problem with it you can always enable cannibalism and keep
walls passable and not worry about dying.


<div id="chocolatecake">
#### Do you have any **DELICIOUS CHOCOLATE CAKE** recipes?
</div>

Why yes I do! So good in fact that even my late stepmum who didn't even like
chocolate (except white chocolate) loved this cake. It's a double-layered
chocolate fudge cake. See the file [chocolate-cake.html](chocolate-cake.html)
for the recipe.  Note that it's a complicated
but it's well worth it!

I included it in both of my entries this year because if any of them won more people
can have this recipe; also it might help remind the judges that they really
should have their cook bake it so they can all - including the cook should they
also like chocolate - enjoy the cake whilst judging (and otherwise - it's a big
cake and very rich). Sadly they didn't get to enjoy it during their judging due
to the pandemic but maybe next time (or they can do on their own).

**Do make _SURE_ that  you pay attention to _ALL_ notes!**

##### Reiterating the notes about the cake and the icing

The following notes are so important that they are worth repeating here.

- The icing being difficult in warmer rooms is rather significant. If necessary
use the refrigerator or else air conditioner to cool down the place. This might
or might not work well enough.
- Do **NOT** use imitation vanilla!
- Do **NOT** use butter even if you think it'll come out better; it will come
out bad! Many people have made this mistake 'because they know better'. You've
been warned.
- Pay attention to the rest of the notes as well! They're crucial.



<div id="alt">
#### What are the files prog.2.c, prog.3.c, prog.3-j.c and prog.alt.c ?
</div>

I submitted three Snake versions; these are the other layouts for those few
(more likely none) who are interested to see them.

The [prog.2.c](%%REPO_URL%%/2020/ferguson1/prog.2.c) has more digraphs but I think no other significant differences.

The [prog.3.c](%%REPO_URL%%/2020/ferguson1/prog.3.c) is in a more artistic layout (a backwards S), has at least one
additional obfuscation technique (see deobfuscation information) but it also has more digraphs
and as the judges said they feel that digraphs are dated so that's probably why
they chose the first layout. The [prog.3-j.c](%%REPO_URL%%/2020/ferguson1/prog.3-j.c) version is
[prog.3.c](%%REPO_URL%%/2020/ferguson1/prog.3.c) with a shorter `J` macro.

The prog.alt.c version is the one that allows for customising the bug colour and
it's used in both [snake-colours.sh][] and [play.sh][]. It also calls `erase()`
first, clearing the screen, which the play.sh and snake-colours.sh scripts also
both do.

## Author's dedication:

<div id="winning">
### Winning thoughts, dedications and thanks
</div>

Once again I'm honoured to win along with some of the other veterans who I have
a huge amount of respect for; there's [Don Yang](../../authors.html#Don_Yang), [Dave
Burton](../../authors.html#Dave_Burton), [Yusuke Endoh](../../authors.html#Yusuke_Endoh)
and [Edward Giles](../../authors.html#Edward_Giles) all of whom are amazing
programmers. I'm especially proud to win besides Dave Burton and Yusuke Endoh
but Don Yang and Edward Giles too.

But there are some others who I don't remember like [Ilya
Kurdyukov](../../authors.html#Ilya_Kurdyukov)
(who's offered a lot of interesting thoughts on [Snake](%%REPO_URL%%/2020/ferguson1/prog.c) and
who plans to have his own version after the entries are published), [Nathan
Otterness](../../authors.html#Nathan_Otterness), [Nicholas
Carlini](../../authors.html#Nicholas_Carlini) (your entry is an absolutely brilliant
abuse of `printf` - and I totally agree with the judges remarks that your entry
is so novel that it'll be worth special mention in the future Best of IOCCC
list!) and [tsoj](../../authors.html#_tsoj) too.

Well done and congratulations to all of you again!  Thank you for submitting the
wonderful entries and I'm honoured to have my two entries beside yours!

To Dave Burton I thank you for your wonderful comments as well as pointing out
that even with [prog.alt.c](%%REPO_URL%%/2020/ferguson1/prog.alt.c) it probably would be better to make use
of the alt target instead of naming prog.c prog.alt.c. You're quite right, I had
thought of it but you brought it up so I could correct it. Much appreciated
mate.

I would like to dedicate this entry to my wonderful mum Dianne Ferguson whom I
love with all my heart and soul <3 Thank you for being the best mother
imaginable! You've been there for me in the darkest of my hours without question
without complaint and with all the love, compassion, empathy, sympathy and
devotion anyone could ever ask for. Bless you again and again and again dear
mother.

I also want to dedicate this to Vicky Wilmore who has given me a lot of
love the past few years and who was there for me in some very dark times. Thank
you Vicky sweetheart from the bottom of my heart and soul xxx

I would like to thank my dear friend [Martijn
Schoemaker](https://www.ficture.nl) for encouraging me in my programming over
the years and who I owe a great deal to. Thank you for believing in me and my
programming abilities (and other abilities) even when I couldn't believe in
myself! Very much appreciated especially coming from an amazing programmer who I
have huge admiration for!

Finally I want to thank Leo Broukhis, Simon Cooper and Landon Curt Noll for
continuing to hold the contest after all these years - and for having selected
my entries. It's a huge honour; thank you! I also happen to **love** your
comments as well as the award titles. And yes indeed 'most of us could use
*[Double-layered Chocolate Fudge Cake][]*!'

If you wish to contact me please do so. Please contact via mastodon. You can try
email but I'm more likely to respond to mastodon messages.

[COMPILING.html]: COMPILING.html
[HACKING.html]: HACKING.html
[bugs.html]: bugs.html
[troubleshooting.html]: troubleshooting.html
[human snakes]: http://www.macroevolution.net/snake-human-hybrids.html
[chocolate-cake.html]: chocolate-cake.html
[obfuscation.html]: obfuscation.html
[Surround]: https://en.wikipedia.org/wiki/Surround_(video_game)
[Snake walk: The physics of slithering]: https://www.bbc.co.uk/news/science-environment-35563941
[snake-colours.sh]: snake-colours.sh
[gameplay.html]: gameplay.html
[flying snakes]: https://www.bbc.co.uk/news/science-environment-25943693
[play.sh]: play.sh
[great chocolate cake]: cake.jpg
[https://ioccc.xexyl.net/2020/snake]: https://ioccc.xexyl.net/2020/snake
[Double-layered Chocolate Fudge Cake]: chocolate-cake.html
[terminals.html]: terminals.html
[troubleshooting.html]: troubleshooting.html

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
