9 Troubleshooting Snake

In this file I have a list of a number of possible problems that could show up
under some situations as well as some things that might appear to be happening
or be a problem but actually are not. For each one I have included a summary, a
more thorough description and any resolutions (from easiest to hardest). For
anything that can cause more than one issue I will list those separately to keep
it as structured as possible/easiest to find.

<div id="top">
* [The top wall isn't &lpar;all/some of the time&rpar; visible!](#topwall)
* [The snake isn't moving!](#notmoving)
* [I can't see the snake head &lpar;or other part of the snake&rpar;!](#invisiblehead)
* [I can't see the bug!](#invisiblebug)
* [The game froze!](#froze)
* [The game gets slower as the snake gets bigger!](#bigsnake)
* [I set SIZE=0 GROW=1, ate a bug but still only the head was visible!  Why?](#headonly)
* [I like black text on a white background but even with a white background terminal it ends up black!](#monochrome)
* [The text is hard to see &lpar;not bright enough&rpar;!](#toodark)
* [Can I move the snake faster temporarily without having to modify the wait time?](#movefaster)
* [On environmental variables more generally and string to int conversions](#envvars)
* [Errors and error reporting](#errors)
</div>


<div id="topwall">
## <a href="#toc">The top wall isn't (all/some of the time) visible!</a>
</div>

Because the score line is dynamic in length depending on the terminal size it
can happen that the score/status wraps to the next line(s). This can be fixed by
modifying the status line (see [HACKING.html][]) but
you shouldn't need it to be very wide.

* **RESOLUTION #0**: use a bigger screen (it doesn't take that many columns)

    **Tip:** try running `make test` to get an estimate of the minimum number of columns
    needed. This won't work right if you change the score line!

    Note that this utility is not perfect; I describe this elsewhere. Either way a
    small screen will make it harder to play esp without the cheat modes enabled
    (but they can still be fun with large screens).


* **RESOLUTION #1**: open the [prog.c][] and change the line

                #define J Z(X:%d/%d Y:%d/%d S:%zu/%zu B:%zu\n),Y,y[-2],X, *y, A, g, c );

    To be something like:

                #define J Z(B:%zu\n), c);

    Recompile and try again. That will then show only the number of bugs eaten.
    See the [HACKING.html][] file for other data you
    can include (though there are some discrepancies here and there as you'll
    see).


<div id="notmoving">
## <a href="#toc">The snake isn't moving!</a>
</div>

Unless the game is paused this should not be happening. It can appear sometimes
that there isn't movement and sometimes it might have to take a moment to
'unwind' but as long as the head is moving then everything is fine.

The tail might not always be moving which could make it seem like the snake
isn't moving but as long as the head is moving then the snake can be assumed to
be moving.


* **RESOLUTION #0**: unless the game is paused as long as the snake head is moving
everything is fine even if it seems sometimes that the snake tail is still: this
is normal and there are a few conditions that this might especially show itself
e.g. when the snake is growing.

    If you want to see this in action try:

            SIZE=150 SHEDS=10 SHED=1 ./prog

    Once you start moving you'll see that the tail stays still for a while and
    when it does move you'll see it doesn't move for long.

    Sometimes also it might appear that the movement is delayed but there are
    numerous causes for this some of which are a busy computer but ultimately
    it'll catch up; just give it the time it needs.

* **BOTTOM LINE**: if you want more information then see the [bugs.html][]
file.


<div id="invisiblehead">
## <a href="#toc">I can't see the snake head (or other part of the snake)!</a>
</div>

Possibly this could happen with too long a score line which I already discussed.
It also used to be possible during cannibal mode whilst cannibalising: you would
just have to continue moving on and you'd eventually find your head (assuming
the rest of the screen isn't covered with your body!). And what else could you
expect if you decided to shove your head up your .... ? :))

* **RESOLUTION #0**: actually I thought it would look better that you could see the
head even when cannibalising so you should be able to lose your head and at the
same time see it!

* **RESOLUTION #1**: if the terminal width is too small then it could be that the
score line is covering the wall, snake and even bug; I gave two resolutions to
that earlier in this file. To get a recommended number of columns use `make
test`.


<div id="invisiblebug">
## <a href="#toc">I can't see the bug!</a>
</div>

This has happened to me a number of times and early in development there were
times that I could swear I even saw it beyond the walls but this should not be a
problem now if it ever was.

However I have made a lot of effort to think of situations that might make the
bug location calculation and placement be a problem and even did some debug
output and wrote another test program to calculate the maximum number of places
the bug could be put etc.

One of the reasons I have the terminal dimensions have a minimum and also a
maximum has to do with the way the bug placement and max size of the snake (and
so arrays) are calculated: it could happen that because of it being unsigned
without there being restrictions it could end up being a bad value that causes
the bug placement loop to never end (in this case the snake would also stop
moving).

* **RESOLUTION #0**: if evasion mode is enabled (default after 300 moves) just wait
it out and the bug will move to a new place and it might be easier to see in the
new place.

* **RESOLUTION #1**: the terminal size is too small for the score line. See the
earlier problem for how to resolve this if that's the case.

* **RESOLUTION #2**: sometimes you have to look closely for it can be easy to miss.
If it's against the wall and the screen is [Snakey][] or you're tired or the colour
contrast isn't right for you or something like that it might be harder to see.
Try pausing the game (space) and scan the screen for it. If you really are
desperate copy and paste the entire file into a document and search for the bug
char (if it's an editor like vi/vim you will have to be sure to escape the char
since `*` is a regexp metacharacter). This has happened to me numerous times.

* **RESOLUTION #3**: if the colour contrast is not good for your eyes use the
[snake-colours.sh][] script to select a different colour scheme.


<div id="froze">
## <a href="#toc">The game froze!</a>
</div>

This should not be possible either but without certain safety checks in place I
have caused this (and I did this deliberately in development to find all the
conditions I could to resolve them).

* **RESOLUTION #0**: if this does happen it likely is to do with placement of the
bug; that is why I have the max size of the snake capped a fair bit below the
maximum number of coordinates in the game field: because the bug isn't to be at
a place the snake already occupies.

* **RESOLUTION #1**: if the system `rand()` implementation is really bad maybe it's
having a problem finding a location to place the bug. The best I can think of is
to try increasing the screen size or decrease the max size of the snake.

* **BOTTOM LINE**: if the bug cannot find a place to be this will likely cause the
game to freeze because the game loops until it finds an available place for the
bug to be; if the pRNG is so bad wrt where the snake occupies it could
theoretically happen. If this happens you will have to kill the game by e.g.
ctrl-c. Try increasing the screen size and/or decreasing the max size of the
snake. See below for some tests.

    I removed caps in a test and then:

                GROW=1 COLUMNS=30 LINES=10 CANNIBAL=1 MAXSIZE=10000 ./prog

    It froze at this point:

                X:14/29 Y:5/9 S:323/10000 B:318

    This is because there was only one place for the bug - where the snake head
    was to be. With these parameters the limit is actually 189! This could
    perhaps be increased but the calculation I have used is easy and although I
    certainly could make it so it's one less than the max that takes more bytes
    and I don't see it actually mattering.

    Another time I tried:

                LINES=6 COLUMNS=6

    And it also froze (as noted I impose a minimum of >= 10 for both LINES and
    COLUMNS).

    Ultimately I had to kill the program due to the game being stuck in the bug
    placement routine. I could have put in a maximum number of loops but what
    good would that do? It would use more bytes and what would it do anyway,
    win? Well that's what the max size is for.


* TERMINAL SIZE TO MAX SNAKE SIZE CALCULATION ETC.

    For this information and more use the termcaps utility:

                make test

    An example:

                terminal supports cursor movement
                terminal supports making cursor invisible
                terminal supports bold
                terminal supports colours

                terminal rows  41 (38  playable)
                terminal cols 154 (152 playable)

                snake size:   997 (max size: 5738)
                      bugs:   199 (max size: 1147)

                at least 34 columns (currently 154) recommended for snake size 997
                at least 37 columns (currently 154) recommended for capped snake size 5738

                No problems detected.

    Why are there only 38 playable lines for 41 rows? The first row is the score
    line, the second is the top wall, the last is the bottom wall. For columns
    you have the left and rightmost columns for the walls.

    The calculation for max size takes place after decrementing the max y/x;
    then it's `(maxy - 2) * (maxx - 2)`; above that would be:

                (41 - 2) * (156 - 2) == 6006

    If for some reason the game were to stall for this purpose you would have to
    kill the game by e.g. ctrl-c since the bug placement is stuck in a loop.
    This shouldn't happen though.


<div id="bigsnake">
## <a href="#toc">The game gets slower as the snake gets bigger!</a>
</div>

Realistically the game shouldn't take that much memory but maybe in some very
busy systems it would have a problem.

* **RESOLUTION #0**: if the `rand(3)` implementation is particularly poor then it might
be that the bug placement is taking more time.

* **RESOLUTION #1**: it could also be the arrays being updated as the snake gets
bigger.

* **BOTTOM LINE**: I find it unlikely that either of these happen and I don't know
what to say; you can try decreasing the max size to see if it doesn't reach this
problem. Otherwise it would be good to see if you can find a pattern: is it when
the snake is bigger i.e. the screen is rather fuller than when you first begin?
Or is the system rather busy?


<div id="headonly">
## <a href="#toc">I set `SIZE=0 GROW=1`, ate a bug but still only the head was visible! Why?</a>
</div>

* **RESOLUTION #0**: the size includes the head but what should it show if the size
is 0? The head is the obvious choice so once you do get to size 1 you will still
only have the head. When you get to size 2 you'll have part of the body too.
Try:

                SIZE=1 GROW=1

    And you will see that at one bug you'll have size two and just as if you had
    two bugs with the previous invocation.

    BTW: when you are size 1 you can go back on yourself even if cannibalism is
    disabled because there really isn't anything to go back through: it's just
    you moving the head until you find a body to use! Once you have size >= 2
    then cannibalism mode counts.

* **BOTTOM LINE**: in some senses `SIZE=0` and `SIZE=1` are the same thing.


<div id="monochrome">
## <a href="#toc">I like black text on a white background but even with a white background terminal it ends up black!</a>
</div>

This is a curses thing but fortunately it should be easy enough to solve.

* **RESOLUTION #0**: try setting the terminal to monochrome for the invocation of
the game. Depending on what is installed on your system you might not have a
monochrome terminal but you can certainly get them. In Red Hat systems these can
be found in the package ncurses-term but maybe that will vary on others. I don't
recall having to install it under macOS nor Fedora but those systems have GUIs
so that's probably why; in CentOS I did have to install it specially.

    The `-m` suffix to terminal names means monochrome. Under Linux this
    terminal is under `/usr/share/terminfo/l/linux-m` and under macOS (Catalina
    at least) it's at `/usr/share/terminfo/6c/linux-m` (for macOS Ventura it's
    `/usr/share/terminfo/6c/linux-m`).

* **BOTTOM LINE**: try using a monochrome terminal for the game by e.g.:

                TERM=linux-m ./prog

    And then on your white background terminal the game should keep the
    background white and the foreground black. This will of course mean you have
    no colour but unfortunately changing the background colour of curses would
    eat too many bytes in the entry (I cite the functions in the
    [HACKING.html][].

    I discuss colours and terminals in much more detail in
    [terminals.html][].


<div id="toodark">
## <a href="#toc">The text is hard to see (not bright enough)!</a>
</div>

* **RESOLUTION #0**: make sure that your terminal settings have for bold text a
brighter font. The way I have my terminal profiles set up is to use bright
colours for bold text. I specifically enable bold in the program so try and find
out if enabling brighter colours is possible.

    If it's already set at brighter colours I do not know what to say. Try
    playing with the colours in your terminal, maybe the font size or various
    other settings. Probably better to make a new profile for this first in case
    you mess up your old one. FWIW I haven't had this problem on consoles only
    and in my systems I have the option to enable brighter colours for bold - it
    was only in testing that I came across this problem. Of course you might
        also try changing the colours of the game. For that see
        [snake-colours.sh](%%REPO_URL%%/2020/ferguson1/snake-colours.sh) and
        [play.sh](%%REPO_URL%%/2020/ferguson1/play.sh).


<div id="movefaster">
## <a href="#toc">Can I move the snake faster temporarily without having to modify the wait time?</a>
</div>

Yes. The `getch()` call is non-blocking when the timeout value is positive so
it's up to that number of milliseconds.

* **RESOLUTION #0**: all you need to do then is hold down the direction key (or for
that matter any other key that `getch()` will pick up on). You can also rapidly
push the key instead of holding it down.

* **BOTTOM LINE**: depending on the key repeat rate and/or how fast you repeatedly
hit the key you can have more control over the speed - as long as it is quicker
than the regular wait time. For negative wait time (drawing mode) you have to
hit a key every time to move because it is blocking.


<div id="envvars">
## <a href="#toc">On environmental variables more generally and string to int conversions</a>
</div>

What happens if you do:

``` <!---sh-->
    WALLS= ./prog
```

Can you run into the wall since you didn't specify a value and the default is 1?
No. That's not the way it works. By saying WALLS= you have told the system that
there is that environmental variable. However the way the `strtoul()` functions
work is that if there's no valid input it returns 0. This can be detected but
it's wasteful (iocccsize wise) and I have never felt that having invalid input
for a number could have a better value than 0.

If however you were to give valid input followed by invalid input the valid
input would be parsed. For example:

``` <!---sh-->
    WALLS=1test ./prog
```

would let you go through the walls. On the other hand

``` <!---sh-->
    WALLS=test1 ./prog
```

would not. Furthermore if you specify the same variable more than once it's the
last one that counts. For example:

``` <!---sh-->
    WALLS=0 WALLS=1 CANNIBAL=1 CANNIBAL=0 ./prog
```

would allow you to go through walls but you could not cannibalise.

Also note that I specify base 0 which means that you can also have it in hex and
octal. These are all the same:

```
    SIZE=0x3
    SIZE=3
    SIZE=03
```

The way the functions work is if 0x (or 0X) it's considered hex; if prefixed
with a 0 it's octal and otherwise it's decimal. If you specify invalid data
(even if only at the beginning of the string) the functions return 0. For
example:

```
    SIZE=0
    SIZE=f
    SIZE=-
    SIZE=f1
```

are all equivalent.

Observe that:

```
    SIZE=08
```

is invalid input because octal only has digits 0 - 7: the resulting size will be
0.


I discuss the signed/unsigned issue to do with curses and sizes in C being
unsigned in [bugs.html][] but probably there isn't
anything more to say here.


<div id="errors">
## <a href="#toc">Errors and error reporting</a>
</div>

If curses fails to initialise you should get an error that says 'curses error'
and you have every right to curse it to hell if that's what you so wish.
Apparently curses will report an error itself if that function fails but that
escaped my notice until later on so you might get two errors in that case.

Assuming it succeeds the game obtains the maximum y/x of the terminal. The
screen size must be at least 10 lines/columns (though in code the number will
not be 10); if either is smaller you will get 'screen too small' and the game
will end (yes things that haven't begun can be ended).

If `calloc()` fails to obtain the needed memory you'll see something like (here it
was before I added proper - to make the perfect and obvious pun - capsizing
so that by setting the size to -1 it went to the max unsigned value):

``` <!---sh-->
    $ MAXSIZE=-1 ./prog
    memory error
    X:0/157 Y:0/42 S:3/18446744073709551614 B:0
```


**BTW**: there are two arrays that have to be **MAXSIZE** (technically + 1).

Is it possible that some value specified by the user could mess this up? I do
not know but what I do know is that because it's unsigned it can't be negative;
if the max size is 0 then the array size will be 1 but it won't matter because
the snake size will be >= that max anyway. But here's a curious output:

``` <!---sh-->
    SIZE=1 MAXSIZE=0 ./prog
    YOU WIN!
    X:78/156 Y:20/41 S:0/0 B:0
```

Why does it show snake size as 0 when I specified 1? It's because the max size
is 0 and I limit the size to be no bigger than the max size.


[HACKING.html]: HACKING.html
[prog.c]: %%REPO_URL%%/2020/ferguson1/prog.c
[bugs.html]: bugs.html
[terminals.html]: terminals.html
[snake-colours.sh]: %%REPO_URL%%/2020/ferguson1/snake-colours.sh
[Snakey]: https://www.hp-lexicon.org/character/gaunt-family/morfin-gaunt/


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
