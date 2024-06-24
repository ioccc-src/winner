# Introduction (SPOILER ALERT)

In the [gameplay.html][] file I have given enough
information to know how the game looks, how to move the snake, how to pause etc.
In this file I am including (some) information on how the game actually works:
the technical details as it were, obfuscation techniques and also some of the
ways I reduced the iocccsize so I could do more with the code. Probably this
file causes more spoilage than the other files though that's not to say
everything will be answered here.

If you're still interested in this file (i.e. you're a judge or someone who
wants to know more about it) read on. Yes I write a lot. But you probably
already knew that so no harm there, hey?

<div id="toc">
-   [How does it work?](#works)
-   [How does the snake movement work?](#movement)
-   [Drawing &#x28;manual&#x29; and computer playing &#x28;automatic&#x29; modes](#manual-automatic)
-   [Collision detection](#collision)
    *   [Cannibal collision detection](#cannibalcollision)
    *   [Collision detection when resizing the window of the game](#resizing)
-   [Obfuscation](#obfuscation)
-   [Skinning the snake &#x28;i.e., decreasing the iocccsize&#x29;](#skinning)
-   [A few more interesting size optimisations](#size)
</div>


<div id="works">
# <a href="#toc">How does it work?</a>
</div>

The gameplay I have already described but this explains the way things are
actually done in more detail.

First I initialise curses; if this fails I print an error message (`curses
error`) and return 1.  Next the screen size is determined and I subtract 1 from
both `x`/`y`. If it's too small curses is ended and an error message (`screen
too small`) is printed - returning 1.

Next the max size of the snake is determined: if `MAXSIZE` is specified then
it's the value of that; otherwise it's the default. But in either case if it's
too big based on the screen dimensions it's capsized. The arrays for the snake
are this size + 1. Other environmental variables are also processed.

Then the arrays are allocated; if either return NULL curses is ended, an error
message (`memory error`) is printed and return 1.

If no errors have occurred I set up colours, turn on bold, set up the keypad
etc., place the snake, the bug, draw the walls and then it waits for the first
move (or quit of course). Technically I don't 'wait' for input as such: unless
the wait time is negative (drawing mode) it's just a non-blocking call up to the
`WAIT` milliseconds but in no event will the snake move until it is told to at
least once (in drawing mode it will always wait).

In drawing mode if you pause then when you resume (hit space) the snake will
move the last direction it had been told to move - because the direction is set
and input was detected (the same goes for another key e.g. `g` - just like in
normal mode). But it will then wait again for input.

The snake function both draws the snake and updates the arrays; if the new size
is >= the max size the game is won (the winning size will be shown as the max).

Else the arrays are updated; when the array is being updated the body of the
snake is drawn. After this the head is drawn. Depending on the length of the
snake wrt the size the snake technically it might be that the number of
characters the snake takes is increased rather than having moved the snake
forward (i.e. the tail moved by one). This registers where the snake is and
where it was but no longer is (important particularly for negative growth/shed
sizes).

After that a bug is placed (but not drawn) in a pseudo-randomly selected area of
the field. This function takes a parameter which if not 0 and the bug had
already been placed somewhere (in other words if the bug was just eaten) call
the snake function. As long as the game isn't won at that point find a new place
to place the bug.

Next the score line is updated and then whilst the game is not over (player
loses/quits/wins) the movement proceeds; if the game hasn't started yet it will
jump to the top of the loop. If it's paused the same thing until it's resumed.
The rest of the loop can be described thusly.

It checks the current max `y`/`x`, draws the walls, bug, gets any input from
keyboard, and then if there is movement checks for collisions; if current max
`x`/`y` are is/are smaller than original then it's automatically a game over from
running into walls regardless of that feature status - this simplifies things
greatly (see below for more details).

If cannibal mode is disabled (the default) and the snake runs into itself then
it's also game over. Or did it run into the wall? If walls are passable (the
default) it will come out from the other side; else it's game over.  If it comes
out on the other side and the snake is there and cannibal mode is disabled then
it's also game over.

As the snake moves it will for each move grow by one up to the technical size.
This might at times look a bit different from other times but it's a visual
thing based on the internal state of the game and the features enabled for
example shedding and shedding size.

Finally if the snake's new coordinates are on a bug a new bug is placed on the
field, the snake grows and the score is updated. Otherwise if the bug has waited
the number of moves that it waits before it finds a new place the bug is placed
in another location too (and the snake does not grow). In either event the snake
location is updated and redrawn.

There's also the processing of any shedding at this point. If the snake eats a
bug the snake will not shed; if it sheds the snake will not move in the same
manner as if it simply moved. Growth/movement can in some ways be conflated.


<div id="movement">
# <a href="#toc">How does the snake movement work?</a>
</div>

The way the snake looks to move is that every time the snake moves the last
position (the tail) is replaced with a space (`' '`). If the snake eats a bug
then the snake will get bigger in the next `N` movements. Note that if the snake
isn't its full size it will only be growing and so might not appear to be
moving at the tail end; I have discussed this more than enough elsewhere.

There are two arrays that store the last Y/X coordinates of the snake's
positions that are shifted forward as the snake moves about the field looking
for bugs.


<div id="manual-automatic">
# <a href="#toc">Drawing (manual) and computer playing (automatic) modes</a>
</div>

How do these modes work? The `timeout()` function takes a signed int: if it's `<
0` it waits indefinitely; if it's `0` it returns immediately even if there's no
input waiting (if input is there then it's used instead); and if it's `> 0` it
waits that many milliseconds. Thus a negative value allows for complete control
over the snake's movement (speed and otherwise), a value of `0` means the snake
will move as long as it's not paused etc. and otherwise it waits up to that many
milliseconds (which is how the `0` value comes into play).


<div id="collision">
# <a href="#toc">Collision detection</a>
</div>

This was an interesting thing to work out. Because the snake could occupy more
than one row and more than one column at a time the two arrays approach seemed
good to me.

I already mentioned how the array is shifted but to be clear: the snake head is
always at element size - 1 and the tail is at 0 and so it's just a matter of
verifying if the snake head is at a place that's occupied by the snake, the wall
or the bug.

The bug does its best to avoid landing where the snake is but given that snakes
are very flexible and cunning who can tell what might happen? As I noted _these
bugs are not bugs! :)_


<div id="cannibalcollision">
## <a href="#toc">Cannibal collision detection</a>
</div>

How does cannibalism change collision detection? The fact that each time the
snake function is called there is a space printed at the tail end was a problem
to resolve: what happened is if the snake went through itself then at some point
there would be a space that breaks the snake into more than one piece (where the
tail was but that had been another part of the snake)!

So what I do: first the tail is cleared, then as the snake coordinates arrays is
being updated I redraw the snake chars. Then at the end the head is drawn (it
used to be the head was drawn first but by drawing it after you can see where
the head is inside itself, creepy as it is). Thinking on it this very possibly
is why (or partly) the negative shedding leaves the head somewhere in the middle
of the snake (or that the head of the snake is left behind) but again I don't
think that as a problem.

There are other strange ways this looks. Not only does it look like lines
intersecting at any number of places but it looks particularly strange when the
snake goes the opposite direction: it has to unwind as it were, and for a moment
you might not see what is truly happening.  There are two ways you can look at
this I think.

First is that it's physically impossible in real life so the fact this cheat
mode exists for a different kind of play means it should look unnatural: for it
*is* unnatural!

The second is you can look at it as if two more snakes are having fun with each
other. This can also appear to defy physics!

Choose your poison. Or rather your venom.


<div id="resizing">
## <a href="#toc">Collision detection when resizing the window of the game</a>
</div>

What happens if the window is resized during the game? If the size is increased
then the border can (and will) stay the same; but if the window is shrunk then
what? It would be very difficult if not impossible to redraw the snake: where
would the snake be and what about the border? The arrays would have to be
adjusted too! Another issue: what if the snake is beyond the new walls?

The best thing I could think of is that if the window is shrunk then the snake
is assumed to run into the wall: in other words the game is at that point over.
If the window is increased in size nothing happens other than the game won't be
the full window size (or technically a few rows/columns fewer): everything will
remain the same. This GREATLY simplified things.

There was another problem at some point where the snake would quickly grow if it
was increased in size but I believe that's resolved. Anyway what kind of field
in real life increases in size like that so suddenly? :)


<div id="obfuscation">
# <a href="#toc">Obfuscation</a>
</div>

- I make use of the C token pasting operator. Although this is well known it's
probably less known and either way it's not as simple as just having the code
that it translates to. For example why have:

                    attroff(COLOR_PAIR(L));

    When you can have instead:

                    attroff(m(PAIR(L)));

    It's an extra layer of indirection. This used to be more used but when
    making it easier for users to change the colour pairs I no longer used it to
    set up colour pairs. It might not defeat `cpp` but it does make for more
    reading otherwise (depending on how you look at it maybe less?).

    It also helps save iocccsize bytes (but not as many as it used to!).

- What is this block of code?

                    F(MAXSIZE)g d g = f((a)((*y-2)*(y[-2]-2)),g);
                    F(GROW)N d
                    F(SIZE)A d
                    F(WAIT)y[-3] = (int) strtol(z,NULL,0));
                    F(EVADE)W d
                    /* and so on */

    There are several things going on here but I'll focus on the main one here and
    leave the others to their own: the `F` macro and the associated `d` macro are
    here important.

    In addition to saving many bytes this also makes for interesting reading.
    What this actually is doing is checking for environmental variables. If
    `getenv()` does not return NULL then strtoul() is called on it (except for
    the one that clearly shows strtol()).

    There are other things going on (below).

    Now it might not defeat the cpp but can you tell me what this is even with the
    cpp?

                    f((a)((*y-2)*(y[-2]-2)),g);

    The cpp might get it closer to what you might expect in a normal program but I
    refer to the array offsets (below also).

- Stringification: there isn't a single `"` in the source code! The `F` macro
uses the macro `Z` which does the real work. At first `F` was only `getenv` but
I changed it to use stringification. Following the creation of the `Z` macro I
made it use it instead. If I remember rightly that uses extra bytes but somehow
it felt better this way in my head. Then to save many bytes I made the macro do
much more than that (that is the `F` macro).

    As for the Z() macro it means that I could remove `"`s; for example:

                    #define J Z(X:%d/%d Y:%d/%d S:%zu/%zu B:%zu\n), Y, y[-2], X,*y,A,g, c);

    Which as I have discussed elsewhere is the entire set of parameters to both
`mvprintw()` and `printf()` plus the end of the function call (i.e. `);`.

    BTW: There's another really cool benefit of stringification: because more than
one space is converted to a single space I can have it spread across columns on
the format and even new lines if necessary. This fact along with the next
technique causes some beautifiers problems too.

- Another use of the `Z` macro is this curious line:

                    static  const char*s  =Z(   ; +<>^v);

    There are a number of curious parts. First is the Z() part makes it look
    like a function call. Of course that wouldn't work as such because an array
    initialiser needs an initialiser list or a string literal. Whether that's
    immediately obvious to others I don't know but then how is this even possible?
    A `;` followed by ` `, `+`, `<`, `>`, `^`, `v`?

    A very minor factor is that the character 'v' is there and it's (`v`) also
    used as a macro (well, define) 'might' be of something to some people. Or
    programs maybe?  For instance using in vim `*` on the `v` in that array and
    it takes you to other instances of `v`: as in `\<v\>`: which happens to be
    something else entirely.  That itself however might or might not be
    significant for this instance!

    But what function would take the string (...function and string?) that it takes?
    The sequence of characters would normally cause compiler errors like that.
    I have it in the function that uses it; static since it need never change:
    only one copy is needed. Why I have it in the function is to move it further
    away from the definition of `Z()`. I will also be returning to this one
    again.

    Another example is using the `E()` function e.g.:

                    E(Z(YOU WIN!));

    Which happens to be in the same function the above char array is defined. Also
    it's more like a string than anything but yet it's not visibly a string.

    Some beautifiers didn't like this at all.

- There's an `#undef` following an `if` in a way to draw attention from what to
do if the if is true.

- There are a couple case statements that fall through to the next case
condition. Actually one falls twice: into the one below which falls into the one
below that. This means the order it is in is required. It also reduces the
iocccsize a reasonable amount (by having it in the main loop I could do these
things which reduced the number of keywords needed).

    When quit is requested it falls into pause. But then pause falls into the
    default (so no recognised key is pressed) which does `x = 0;`. Outside the
    switch block there's `if (x) P = 0;`.  So what this amounts to is: if quit
    is requested pause will be changed to the opposite state. This will then
    fall to setting x to 0. And because x is 0 the state of pause won't be
    updated again.  Now because `Q = 1;` (or actually `l`) it doesn't matter if
    `P || !P` because Q will also jump to the top of the 'loop' only to exit
    since the condition no longer is true.

    But then if pause is pressed the same thing applies: it will be updated to
    the opposite state and then it will fall to the default case which sets `x =
    0;` which means it won't update pause outside the switch block. If pause was
    enabled then the loop will start over only this time because quit wasn't
    requested it will re-enter the loop.

    So basically quit can both pause and resume but it doesn't matter because it
    will still quit; and pause will fall to the default statement without being
    updated again either. In other words the only time pause will be updated
    (disabled) *outside the switch* is if a direction key is pressed. But of
    course it's disabled inside the switch if pause key is pressed when it's
    already paused! This removed three break statements because the order allows
    it; if the order was changed then the code would break in another way and
    not the good kind!


- On the note of pausing there's at least one instance of removing `if..else`
(besides those in e.g. environmental variable processing) that's curious: I
converted this:

                    if (!P) P = 1;
                    else P = 0;

    To this:

                    (!P && (P = 1))||(P=0);


- Makes use of the different namespaces to have variables and labels be the
same identifier. For example in main() there's a variable that also have the
same name label for `goto` (there used to be two pairs in `main()`).

- And on that note: makes use of the ugly `goto` in numerous places. This
includes simulating a `while()` loop, breaking out of that 'loop', breaking out of
two loops (a `for()` in the `'while()'`), re-entering (as in starting over) a
`for()` loop and for dealing with errors.

- Why do I check for `Q || P` and then `goto x` only to then check for `!Q && !D`
to then `goto x`? Do I need to check `Q` at all? In fact I do but at a quick glance
it might be easy to miss.

- Uses an unnamed array (compound literal) for several different game variables.
The pointer to the first element is defined like `int *j`:

                    static int Y,X,*j = (int[8]){231,0}, *U, *V, *e, *n, Q, P,x,*y,l=4,*D;

    Does the 231 seem familiar? It should: it's the default key delay for the
    `timeout()` call (which I will return to again). The rest are 0 default. But
    what about `j`? Is it even used? Actually in main:

                    y = j+3;

    But aside from that `j` is not used. However...

- Major abuse of negative pointer offsets along with confusing names. I'll say
this in two parts: the negative offsets and then the confusing names.

    Can you honestly tell me that this is easy to follow?

                    if (Y < 1 || Y >= y[-2] || X < 2 || X >= *y || y[-2] >= y[-1] || *y >= 1[y])
                    {
                            if (*p && !(*y>=1[y]||y[-2]>=y[-1]))
                            {
                                if (Y<1||Y>=y[-2])
                                    Y = Y<1?y[-2]-1:1;
                                if (X<2||X>=*y)
                                    X = X<2?*y-1:2;
                            }
                            /* ... */
                    }

    That's not the only place negative offsets occur! Observe the ternary operators
    there too.

    I'll go back to the `F()` macro and in particular what follows one of them:

                    g d g = f((a)((*y-2)*(y[-2]-2)),g);

    To parse that at the very least you have to know that `y` points to `j + 3`.
    Then you have to know that `j` points to the first element of an unnamed
    array (compound literal). But then you also have to know that that array has
    different types of data. Once you figure out the elements in question you
    then have to account for the offset that `y` is. Then once you have that
    figured out you need to consider the negative offsets to `y` (this also
    applies to the block above of course and maybe more so). Then you have to
    think of operator precedence etc. I mean what is:

                    (*y-2) * (y[-2]-2])

    ...about? An offset of `-2` and subtract `-2` from that. Multiply that by the `*y`
    (which is `j[3]`) `- 2`.

    But why is there a `g d g =` when the other lines only have the variable (or
    location) and a `d`? (Excepting the one that doesn't refer to `d`.)

- On the confusing names etc.: the `getmaxyx()` function gets the maximum Y, X
dimensions. Now in the first call in `main()` I have the code and tests following:

                    getmaxyx(v, *y, y[-2]);
                    --*y; --y[-2];
                    if (y[-2] < 9 || *y < 9)
                            return E(Z(term too small));

    Clearly the `max x` must be stored in `*y` and the `max y` must be stored in ..
    `y[-2]`. After all anyone knows that the coordinates are in the order `(X,Y)`!
    In fact the output of my entry and my documentation demonstrates this
    clearly: `X` before `Y`! It's so true in fact that the documentation for curses
    more than once states that it's actually `(Y,X)`! But the fact I don't even
    refer to a `x` is possibly confusing even without the negative offset.

    Of course I don't have to use negative offsets at all! I could use positive
    offsets for every time I use negative offsets. But where's the fun in that? :)

    BTW: Some of these are not in the table of expressions in the
    [HACKING.html][] file.  Also there might be some
    code in there that is no longer correct (it was before I started
    obfuscation) though it might be able to give an idea.  Spoilers abound in
    that file (in addition to this file) but the [HACKING.html][]
    file states things that are no longer true: a way of obfuscation
    itself! Instead of misleading comments it's misleading statements in the
    file that explains what some of the things are for!

- Misleading variable names for coordinates. In other words the `Y` coordinate is
called `X` and the `X` coordinate is called `Y`.  This adds to the already confusing
array references but it also adds to the confusion of the order of the curses
functions coordinates: it _appears_ that yes `X` does come first because the
function calls that take coordinates suggest it - but in actuality it's just
that the names are deliberately swapped. Of course that's after you determine
that the variables `X` and `Y` are only the snake head but at that point you
still have to figure out the array confusions. Also if you're tired `V` could
easily be read as `Y` and I have a lot of fun with `V` which I will get to next
(and again). Finally why not have them be two different names unrelated to
coordinates? I thought of this and I think it's more confusing to have something
that is associated to what it is but incorrectly rather than something unrelated
entirely: the mind constructs things from what it has seen, what it experiences,
what it knows, and since `X` and `Y` are used for coordinates the natural response
of the brain is to assume `Y` is what is really `X` and `X` is what is really `Y`.


- More confusion with variable names: If you notice the `int *U, *V` they are
also part of the compound literal: that is they point into it:

                    U=y+2; V=U+1;

    Except that these two are done in two different places: away from the
    assignment of `y` to remove them further away from the contexts they are
    used in.

    There's another reason for moving it further down: if you look at the bug
    drawing function (which comes before `main()`) you will see that there I set
    the bug location to refer to the `y` 'array'. I do blank out the old
    location at `*U, *V` but then assign the new location differently. Then in
    `main()` I draw it at `*U, *V` and also check for the bug being eaten there
    too.


- There's another array that holds a variety of data.

                    static k p[5]={1,0},W=300;

    It holds the following information (but not necessarily in this order):

                    WALLS
                    CANNIBAL
                    SHED
                    SHEDS
                    EVADE

    But how will you know that just looking at the declaration? Many variables
    and they're part of collections but the many layers of indirection cause
    confusion to the already unhelpful variable names (for those that even have
    names!).


- There's an array of pointers to functions too: it holds three functions but
rather than always use the array I only do some of the times. I even use the
same function in the same general area with both names in order to mislead.
Incidentally `splint` seems to have a parse error on the declaration though I
don't know why.


- On arrays/pointers in general I also use e.g. `3[p]` and `p[3]` (there are
many other examples that I have already shown).

- Expanding on referring to the same thing in more than one way take a look at:

                    case KEY_LEFT:
                            V[1] = l-3;
                            break;
                    case KEY_RIGHT:
                            V[l/l] = l/2;
                            break;
                    case KEY_UP:
                            V[l-3] = l-1;
                            break;
                    case KEY_DOWN:
                            V[l/4] = l;
                            break;

    What's going on there? First of all the letter ell looks very much like the
    digit one but above there are only two references to the digit `1`; the
    others are the letter `l`. If you're tired though, don't have the best
    vision (I'm speaking from experience here and that's not even considering
    the font) it would be easy to miss. Online in a text editor you have syntax
    highlighting of course but there's more to it than that. Also in other parts
    of the code there are references to the digit 1 instead of the letter ell as
    part of array indexes too (so which is it?).

    Second is that the index referenced in each of the case statements evaluate
    to the same: 1. That's all accomplished by taking advantage of the value of
    `l`: 4.

    And then to further make use I have done the same for the value to assign to
    that element: 4 - 3 is 1, 4 / 2 is 2, 4 - 1  is 3 and 4 is obviously 4.

    But doing it this way means you have to first of all know that there's the
    variable `l` (conveniently declared at the top of the file); then you have
    to determine (once you're at this place in the code) if it's the digit or
    the letter - for each reference (since both exist)! After all it's entirely
    possible that I could have negative offsets here (and there's nothing that
    would prevent negating a variable either in this case): I have done it many
    other places! But even after all of that you still need to do the
    calculations when I could simply have had:

                    V[1] = 1; V[1] = 2; ...

    Etc.

- Variable reuse. For example in the function E() there's a variable that keeps
track of whether or not it's been called; that variable is `h` and it says
whether to call `endwin()` or not in as in some cases E() is called more than
once. Now instead of setting the variable `h` to 1 I set it to `l`: it looks
like a 1 yes but it's actually 4.  Does it matter that it's 4? No. The only
thing that matters is that it's a non-zero value. The same applies to `Q` which
I also set to `l`.

* I also use `*y` as a boolean. If you observe that I set x to `*y` (which
itself might make one believe they're related in some form): it used to be just
a 1. However it is only used as a boolean. `*y` as I described as the LINES
variable on invocation of the program. Since I check if it's < 10 before
continuing the game I know that it will always be non-zero. But what if someone
tries LINES=0? In fact it will be ignored: if the terminal is 25 lines and you
specify 0 lines then it'll be 25. Therefore I can use it as a boolean here since
it needs there to be non-zero. Then in order to get the opposite, 0, I can do
`!*y` which I do elsewhere.

- More generally on variable reuse: the compound literals and arrays of the same
data type but which are completely different things means I can use the same
name in different parts and so it's then a matter of determining which
element/offset to use.

- Why do I compare if the original dimensions are >= the current when the idea
is to make sure that they're actually bigger? How does that work? Why not just
check if it's > than the current?

- More confusion with the max x/y dimensions: Going back to max x/y dimensions
and coordinates of the snake; I showed this code before:

                    if (Y < 1 || Y >= y[-2] || X < 2 || X >= *y || y[-2] >= y[-1] || *y >= 1[y])
                    {
                            if (*p && !(*y>=1[y]||y[-2]>=y[-1]))
                            {
                                if (Y<1||Y>=y[-2])
                                    Y = Y<1?y[-2]-1:1;
                                if (X<2||X>=*y)
                                    X = X<2?*y-1:2;
                            }
                            else
                            {
                                /* ... */
                            }
                    }

    I asked if you could honestly figure that out easily. But here's a bit more
    elaboration. I already talked about the negative offsets - and they should
    talk enough themselves - but look at the mess. Even if they weren't negative
    offsets there are a lot of array references (though by a pointer to an
    element in the unnamed array) and comparisons all jumbled together. There's
    more.

    I have the `!` of a `||` to flip the logic: that's not how a normal person
    would write code. Well...not usually, I guess; I have done it in times where
    it seems more appropriate but it's not the way it's usually done (I think?).

    Even so that part is doing more than one thing: Not only is that code making
    sure the max dimensions aren't smaller (from the original) but it also makes
    sure that the wall isn't hit (when it's not allowed) as well as making the
    snake go through to the other side of the wall if the snake is allowed to
    and hits the wall! And even when the snake is allowed to go through walls if
    the screen size has shrunk it will reach the else part.

    It also has the ternary operator to adjust the coordinates of the snake head
    should the snake go through a wall and those also have negative offsets. But
    how can you figure that out just looking at that mess? Unhelpfully the X/Y
    seem to both be compared to `y` but never `x` (that variable is unrelated
    and not even in this part of the code).


- The function `B()` ends with a `goto`. Why? It's also another place where
there's at least one negative offset.

- A note on the many `#define`s in my entry. You say you dislike them:

                    Doing masses of #defines to obscure the source has become 'old'.  We
                    tend to 'see thru' masses of #defines due to our pre-processor tests
                    that we apply.  Simply abusing #defines or -Dfoo=bar won't go as far
                    as a program that is more well rounded in confusion.

    As I have noted though many of these save quite a lot of bytes too. It's
    true that they might aid (but barely) in obfuscation but I think that my
    entry is more rounded in confusion; certainly the other techniques I have
    mentioned include much more than just `#define`s. One of the `#define`s that
    saves a significant number of bytes is of course `J`: I use that twice and
    it would be a huge burden to include it twice!

    At the same time I have removed some `#define`s that have added bytes; I've
    also removed some that saved bytes and in fact I think it makes it more
    obscure if in no other way but making it more difficult to look at (for
    example I might have been able to save bytes by defining for the array
    offsets but I find that it looks much better - which is to say much worse -
    the way I have it now).

- Going back to the curious `static char s[]=Z(; +<>^v);`: there's something
magical about the number 7 isn't there? I do not refer to primes although
certainly one could say that primes have a magic to them. No. I'm instead
referring to another property: bitwise AND. For example consider the following:

                    7 & 0
                    7 & 1
                    7 & 2
                    7 & 3
                    7 & 4
                    7 & 5
                    7 & 6
                    7 & 7

    What is the result of each operation? Quite simply it's the number itself!
    How does this relate to the `s` array though? Let me back up. Is there any
    place in the code that has the number 7 (by itself - 997 doesn't count)? A
    quick check will answer that: no. But here's a curious thing:

                    q X, Y, s[*D+2&(1<<3)-!Q]);

    We KNOW that at this place `Q` is 0 so the `!Q` has to be 1. Now `1 << 3` is 8. Therefore

                    (1 << 3) - !Q == 7

    But what's `*D`? If the snake hasn't moved once yet it's 0; otherwise it's the number
    of the direction the snake is currently facing. Thus

                    *D&(1<<3)-!Q

    ...refers to `*D`. However if I were to have that be the element it wouldn't
    work right: I wanted the semicolon in there but the space was needed to
    reduce the iocccsize down by one (ironic that adding a byte reduces it by
    one but there it is). I could have had it later in the array but this felt
    slightly more confusing: more operators (so precedence) to consider (and in
    fact GCC complains about this but as is clearly demonstrated it's not
    important). By adding a `+2` it adjusts the index to be the correct value in
    order to show the proper index of the char array.

    But how do you know this? You have to know first of all that Q will always
    be 0 at this point (so therefore !Q == 1). You also have to understand that
    in the range N = 0..7 the value of `N & 7` is `N` (which might not be
    something everyone realises). Obviously you need to know that (1 << 3) is 8
    in order to get the final `*D & 7`.

    You furthermore need to know that `*D` will always be in the range `0..4`
    which means that `*D & 7` will always be in the range `0..4` (If I were to
    have added a `& 7` to the end it'd still be the correct value!  But the use
    of bytes couldn't be justified there.) Finally adding 2 will get the correct
    value of the array index. After all that it will print the correct character
    for the head!

    But there's another trick here: there's never a direct assignment to `*D`:
    `D` is set to `1 + V` and `*D` is never touched directly: it's all through
    `1[V]`.  The references to directions i.e. `KEY_LEFT` etc. and also the
    switch() to see how to modify X/Y are all done through the `V` pointer. But
    then what is `V` anyway? It's `U + 1`; and `U` happens to be `y + 2`. But
    `y` happens to be `j + 3`.  Of course `j` is a pointer to the first element
    of the compound literal! So there are quite a lot of levels of indirection
    in this part alone (not to mention other places)!


# Obfuscation in prog.3.c and prog.3-j.c

There are a few differences in this version that are worth noting. First of all
is a define that's in the compiler invocation Makefile is in the source file
itself. Second are the following obfuscation techniques. To simplify integrating
the explanations I have simply yanked and pasted them below:

- Variable reuse in ways that might not be so intuitive. For example in the
function E() there's a variable that keeps track of whether or not it's been
called; that variable is `h` and it says whether to call `endwin()` or not as in
some cases E() is called more than once. Now instead of setting the variable `h`
to 1 I set it to `*y`. Now as you can see `*y` starts as a NULL pointer; this is
set to the compound literal `j` + 3. This in turn is what LINES is (number of
lines). So `y = j + 3;` and `j` I discuss elsewhere. But what if LINES is set to
0? LINES being set to 0 sets it to the terminal max size but in any event I test
for values < 10 and if either LINES or COLUMNS is < 10 then E() is called.
However E() always returns 1 and since this is in main() and it's an error I
simply return E() and thus it's only called once. Similarly for `Q` I set it to
`l`. But then..what is `l`?

- In fact `l` is assigned a value 4 via a compound literal. It's declared at the
top of the code and then in main() assigned like: `l = ++(int) { 3 } ;` which
equates to 4. I think that's pretty cool!

- What is this? `for(I=0; A&&I<A-(A-A||A); ++I)`. In fact the `A-(A-A||A)` is
equivalent to `A-1`: `A` here is always > 0 so `A-A` is 0; however because `A`
is non-zero the expression `A-A||A` is equivalent to `0 || A` and since A is
non-zero we know that the value is `1` and thus it's `A - 1`! I quite like this
technique: it doesn't make sense at first glance and it probably remains elusive
until you look at it more thoroughly. It compares that `I < A - 1` but the `1`
is calculated by subtracting from `A` the value of subtracting `A` from itself
`|| A` and `A` is always non-zero (as the condition says) which means it's
`A - 1`!

There might be more things that differ but those are the significant ones.



Of course none of the above is so easy to see without a beautifier. Why did I
choose the format I did? Well it came about in a sequence of possible layouts. I
tried first to make it look like the game might itself but the trouble with that
is it's too random. Then I thought maybe I could spell out the words SNAKE 2020
or IOCCC 2020 or something like that. But these were proving to be a problem for
me; what I was seeing on the screen just wasn't looking right in my head.

At that point I just started playing with different patterns and I quite like
what it's turned out to be. I don't know what I would call it but one could look
at it and think of columns holding up a structure. There's also a symmetry to it
and almost certainly that's what is most attractive about it to me for I love
symmetry.

Some final notes on the layout I'd like to point out. First there are 53 lines
counting blank lines. Second is that if you count the number of lines (of code)
in each 'block' they should all be a prime (except the two blocks of 1, I
guess). Third is that I tried to make sure that each column of the code (not
counting the preprocessor - see below on that) start and stop at the same
position (as in column in the row/column kind) on each row. Below I show the
start and end column of each horizontal block. The `#undef` in the middle should
be centred based on its length and the 120 columns for total. The preprocessor
directives should also be centred in that way (that was my goal anyway).

The following were intentional:

*   53 lines.
*   The number of lines per vertical block (3, 5, 3, 11, 7, 1, 1, 5, 7).
*   Number of horizontal blocks (5)
*   Number of vertical blocks (9)
*   iocccsize 2053.

The symmetry was even more important to my mind; observe that each vertical
block (or column) starts and ends on the same column (or at least that was my
goal; I think I did it but maybe I missed one here and/or there):

*   Vertical column #1:  5,   22
*   Vertical column #2:  25,  41
*   Vertical column #3:  49,  64
*   Vertical column #4:  73,  90
*   Vertical column #5:  97, 120

Furthermore based on the length of each C preprocessor directive (the
`#define`s, the `#includes`, the `#undef`) I have attempted to centre them in
the file based on the 120 columns total. I believe I have succeeded in that
though again maybe I have an off by one or two here and/or there.

Most of the primes above were intentional.


<div id="skinning">
# <a href="#toc">Skinning the snake (i.e. decreasing the iocccsize)</a>
</div>

This happened in a number of ways and I have already documented some in other
parts. Now there are a number of reasons to do this: amongst them to make it
possible to obfuscate (plus a more unique layout) but also to add more features.

Interestingly some of the obfuscation saved bytes; others of course added bytes.
For example token pasting saved a few bytes; on the other hand the combining
`if`s to the complicated one above added 9 bytes: but another one saved a byte.
I have done this more than once so it's entirely possible there are others I am
forgetting.

Obviously a more significant one is `#define q mvprintw`: this saved a total of
47 bytes! This was however done towards the end (or so I thought it was the end;
it was anything but) when I started looking at obfuscation rather than adding
features. But then because of this I looked at adding more features!

Another thing that reduced a lot of bytes - 34 to be exact - is using the
`mvvline()` and `mvhline()` ncurses functions rather than use three for loops to
draw the walls.

Much later on I made it so that the `E()` function returns 1; this was a clever
way to have what I already did have - return 1 if there's an error (i.e. memory
error or curses error or screen too small) but otherwise return 0 without having
to have a separate int and I could get rid of two `{}` pairs as well as add
another use for the `E()` function: it calls endwin() exactly once (even though
when there isn't an error condition it can be called more than once) as well as
printing the final score - or else an error. And now it also allows for printing
an error and returning from main() at the same time! This also means that by
returning `E()` I am returning 1 but if the end of main() is reached 0 is
returned. In either case curses is ended.

One of these optimisations saved four bytes simply by taking advantage of the
value of a loop iterator after the loop. The loop is:

``` <!---c-->
    for (I = 0; A && I < A - 1; ++I)
```

However after the loop I had this:

``` <!---c-->
    A > 1 && q(n[A - 1],e[A - 1], 'o');
```

When I was considering moving that line to before the loop it occurred to me
that as long as `A > 0` then `A - 1 == I` after the loop. I still had to check
for `A > 1` but I could refer to just `I` instead of `A - 1`!

There were quite a few other things besides these and these gains were useful to
add additional features and also to add proper error reporting (when `calloc()`
failed I called `abort()` and before that if initialising ncurses failed I also
called `abort()` and did not report any errors in either event but I do now).


<div id="size">
# <a href="#toc">A few more interesting size optimisations</a>
</div>

As I was getting to the end of obfuscation (wrt size available - and it was
getting pretty obfuscated too - the majority of the techniques were already in
place at this point) I was looking at the code to see if I could figure out how
to save even more bytes. Here are some that I found interesting ways to go about
the problem.

First, the function that turns on colours looked like:

``` <!---c-->
    if (h) attron(m(PAIR(L)));
    else attroff(m(PAIR(L)));
```

But I thought is that else actually needed? If I were to switch the order so
that the `attroff()` is called first then I could just do an `if (h)` -
therefore getting rid of the `else`! But then I thought why not do what I've
done elsewhere? I had:

``` <!---c-->
    attroff(m(PAIR(L)));
    if (h) attron(m(PAIR(L)));
```

But I then saved an extra byte by making it:

``` <!---c-->
    attroff(m(PAIR(L)));
    h && attron(m(PAIR(L)));
```

That saved two bytes.

Second let's look at the `B()` function: there were two things I thought of that
would save some bytes (I no longer know how many but a few at least possibly six
or even more). I had the following code:

``` <!---c-->
    if (V && U && o) { S(N); b(1); }
```

This made sure that only if the snake has caught a bug should it grow by the
growth size and increase the bug count. But was checking for the `V` or `U`
necessary? I gave it a look over and it occurred to me: the only time `B()` is
called with `1` (thus `o` is 1 so the if is true) was if the bug actually is
caught. That means I could remove the `V && U &&` part of the if! Thus it became
instead:

``` <!---c-->
    if (o) { S(N); b(1); }
```

Then this

``` <!---c-->
    !o && V && U && q U,V,' ');
```

...is to make sure to only clear the spot the bug is (or was) at if
the bug was NOT eaten. Why not eaten? Because if it was eaten it means the
snake's head will be there!

But why did I check for the bug having coordinates? Because I thought that if
the bug has coordinates obviously the function has been called before which
means that we do clear (write a space) over a place the bug was actually at. But
I thought could there maybe be another way of verifying if the game has started
yet?

Before I ask that question I'll point out this: is there a reason it has to be
checked? Yes because right after this line new coordinates are found. But
unfortunately the snake has to be placed first since the bug cannot be placed
where the snake already is. So if I had to make sure the game had started (the
snake has moved at least once) what could I check? In fact that means the
direction is not 0! So I could just replace it with:

``` <!---c-->
    !o && D && q *U,*V,' ');
```

That reduced the count further. But then I wondered if even that much is needed.
The condition is that the bug has evaded which means the snake has moved already
(so game started). What calls to this function happen before the game starts
though? The original placement of the bug. Well if the above check makes sure
that the bug isn't where the snake is at it means that the snake has already
been placed, right? Going further the snake always starts out at the centre (or
rather the close as possible - rounding maybe an issue depending on the max
y/x): in other words not at 0, 0. This means that the only thing I should have
to check for is that `!o`: because after this call before the game even starts
the score line is updated: so the empty space will be overwritten anyway. And if
the score line is made an empty string it doesn't matter because it'll appear as
all spaces anyway. Thus I could save another three bytes by changing it to:

``` <!---c-->
    !o  && q *U,*V,' ');
```

Technically it would be a `" "` (see [HACKING.html][]
else for N (not referring to the variable though it might very
well matter here too) movements (i.e.  due to sizes) you will at times (e.g.
after eating a bug) see the snake body char at 0,0. I'm not bothered about that
though because the score line is meant to display something, it squeezes a few
more bytes and having a space is hardly an imposition on usage (and for that
matter having a 'o' at 0,0 isn't either).

[gameplay.html]: gameplay.html
[HACKING.html]: HACKING.html


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
