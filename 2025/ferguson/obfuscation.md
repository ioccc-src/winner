### Obfuscation (or obnubilation)

**IMPORTANT NOTES TO JUDGES**: towards the end of the contest I had to (and
wanted to) make several code changes but also wanted to get this file cleaned up
(and somewhat shortened which I failed at spectacularly, I must admit, if
nothing else but I did try) so it's quite possible code does not match this file
or the index.html. The code changes were not only a bug fix (or two bugs and
then a fix on one of those fixes) but formatting changes and ironically more
obfuscation. I also was able to shrink the size down some when doing this
(interestingly removing code improved the obfuscation in one part - I'll get to
that later). I did try and keep this updated but it proved overwhelming too.
Thanks for understanding! But now let's talk about obfuscation.

<hr>

In the case of an antipodal mapper, and even more so for [earth.ppm](earth.ppm)
(instead of [noclouds.ppm](noclouds.ppm)), this is not so much about obfuscation
as obnubilation: although technically that would be the same thing. Still in the
world, and oceans are a great example (as in the oceans are very stormy), we
would have to say there is a lot of obnubilation, at least in the sense of cloud
covering. But the code also has a lot of this as you'll see.

Regardless of what you call this, this file details what I have done in
obfuscation in this code, including misleading comments in really amusing ways.
I doubt I'll cover everything, unlike hopefully the clouds over your eyes when
you look at the code. I did talk about a lot though: too much I shouldn't
wonder.

First a tip that goes to the judges and anyone else who might end up seeing this
(in other words after it wins ... or else if it wins :-) ), if they want to see
just how twisted this code is: I **HIGHLY RECOMMEND** you look at
[debug.c](debug.c)'s output: but make sure to use the in.ppm out.ppm format as
that will show more output as the code does much more then. That does not mean
the other form is not useless but it's not nearly as useful, unless you just
want to see how the table starts out (in which case you don't have to provide
any arg although after showing the table it'll show the usage message: a strange
order perhaps but I wanted the table to be viewable in every invocation).

This tool takes one option:

- `d`: debug output. This matters in the `show_tbl()` function and nowhere else;
if it's not 0 then it shows the table (`S[][7]`) throughout execution so you can
see how it changes); otherwise it only shows it IF the `table` is non-zero AND
the count is 0 (i.e. only show the initial value).

It is long but it's necessary so you can truly appreciate just how twisted this
code is. As I have in the Makefile you can use it with something like:

``` <!---sh-->
    make debug && ./debug 0 0 earth.ppm out.ppm >dbg.log
```

I also recommend that you do:

``` <!---sh-->
    ./debug 0 0 earth.ppm foo.ppm |grep 'm('|sort -t: | less # or else direct to a file
```

The second command, the pipeline, will show you how things changed from each
call to `m()` which is where a lot of the horrors lie. I must admit that when I
did this even I am appalled at what I have done. That's a good sign I think but
you'll have to try it to see what I mean!

If you wanted to see just the tables you could do something like...

``` <!---sh-->
    ./debug -d 0 0 earth.ppm foo2.ppm |grep -E 'table in|^S\[1[3-6].*\]'|less
```

The reason I limit it to the last 4 rows in the table output per call is those
are the rows that might change.

Anyway the debug output might help you when looking at this file and the code.
On the other hand it might be so overwhelming that it will make it harder to
parse: but in either case I hope the judges appreciate the effort I put into
this as this did take time and patience not to mention a lot of effort to do. I
believe it'll help them see just what I mean by table 'abuse' not being typical,
which I will get to later on. Actually it's probably NOT major abuse but it is
still cleverly used: depending on the definition of abuse of course :-)

It is a very long file! In fact in my system with that command (with `-d` at
least) I got a 2.1MB file, much too big to include in my submission.

As you'll see the variables and expressions are rather crazy and they constantly
are changing and yet that's not even close to the full horrors. Yes there might
be some duplicate output but I am not sure of that; and yes it's possible there
are some expressions that are missing but when you look at it and
[prog.c](prog.c) you'll definitely see how that could happen.

I also hope that this will help the judges in making up their mind in my favour
as this really shows how things were designed in ways that no normal code should
be and no code should aspire to do let alone even contemplate.

The code is horrible to trace and in ways that make it hard to follow even if
you do understand it some.

The coordinates related code is cleverly done but so is most if not all the
code; and looking at the debug output of [debug.c](debug.c) will I think help
everyone truly see just what I mean by this.

A bit more about the output format before I get into the rest of the
obfuscation.

The first part of the output shows the value of each array cell which should
also be helpful but probably not that helpful because it's a lot of numbers to
keep track of and they can change indirectly (in ways that I believe will not be
easy to keep track of, though as for the table values changing it seems like
that will be only the last four rows, which are not necessarily coordinates:
they might be but I no longer remember and some of them are changed and some are
not).

Worse for you is that often (if not usually) it's based on variables and also
cells that aren't always obvious values (e.g. they might change or they might be
from a side-effect or there might be some pointer indirection or they might be
dynamically selected from different calls or there might even be a combination
of these and other things). Or so it seems? See below.

But it's so much worse than that which you'll see if you look at the output (or
at least a part of it! I guess most will not want to look at the full thing and
they might even give up: exactly as I should like it but even if you don't there
is no doubt in my mind that it's horrifying what I have done), read the prog.c
or the remarks here.

An important point: coordinates in the first 14 rows control HOW to draw a pixel
when necessary but also it seems like it's used to tell the program WHEN to draw
a pixel (although I think that one is harder to verify it does appear this way).
This does not mean that's their only use though. Some cells are used in other
ways too, even in the first 14 rows.

The first 14 rows (minus the last column I think but that's still important to
have, though you might question that statement: even so there is an easter egg
in there if nothing else but in fact iirc I do make use of the last column) stay
the same value despite being used but as [debug.c](debug.c) can show you some of
the values in the other rows can change. But it's not so easy because only some
of them change.

Actually I am not 100% sure of this. It is not clear to me. The debug output
suggests one thing but it still LOOKS like it might be modifying others. However
I think perhaps not because of:

``` <!---c-->
    !(*(S+d)[*V]&*V)&&z<2-*(*(S+5)+3);
```

The fact I am no longer sure what to trust must surely be a good sign!

It does involve a few levels of indirection in some cases but one of the
nastiest things about that is that annoying `d` variable that I have done
devious things with, plus the fact that some of the values are derived in rather
sneaky ways, not to mention the fact that the cells are dynamically selected. In
fact the first part of the above loop:

``` <!---c-->
    V = &S[u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]
```

...and remember that `u` (which is used in multiple ways and also modified
across calls to `m()`) is not the same in every call. In fact the very first
time it's called:

``` <!---c-->
    if (m (lo,tr, (J=u,H=d +4,I=J -H,D =* (S +u-1)+1,d  -= *(*(S+7)+ 6),L))||b^j*2)X;
```

...which means that for `J` you have to get the initial value of `u`. But
immediately:

- `H` is set to `d+4` (and remember that `d` is not yet 0!);
- `I` is then set to `J - H` (so I guess 15-3 or 12?);
- `D` is set to whatever `* (S +u-1)+1` evaluates to (and notice how it's using
`u` here too); then
- `d` is updated to no longer be -1 (but it's about to change rapidly, maybe
[you'll see what I mean somewhere in this file], and with misleading comments)
before finally passing in the real variable which is `L`. And what is `L`? Well
that depends on the latitude given to the program!

Then when the function `m()` is entered after all of that you have the above:

``` <!---c-->
    V = &S[u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]
```

So presumably (meaning YOU have to trace this) the first part of `S` that `V` is
pointed to is `S[u]` (so I guess `S[15]`) but the column is ugly to say the
least: `[(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]` which sets `z` to point to
`z=(*(S+4))[*(*(S+3)+1)]` and then uses `S[t][B]`: but what is `t` and what is
`B`?!

As you'll see somewhere in this file `t` is set to 6 in a weird place and as for
`B` it is CURRENTLY 0. So it MIGHT be that `V` is pointed to `&S[15][S[t][B]]`
and I haven't the foggiest notion of what that value is! But then after that it
does what I already showed:

``` <!---c-->
    !(*(S+d)[*V]&*V)&&z<2-*(*(S+5)+3); ++z
```

So it already uses `*V` as both a cell selector AND as an ANDed value (on
itself?). The check is that `&&z<2-*(*(S+5)+3)` and only on the increment step
it does `++z` which was set during initial assignment of `V`! Only after this is
the next horrible parts of the function.

As you can imagine it is NOT easy to see what is done and it is WISE to question
if everything in [prog.c](prog.c) is in [debug.c](debug.c): almost certainly
there are missing things. That alone should tell you a lot.

As you can see there are a few levels of indirection but that's not really the
problem: it's how they're selected.  Plus a whole host of other things of
course.

The first purpose of the table though is a map for the arrows (in a funny way
because the arrows in it are used to figure out how to draw arrows!). I believe
the table also HELPS figure out WHEN to draw arrows, though based on other
things as well.

The bitwise ops on the table are actually necessary because I interleaved data
in two ways so that there is no pattern and also to control whether or not to
call `fscanf()`: and perhaps other ways I cannot think of. I provided some other
C files which I'll get to soon; they are useful to see just how messed up this
code became and one of them is instructional.

Mutation probably is the wrong word for the last rows (and maybe other cells:
not sure now) but I use that word a fair amount. Regardless some cells are
modified but the code carefully controls which ones can be modified and which
ones cannot. There is no corruption.

Again one of the things with the tables is HOW cells are accessed. It's not a
simple number (it might be in some cases but in most cases I think not). It's
actually quite dynamic and yet it still does the right thing. In other words
even though it dynamically selects the cells it still does what it needs to do.
Another use of the table that is devious is it is used as a gatekeeper to
fscanf(): to prevent it from being run except when needed.

And as you just hopefully noticed does the right thing is not just drawing
arrows. It even controls OTHER code.

I get to this later but it IS amusing that I can actually comment out one of the
calls to `m()` with the same results. The question you have to figure out though
is: is it the full call commented out or is there something else? The hilarious
thing is although `t` is necessary for the selection of the cells, in those two
calls `t` is different: yet remarkably it does NOT render three arrows. How is
this possible? What does the function call actually do? Are there any side
effects that are necessary?

Yes there actually ARE **required** side effects but that still does NOT explain
how `t` can be different and yet it does the right thing. And no I have NO clue
how this works any more! I remember adding the extra call but I could have sworn
that this was before all this other screwy table access.

...and sorry if I say anything like the above later on that is wrong (or vice
versa I suppose). I realised some things late in the contest, on 12 March 2026
in fact, and I wanted to note them in case they were missed as I think this
program has real potential and it's quite beautiful in output (and it's about
time an antipodal program wins the IOCCC I think, all the more when, as you'll
learn, it modifies PPM images without a library but manipulating a raw `unsigned
char *` with some really sneaky things being done, plus a table with real life
coordinates (that the code was programmed to work with).

The multipurpose table does quite a lot when in truth I could have got away with
just using it for the arrows. But that is too simple for the contest. What's
more is how could a table/map/array that tell the program how to draw arrows (on
a map if that's the image but still coordinates on an equirectangular image) NOT
have actual coordinates? That is unthinkable.

I will return to the table more a bit later. I will say though that looks WILL
belie a lot of the code and some hilarious code will make it worse!

Now a bit more about [debug.c](debug.c).

Before the first call to `m()` I call a function (not in prog.c) called
`show_tbl()` that prints the table. After each call to `m()` I call it another
time. It is also called in `m()` itself in a place that one of the cells is
modified. You can see how it changes (or in many if not most cases does not
change). The question is would you be able to determine this without the tool?

I would also recommend that you look at the algorithm in [arrows.c](arrows.c)
and run it, so you can compare just how messed up the arrow drawing routine is
(even without the added part that I directly manipulate an `unsigned char *`
instead of just printing text). You can run it:

``` <!---sh-->
    make arrows && ./arrows
```

This was when the table only had data for the arrows and only had ones and zeros
and the data was not interleaved yet either (two ways I did that).

You might also want to look at [unformatted.c](unformatted.c) to see what it
looks like before it was formatted into the shape of our Earth. I hope I got the
last minute bug fixes in [unformatted.c](unformatted.c) and [debug.c](debug.c)
but the ones I am thinking of were only when the values were out of range.

Finally you might enjoy [small.c](small.c) which was before obfuscation and with
much smaller arrows (this can help you appreciate why scaling is necessary but
also how it can affect placement: especially appreciate it if your vision is
absolute rubbish like mine but even so).

Also notice how there was only one command line syntax and the input and output
files came first. It also did not do wraparound on invalid coordinates! There
was no floating point.

That file will show you how it was simple to read to where it is now. I did have
to change variable names in it (due to the added macros - it hard coded colours
and I used names that were in the small.c in the Makefile for customisation) but
everything else was left the same, bugs and everything (okay I changed the
colour from magenta to green so you can compare it more easily but other than
that). Hopefully you'll appreciate this and prog.c all the more, including how
devilish it became.

Funny fact: one beautifier moves the `/*R*/` comment far away from where it
actually is. I cannot explain this.

And with that out of the way I will talk about the obfuscation details. Be
prepared my friends!

First: yes this is pointer heavy, at least to an extent and in some ways, and
different kinds of pointers.

Part of that is required though and the most significant parts of the code, the
image manipulation itself, that makes for special obfuscation (and it makes it
more
[arcane](https://magicsystems.fandom.com/wiki/Arcane_Magic_&lpar;Dungeons_%26_Dragons&rpar;)
too which I'll get to soon). More will be brought up later.

But it's also because the table that's required is obviously prime for
pointers (`long *`s).

Nonetheless there are many other things I do and I use the table in many
different ways so there certainly are a lot of different tricks: it's not just
pointers and not just the same trick with pointers, even though there are a lot
of pointers being used. But this is also required as I will now discuss (later I
talk much more about the table).

Perhaps one of the most significant things is that although this manipulates PPM
images it does not use libnetpbm. In fact it uses NO image library at all! This
is rarer because there is a library for you that does everything. This is
wasteful.

As you know the C library does not have a graphics API and it was invented long
before PPM images were even invented. This is already a very strong thing for my
obfuscation.

In any case this is the most important pointer use of course: I read the data
into an `unsigned char *` (that other one used a `char []` of a fixed size but I
need it to be dynamically allocated) and directly manipulate it before writing
it back to disk in the specified file. But the pointer things I'm doing, they're
not as common tricks I think: though that does not mean they are never done.
Obviously I do not mean basic pointer things.

And obviously I cannot conceal P6 as I have to validate the image header.
Happily nothing else in the header has to be revealed, at least by name. I did
discuss how my program is quite robust in my ['limitations'
remarks](index.html#limitations) and why I can only support P6 with maxval <=
255 so I won't get into that here.

I can't imagine the judges would want another format, and some are obviously
wrong (B&W is wrong for the Blue Marble Next Generation Map though it could in
theory be fun it would also be a lot of extra work and with the way I designed
the obfuscation it might be nigh impossible to do without defenestrating my
computer) but if this wins and they want me to try and look into another format
I'll see if I can. But as it is I repeatedly had to shave the size down of my
submission directory, meaning I was not able to include all the images at the
dimensions I wanted (and some were left out).

But the P6 magic number does not reveal how anything is done so this does not
matter.

But WHY indeed have a LIBRARY to manipulate the image to draw arrows on it in
different colours (it might not even be possible to do what I did with the
library, certainly not easily and certainly it would be much more obese though
that's just a guess)? I am not even sure if the arrows would look the same (and
they kind of have an old-school look don't they?) and certainly it would take
much obfuscation away! It's also more portable doing it my way.

I've done the far more
[arcane](https://magicsystems.fandom.com/wiki/Arcane_Magic_&lpar;Dungeons_%26_Dragons&rpar;)
thing: read in the width and height (in horrible ways which you'll learn about
in a bit), allocate an `unsigned char *` (checking for NULL in a hilarious way),
reading the data in (also in a hilarious way) and directly manipulate the RGB
values in the array, but going backwards in memory (yes backwards), filling it
from blue, green, red, even though it will end up in RGB as needed, though funny
looking comments (and there are even more devastating comments with dares)
suggesting it's red, green and then blue. PPM images do not have alpha channels,
happily.

After all the manipulation I write it back to the file specified, assuming it
can be opened for writing of course. But even so it'll be hard to keep track of
data.

Raw data manipulation itself is more obfuscatory than using a library as using a
library is a dead giveaway in what you're manipulating. Look at this page on the
PPM format:
<https://netpbm.sourceforge.net/doc/ppm.html>.

Anyway you can easily see why most people opt for a library but that is costly
in bytes and FAR too **OBVIOUS** (even the way I have used the pointers is less
obvious but I would say the many uses of the table, and how it works, is more
annoying to understand)!

But as noted above the only POSSIBLE giveaways (at least if someone knows the
format is the usage message and, for those who know the file format, the P6);
and the only reasons I am giving the usage message is because there is more than
one command line invocation and in case <del>someone</del> the judges :-)
<del>doesn't</del> don't feed it a PPM image but rather another kind of image.

This would likely be an error unless they're trying to create an invalid
image file but then there would still be an error or at best a bogus output if
they managed to make a file that is read okay, though why they would do this is
beyond me. Plus obfuscated programs should still have a nice interface. It is
pointless to try feeding it a non-PPM file or one of the wrong format (or
dimensions).

If there is a header error or read or write error I report it (and
header error includes comments - see my [comments.md](comments.md) file for how
this is precedented in the contest) and do not proceed.

Someone can still feed it non-PPM files but they'll get an error: unless they're
manipulating things even further but if they're doing that then there's nothing
I can do now is there?

The simpler syntax calculates the antipodal coordinates of the input
coordinates; the other as you know draws arrows on the equirectangular (also
checked) image, up and down depending on if it's the antipode or starting
location.

And on bogus input I also sanitise coordinates so that if the judges decide to
give it invalid coordinates (i.e. out of range) it will wrap (or it should -
tests seem to show it's fine but it's much better than what it was, clamping
it, which is also incorrect it seems). It unfortunately uses libm. I tried to
get it to not do that but it was buggy. Plus it was too slow anyway.

And I use `strtod()` so that will avoid problems with `atof()` although
depending on what is fed to the program, if it's such a high value, it'll be
invalid input but that's the user's fault. Even so it should work (mostly if not
entirely?). Although it should in theory wrap fine please be reasonable in case:
in other words it should work in range but if you find an out of range value
that does not work right you KNOW you deserve it if the map leads you into the
wrong place.

Now as for the library use being more obvious here's an example set up of netpbm
to read in a PAM image (a PAM image generalises PBM, PGM and PPM images and
would be even bigger I guess, esp as it also has alpha channels unlike PPM
images:

``` <!---c-->
    #include <pam.h>

    struct pam inpam, outpam;
    unsigned int row;

    /* obviously they forgot int main(int argc, char **argv) ... */

    pnm_init(&argc, argv);

    pnm_readpaminit(stdin, &inpam, PAM_STRUCT_SIZE(tuple_type));

    outpam = inpam; outpam.file = stdout;

    /* more obvious code below */
```

But look at the code above: there is a struct name `pam` and there are function
names directly suggesting what the code is doing. I have removed that problem
entirely. I don't have any structs either. I use floating point (double), an
array of many different kinds of fun, abusive uses (later in this file I'll get
to the details of some of them) and much more subtle things.

This is way cleverer too and also much more simple (yet less obvious: I mean the
code is simpler in that it doesn't have all the overhead and set up of a library
but far less simple in other ways, obviously, especially in understanding).

Image libraries have been used in the contest before but that makes the code
more obvious: even if not obvious (obviously not since they won the IOCCC!). I
know of at least one entry that processed PPM images but it is [more limited
than what I allow](index.html#akari), brilliant though it is (and it is quite
brilliant indeed).

The array for up and down arrows is in a single multidimensional array. It also
does other things now though it didn't use to as you know from
[arrows.c](arrows.c).

In case I didn't say: it used to be multiple arrays and there was no
interleaving at first when I made it one array. I interleaved it and then did it
again so it's shifted twice. But there is more to that array as you'll learn.

Not terribly tricky by itself to have a single multidimensional array (instead
of multiple single dimensional arrays) but I have done some horrible things (the
pointer arithmetic is one thing and it is done in a funny way which I'll get to
later but there is much more to it than that).

The values in the array, and the code using it, were also carefully selected so
that nothing breaks (unless you mess with the code in which case it's possible
it'll be very broken, and that is very easy to do because of how it's
constructed: not easy to update or mess with).

And yet it has real coordinates in the world (and maybe in a book which I
brought up elsewhere :-) ); only a few rows (the last ones) are not coordinates
and that's because the code was already heavily obfuscated and I had to contend
with what requirements I imposed (I was able to select numbers but I also had no
other significant coordinates to consider anyway, not really, at least not that
I'm aware of, but again it would break code if they weren't correct - but more
on that later, including how I was able to at times change a cell when I made a
code change: happy coincidences).

What's trickier here is that the first 14 rows (two groups, seven each) are
interleaved in two ways: first by column and then **separately** by row. In
other words I did this in two commits on my server. That's an example that is
not pointer abuse although as it's accessing the array (and the pixels are
modified directly in the data in an `unsigned char *`) obviously it requires
pointer use.

In the case of columns the last column I cannot access but it might be important
in other ways, even without the easter egg. Nonetheless there is no strictly
technical need to ACCESS that column. Iirc the column is still needed however,
but for a more subtle thing.

Thus I have to do what amounts to `x < 6` rather than `x < 7`; in the case of
the rows both row 0 and row 6 have non-zeros so I have to actually do `y < 7`. I
don't think these cells change but if they do it's carefully controlled. The
debug output suggests that these cells are not changed so I guess they're not -
but they're still used in multiple ways (some of the non-zero ones and some of
the zero ones as well).

If you don't understand this then maybe the code will help you see what is
happening though perhaps it won't. Probably it won't though. These things are
concealed inside the array itself; if you think the `x < 6` or `y < 7` (and
those variables are not used in this way at all) is going to be easy to find
you're going to be sorely disappointed.

As you'll see I derive by MANY ways different values and I have removed entirely
some numbers that are important such as 3 and 5 and 9 (that does not mean there
are no `3`s, `5`s or `9`s but having some is misdirection and in some cases
they're part of expressions to get other numbers, or maybe even that number
itself - that certainly happened at one point if not still, which I think is the
case, also as misdirection, assuming you can even trace the cell right). That's
another way the table is different: it has some base values but it might only be
part of an expression and some of those expressions involve dynamic values.

There are also some misleading comments with some real sneakiness that don't
help matters. This involves other things so I'll delay that for now.

The calculations to figure out the indexing are one thing (actually they're more
than one thing). But the other part of it is there is no real pattern that can
be found, to see arrows. It was dead simple to see when I had just 0s and 1s, at
least until I interleaved the columns and then later rows (again if you don't
understand this, or even if you do, check [arrows.c](arrows.c) and compare it
with what I have - the table then is simple and only had the arrow
'coordinates'). At the time the arrows were also [smaller](small.c), though that
is done by scaling in the image data (iirc that's how I did it - the 14/7 still
is in the table so I guess that). That code will help you appreciate why I had
to scale it to be bigger and why the arrows MUST be approximate locations (the
printed coordinates are another question).

Now it has real coordinates (with the code carefully designed so said real life
coordinates would work) and the index calculation shouldn't be easy to determine
either.

It might be harder to see without that and the way I formatted it also makes it
less likely but after interleaving the 'arrays' (single array, multiple
locations) twice (not once) there is no pattern. Some beautifiers will help with
the array definition but it won't help much with how it's used. Actually in many
cases, especially when I use other cells to obtain the correct cell in the same
(only) array, often at DYNAMIC STARTING points (a less common thing) which is
made worse when I sometimes use a cell value indirectly rather than directly
(possibly WITH the dynamic selection but not sure yet still fairly likely), the
only way you'll likely be able to determine the value (certainly easily) is
debug output (whether in a debugger or `printf()` - and possibly
[debug.c](debug.c) though it depends on what you're after and what I included).

But as for that you can't just blindly add `printf()` calls (the comma operator
is heavily abused as it makes it more formidable, more than you might think or
have seen before) and just because a cell starts out with a value does not mean
it never changes. Some pointers point into different locations at different
times even in the same function, depending on other variables (that are not
passed into the function and possibly some that are though I don't know).

Actually yes some are passed into the function, namely `s` which is used in a
funny way (will get to it later). But when passing that parameter in the same
'parameter' other values are modified as well: which might just be critical
(certainly the function is 'passed' values that are used in the code but as
parameters to the function).

See [debug.c](debug.c)'s output and again that might not even be complete.

As I said the non-zero items are deliberately not just 1 (some are but not all).
There are multiple things of significance which I briefly mentioned above. The
values all have meaning and just because a cell looks used (besides whether to
draw a pixel and/or how to draw it: how certainly but it appears that it also
helps tell whether to draw an arrow) does not mean it is (as such); and just
because it looks unused (besides whether/how to draw a pixel or not) does not
mean it is unused.

First thing to know is many of them are backwards via `rev(1)` (easier than
reading it backwards manually although I did do it in some cases).

The `S` array is positioned in the file to spell out `GPS` (`G,P,S[][7]` though
as you'll see the source code is in the form of a triangle to match our Earth's
shape (minus the `#include`s and byte-saving `#define`s of course, plus the
first few lines including a comment that dares you to try something, as part of
obfuscation, and another that tells you what the `S` array is: a map of our Flat
Rectangular Earth, obviously, even though it's actually triangular as the code
shows).

The array has coordinates as I said, one of which is an easter egg I talked
about in my remarks and the others I mention specifically (though again they are
backwards, except the last one I added, the actual i.e. non-antipodal
coordinates to the Antipodes Islands) because I want them known (I give hints to
some of the easter eggs somewhere in my [index.html](index.html) file).

Okay actually there are some cells that are not coordinates; I will return to
that.

Here is a table of coordinates of the seven main (main because there is a
question of whether or not there are others and some do say there are others)
continents - or rather their antipodal coordinates. It was my attempt to get it
towards the centre of each but finding the precise coordinates of the centre was
not exactly easy and the source I used did not get it exactly right as I hope
you see (the question of what is the centre is also one people will debate as
even the question of where is the equator has caused people issues as I showed
in my [index.html](index.html) and that's not even considering the fact that it moves over
time, albeit I guess very slowly).

Anyway:

```
    Continent           Antipode (lat lon)
    ---------           -------------------
    Africa                0.0 -160.0
    Antarctica           82.0 -180.0
    Asia                -34.0 -80.0
    Europe              -54.0 -165.0
    North America       -54.0 75.0
    South America        15.0 120.0
    Australia            25.0 -47.0
```

Note however (and this applies to the other coordinates) that the rows that
ended with one or more zeros do not have the zero or zeros as that's wasteful of
bytes. This might also hide the coordinates a bit more but that's actually a
bonus.

There is another thing in the table. I at first had some of the digits of the
25th Mersenne prime number: a number Landon Curt Noll discovered in the 1970s
with a classmate (he also discovered the 26th Mersenne prime I think the
following year). But I found out about the [Antipodes
Island](https://en.wikipedia.org/wiki/Antipodes_Islands).

I had to take out the last four numbers (sorry Landon! I actually earlier on had
many more digits but coordinates had to be added as I trust you'll understand
and even agree with, even if with a tinge of regret) and fix them to be the
coordinates to the Antipodes Islands (but not the antipodes of it: that seems
wrong but FAR MORE IMPORTANTLY is that editing that row in the table takes
special care **or else the program will not work!**, and that includes the final
rows too, those that I added later on in obfuscation).

Actually editing any row could possibly break the code depending on what you
change it to.

Keeping it true I have used floating point by making each part a different
number (since I have `S` as a `long` for specific reasons).

Yes I could have made the table floating point but that would break some
obfuscation (or require casts maybe but if so it would cost more bytes) and
change the gatekeeping to make sure `fscanf()` is only executed at a specific
time (hint: I use bitwise ops on them, for one example of others, and in some
cases it's actually required).

Besides it saves bytes here as I don't have to use `.`: though technically if I
wanted I could just add `.`s in the numbers anyway but that would trigger yet
another warning and my compilers already fell deep into our Hollow Earth, the
poor duckies.

Anyway just like most of the others I have done it backwards, going from last
non-zero cell through the next three. Now it might be that some go from earlier
cells to later cells but with the numbers backwards.

For instance the Antipodes Islands are at -49.68, 178.78 (according to the
source I found at least!) so if you look carefully enough you'll see those
coordinates in the table. As that is significant and to give people an idea I'll
show you how it goes.

If you look at the last (okay not precisely: see below) two rows (not that they
look like that if you look at [prog.c](prog.c)) you should, if you look
carefully enough, see (the `9` and `6` at the last column of each row are part
of an easter egg so ignore those in this case, and sometimes I might have used 9
via the map to get to get 9: I have this memory of that) the following numbers
going backwards: `-49.68, 178.78` are in the array as `78, 178, 68, -49`. That
is what I mean by going backwards in the other coordinates too and how I omit
the decimal points.

Yes sometimes a number is used to get the same number indirectly just to mess
with you.

It made me sad to get rid of the 25th Mersenne prime but I think it would be
sacrilegious to have an antipodal plotter that does not have a reference to the
Antipodes Islands in the code or the coordinates of the continents.

As for the 'last two rows': actually there are three (or maybe four?) rows
beyond the initial 14; those are for obfuscation alone and they require certain
numbers so I did not put coordinates in and I did not put in any other
significant number (well they're significant but not in the same way), though
that was partly because by this point it was already hard to maintain. Actually
as you'll learn (if you haven't already figured out) the coordinates I **did**
use had to be done carefully exactly so the program worked: but these final rows
came later on.

What that means is that although yes the table has values that are referenced
those values are based on real coordinates (well many are) and yet the code is
designed to work with them; if I changed numbers to just any non-zero value it
would break the code (it might work for some but some would break the code).

So how did I manage it when I used real coordinates? Dark Magic!

As I said this required other changes in code due to obfuscation: in other words
even though it mostly is just non-zero values that indicate how to form the
arrows (and possibly to help calculate when to draw them) it does not mean you
can change them to anything, as they do multiple things.

In fact changing some numbers might not only break the code but it might also
crash (I **think** I tested that once before but I cannot guarantee that now).
There actually IS a number, one I dare you to tweak, that can either return a
read error OR cause the program to crash. But others can also cause crashes if
meddled with.

Happily in one case all I had to do was a change a `3` to `2` (have fun locating
that specific one though - I will discuss that later) but that was sheer luck.

I think if any coordinates in the table should not have their antipodes it
should be the Antipodes Islands anyway. Hopefully I got the right coordinates
too. If I got the wrong ones it's probably because our Circular Flat Earth keeps
moving.

But if I used the antipodes of the Antipodes Islands then it would be possible
that other code would break, code that would be harder to fix (and would also
break other obfuscations, and again that's not the only place).

When I talk about `m()` in more detail I will explain what was the problem but
it has to do with the last line in `m()` and particular the sneakiness of `V` as
a gatekeeper to the `fscanf()` (`V` does other things too of course and it's far
worse).

One more special set of coordinates. Somewhere I said the last columns are unused.
The array belies that though. What is the sequence of numbers? Well it's:
`-6,4,8,0,5,7,0,-1,5,6,2,2,6,9`. So what is the significance of that? Well if we
translate it a bit better we get the following coordinates: `-64.80570
-156.22690`.

It is no longer even clear to me if this was reversed in code or not though (and
as I write this I don't want to take the time figuring it out as I want to get
done with this so I can do other things).

Given what it is though this should not matter. If you think it'd be better that
I had them normal for the Antipodes Islands then you don't understand this code
(you might not understand it even if you do think it's fine of course). Besides
that when you figure out this other one it makes much more sense. But I'm not
sure if I did it backwards now either. Whatever way I did it it works well, and
the last column shouldn't be necessary anyway. I think. I no longer know with
100% certainty!

I have actually already noted this (not the Antipodes Islands, the other one)
place but without the coordinates, in the [index.html](index.html) file. It's an
easter egg with the suggestion that it is important but it's only important in
that it's obligatory: namely because antipodes involve entering the Earth's
core, unless you have a way to fly round the globe to precise locations. _Hint:
the words '**Earth's core**' MIGHT be significant_.

I **know** the judges can figure it out and they'll know precisely why I say
it's mandatory (possibly even if I did not mention a strong hint in my remarks).

I also know they'll appreciate it. Because of this I won't say more: lest
someone ends up eating rotten eggs, gets salmonella and tries to blame Axel, his
uncle, their guide or more likely Nemo, only to find out they died a very long
time ago. Or worse, try blaming me. Okay so I just gave more hints.

Nonetheless it IS significant both to naming (in [index.html](index.html) I say more about
naming: this program and the remarks are full of thematic references, jokes,
wordplay etc.) and because why would the table have data if it's not even used?
Well that's to trick the eyes and because it MUST be there. It is an obligation.
There is no other option (at least in a symbolic way?).

And although I have given numbers up as part of the easter egg it's only because
I don't want it to be missed as it is, as said, significant, and right on theme.
It must be there! Happily it fits in the last column too: if it did not I might
have been forced to change things, either adding more rows or columns.

And on that note it's entirely possible I goofed with some coordinates or
they're not in the order I said. But that should be a clue as to how the table
is obfuscated as well (not just the code that uses it but the table itself). I
attempted the coordinates additions after interleaving them btw but IF there is
a mistake then that was quite by accident AND it would not actually matter
(besides that, as I noted elsewhere the fact is the centre is not exact and it's
hard if not impossible to get the exact: plus hard to verify on a map without
coordinates, plus the fact it is necessarily scaled up so it can be seen, the
arrows, and also be on the map if at the edge).

Instead of `w` and `h` for width and height I chose unhelpful names, `b` and `j`,
though I'm not sure which order they were used (earlier on I had chosen `w` and
`h` but swapped meanings). This fact, the swapped `w` and `h` made me remove
some comments in [index.html](index.html) as I was not even sure what I was trying to say (I
revisited it and thank goodness I did! Bugs found and errors in explanations
found as well). I think it's better now though.

There are other unhelpful names of course, mostly single letters. Most names are
single letters because single letters are very often the least helpful and
because it is far cheaper byte wise.

The array does not look used in the traditional way: `(d+s+S)` is how it's
indexed, at least when dealing with arrows data. That might make no sense at all
but that's a good thing. `d` is another topic entirely that I'll get to later
but from all appearance at this point it is 1, except in one case where it looks
like it's -1: assuming the array is even accessed at that point (but if it is
it's still 0 by that point, though if calloc() fails it would change - this is
sneaky and for later).

More specifically it's how which part (segment, not index) of the array is
selected (of course it's indexed in other ways too). It is indexed in a loop
inside another loop like this:

``` <!---c-->
    for ( V =&S[ u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]; !(*(S+d)[*V]&*V)&&z<2-*(*(S+5)+3); ++z)for
    (*V=0; *V<d+*(*(S+7)+3); ++*V)if((d+s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-
    1:*V+1])
    /* followed by two more loops */
```

I'll get to some of that when I talk about `m()` more but if you look at the
code I trust you'll understand how I miss things if I do (which is almost
certain).

Actually the amusing thing is that `d+s+S` does not index into the array
directly. That is it's not `S[s+d]` (or as you'll learn `S[s]`). Rather it is
which row to start out in. That is why doing `S[d+s]` is illegal. When `s` is 0
it will be the 0th row but when it's 7 it's the ... 8th? So how do I get the
arrows to be printed right?

Once you figure this out it's still wrong-looking because it's multiple (though
I only use it as two) arrays in one but how I access it is not what is usually
done (or I don't see it this way often if at all). Well this is not normal code
so maybe that's why. But as said it also holds other data as well, some that is
at a certain point (\*HINT\*!) changed (whether that includes any in the first
14 rows I no longer know. Perhaps the judges will declare this a winner to help
me out here? :-) Or...at least declare it a winner because it's great and it's
also a coordinate thing on a beautiful map of Earth, and I believe no entry in
the past has done anything with antipodes: and it's about time there is one I
think and what better map than the Blue Marble Next Generation?).

Pointer mischief. Here are some of my favourite ideas (every bit adds up). Here
is how it is set up:

``` <!---c-->
    unsigned long b,j,*A=&j,*Q=&b,n;
```

Now `b` and `j` I already told you are width/height (not sure which order now
but I think in that order). So this means that `*Q` is equivalent to `b` and
`*A` is equivalent to `j`. Then there are these macros to save bytes:

``` <!---c-->
    #define T 360
    #define R 180
```

But those pointers make for some funny looking code.

The amount of bytes I write and check for being written look quite different.
Actually as for `fread()` and `fwrite()` I use different pointers by name but
they are actually the same location (and I do something much more horrible with
that).

<div id="lie"></div>
<div id="d"></div>
This is not normal. At different parts of the file, file scope and in main()
there is some really awful looking code with some very awful things I did
(apologies if there are some differences; this comes from a beautified version
but as I said elsewhere you might find [unformatted.c](unformatted.c) more
useful. And yes I made changes since the unformatted.c code that I hope (but do
not guarantee) was put into unformatted.c.

And I hope this is the version that is in prog.c. I believe it is:

``` <!---c-->

    // I DARE YOU TO TWEAK d
    long d = -1;

    unsigned char *c, *e;

    /* in main() */

    c=calloc(1,(F=9,H**Q*j)),x=- (tr +R)
    **Q/T,d=c==e!=d,Y=(lo+R)**Q/T,d=c!=e!=d!=d==2*d,d*=2, y =- (-U +90) *j /R,x =-
    x,Z =(-L+90) *j /R,d=!-!(c!=e)!=d-1!=d+1,  x =-x
    ,Y=-Y,Y=-Y,d=-!-!(c!=e)==d,Y=-Y,d=-d,x=-x,x=-x,d=c==e!=d==!( c ==e)!=d/2,d=d/2;
    /* CHANGE != 1 AND PROVE d IS 1 */ if  (d=(c!=e==!d !=d!=d==1&&e!=c)!=1||/* NOW
    YOU KNOW d IS 1! */fread(c, -*(S[F])-d*3 , b*j,q)^j *j *2)X;
```

Now obviously something is seriously wrong with <del>me</del> you for trying to
understand <del>yourself</del> me :-) There is a lot that's wrong there. Can you
figure it out?

Well first let's talk about those comments. I dared you to try changing the `-1`
at file scope. Did you do it? Did you notice what happened? There are a number
of things that can happen depending on the value you change it to.

Some values can crash the program (0 possibly, -11, -111 amongst others).

Others can result in 'Hollow Earth' (if you're a Hollow Earther you might enjoy
that more).

3 also crashed it this last test I had. 2 did as well. I suppose that some
values might not crash in your system but they're certainly incorrect.

It's unclear to me if you can also get the Flat Earth error but it might be. It
might be only Flat Earth; I really did not test it that much after I confirmed
it worked.

Regardless it is VITAL it remains -1, thus convincing you I am telling the
truth: exactly because I AM - for the time being. There is another truth that
becomes more devastating.

That is the variable `d` but I am not done with it by a long shot. Do you see
how I use it? Or maybe where?  It's used in various places including in `m()`
but let's talk about the `calloc()` NULL check first.

It's in a huge expression (the `;` just helps the eyes a bit more than the `,`
doesn't it? Plus it prevents some unusual things from being done). I'll try
removing the other code so you can see just it but that might be hard to do. If
I succeed this is how it checks for NULL:


``` <!---c-->
    /* CHANGE != 1 AND PROVE d IS 1 */ if  (d=(c!=e==!d
                   !=d!=d==1&&e!=c)!=1||/* NOW YOU KNOW d IS 1! */fread(c, -*(S[F])-d*3 ,
                  b*j,q)^j *j *2)X;
```

but before that it's changed a lot. Here is SOME of it (much more happens!):

``` <!---c-->
    d=c==e!=d,Y=(lo+R)**Q/T,d=c!=e!=d!=d==2*d,d*=2, y =-
    (-U +90) *j /R,x =- x,Z =(-L+90) *j /R,d=!-!(c!=e)!=d-1!=d+1,
```

but again there is A LOT more of the longer expression. It is boolean hell. The key
variable is `d`. Okay so `e` and `c` too but the devastating part, and which is
NOT a pointer, it is `d` (also did you notice that I mess with `x` and `y` there
and other things too when I really shouldn't?).

Now you know it started out as `-1` and you by now know you better not change it
if you want a working program. However by the time that code is reached it has
already changed once. Look at this:

``` <!---c-->
    if (m (lo,tr, (J=u,H=d +4,I=J -H,D =* (S +u-1)+1,d  -= *(*(S+7)+ 6),L))||b^j*2)X;
```

If I am not very much mistake that `-=` actually adds 1 so sets it to 0. It's
true you better not change the `-1` but by the time the check for NULL happens,
which is where the lying really starts, `d` has already changed values, though
you might question whether it has (see `m()` discussion [here](#m)) but even if
you don't question whether it has you'll likely not easily see what it is
changed TO (you might if you beautiful the array but you'll have to carefully
tear it apart - [debug.c](debug.c) might or might not even be of any help).

And that first call to `m()` might appear that `d` is still `-1` which is more
amusing with the `d+s+S`.

But look at all the mutations of `d`. And let's talk about the `if` with it:

``` <!---c-->
    /* CHANGE != 1 AND PROVE d IS 1 */ if  (d=(c!=e==!d
    !=d!=d==1&&e!=c)!=1||/* NOW YOU KNOW d IS 1! */fread(c, -*(S[F])-d*3 ,
    b*j,q)^j *j *2)X;
```

The reason I do `d*3` is because of RGB is three and because the `fwrite()`
writes 3 but it would be hard to determine what `-*(S[F])` is so it's hard to
know if the `-d*3` does anything bad: of course it does not as it's already at
this point 0 but you might not (and likely don't, not yet anyway) know that.

Anyway I want you to try removing `!=1` and also changing the value (the `1` and
also earlier in the file `-1`). Try changing the `!=1` to `!=0` and then another
value that's not 1. Then try changing the original value of -1 to 0. Try 2, 3,
-3, -1, -2, 1.

As you'll see the initial value MUST remain -1 (as I said somewhere depending on
what it's changed to it can result in an error or even crash) but it sure looks
like this other part must be 1. The comment 'NOW YOU KNOW d IS 1!' (after the
comment encouraging you to remove != 1 so you convince yourself of it).

ACTUALLY if `d` is 1 THAT is when `calloc()` returned NULL. In that case we do
NOT want to call `fread()`! In that case the program exits.

Look at the way `d` is changed in misleading ways above and below it.

The fact there is no 'memory allocation error' message but a joke one instead
(let's be honest in most cases it's unlikely an allocation error will occur
anyway) and the fact `e` and `c` are never directly checked for NULL might make
you think there is no NULL pointer check. But try adding after the calloc() the
code `,c=0` (making sure to add another `,` so the rest of it will compile) and
see what happens!

It looks like if `d` is NOT 1 it's an error but it's ACTUALLY the opposite. This
is important for `m()` which I'll get to in a bit.

The comments encourage you to CONVINCE YOURSELF (by experimenting) what is false
and the opposite is true. It is not normal to check a `long` to determine if a
pointer is NULL in a simpler way but the way I have done it is far more insane.
The real crazy part is how `d` is changing, `d` and other things as well.

But this is only part of the lie; `d` is used in `main()` as well with another
comment and it's also used heavily in `m()`.

Notice in `main()` how in calls to `m()` and maybe other functions I've slipped
in assignments (not just `=`) of other variables that are vital for `m()`.

Aside: did you see how I parse args? In some cases I do it direct reference but
in one place I do `g-2` and another I do `--g`.

<div id="m"></div>
Now let's get to `m()` as that's important here too. Whenever it is called `d`
is 0 even though it might seem to be another value, the first time `-1` and the
rest of the times namely 1 as you might or might not have convinced yourself of
(and if you didn't you either didn't try experimenting or else you might be more
stressed out - seek a doctor before you continue, please). The first call you
might have also convinced yourself that `d` will be -1 because if you change the
`d = -1` at the top of the file the code breaks. And where would it break? Is it
in `m()` where it does `d+s+S` or is it somewhere else? You have to determine
that one.

Yes even when it's first called and `d` starts out as -1: in the call to `m()`
the `d` is -1 but by the time `m()` is entered it is 0 (I think I said that
right - it seems likely but I'm revisiting this weeks later).

But the first call to `m()` reads the header of the PPM file. Actually another
call might 'try' but if so it's already at EOF then so it just returns an error
(but it doesn't matter at this point and it'll be closed pretty soon after).

That last part I no longer know for sure: it was at one point not true but I
think it might be now. The debug output suggests it is true though but again it
does not matter.

Something vital happens in `m()` too though, something that prevents a crash
when doing the check for NULL on `c`.

``` <!---c-->
    for ( V =&S[ u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])];
    !(*(S+d)[*V]&*V)&&z<2-*(*(S+5)+3); ++z)for (*V=0; *V<d+*(*(S+7)+3);
    ++*V)if((d+s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-
    1:*V+1])for(M=&S[S[J][d+S[d+*S[*(d+S)[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(*(S+H)+2)][3
    ]],*M=0; *M<5; ++*M)
```

Now notice the `e=c` in a horrible spot. Mainly in heavily nested array access
(well maybe not heavily but it might look like it because of HOW it is done: and
the dynamic values and also `d` only add to confusion). However deep the nest is
I do to an extent use one cell to access another. This (`e=c`) is vital. It can
crash if it's not done - crash in main() of course.

Now the interesting thing is I believe this is for the NULL pointer check. These
are file scope pointers though so why do I need this then? Well if you look back
at how `d` is assigned the right value you can see it looks like not equals
check and also equals check amongst others: but if it's not the same (so still
NULL) then obviously something awful will happen. Later on this assignment will
happen again but it doesn't matter at that point.

The important part here is the `e=c` inside the array access, at least when it
comes to checking for the NULL pointer from `calloc()` and thus when getting the
0 value into `d` that looks more like it has to be `1`. Okay so it's not
important that it goes inside the array access so much that it is done but I do
it this way because it's 'wrong'.

There is a lot more to `main()` in how it mutates variables but as some of that
involves interacting with `m()` I will get into that now as best I can: which is
not going to be perfect. If you look at the code you'll understand this very
well I believe.

`m()` conceals quite a lot of things and it extends things done in `main()`.
In case you missed it the reason `m()` comes after `main()` is because I want
you to convince yourself that `d` is 1 first before you get there. Remember this
code I just shared?

``` <!---c-->
    for ( V =&S[ u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]; !(*(S+d)[*V]&*V)&&z<2-*(*(S+5)+3); ++z)for
    (*V=0; *V<d+*(*(S+7)+3); ++*V)if((d+s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-
    1:*V+1])for(M=&S[S[J][d+S[d+*S[*(d+S)[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(*(S+H)+2)][3
    ]],*M=0; *M<5; ++*M)
```

Notice how `d` is used here in several locations (and later in the function).
The `d+s+S` is funny and I already brought it up. This is funnier if you
convinced yourself that `d` is 1 or the first call -1 (but yet the question is
is that above loop even entered the first time?). But it's not.

In an earlier version I 'scaled' it but I thought why would I draw more
attention to it, more scrutiny? So I removed it. This saved many bytes as an
added bonus, taking the code down to 2000 bytes, which allowed me to play with
the code a bit more, adding to comments some and fixing the wraparound (or I
hope the wraparound) AND the risk of users trying inf or NaN as input (these
latter things were costly, pushing me up to 2090 but actually see below as I'm
lower now).

Still 2090 is not remotely close (but it's actually a bit smaller now, see
below) to the limit which the judges like and I believe they'll especially
appreciate that I went out of my way to use `isnormal()` rather than let a user
specify `[-+]inf` or `[-+]nan` (I set the values to 0 if `!isnormal()` as that
seems reasonable to me: if not a number or if infinite why not make it 0?).

I did something sneaky on 10 March 2026. I changed two or three `!=` to `^`. I
did not want to do this and in most cases I did not (and obviously did not do it
when an operand was a pointer - even though one pointer with a `long` weirdly
worked it's technically undefined) because it would look far less formidable
even if readers (that would be the massive chain messing with `d`: obviously :-) ).

The `!=`s changed to XOR were amusing to me. They were:


``` <!---diff-->
    -  )== *(* ( S + 3 ) + 2 ) - d && 3 !=fscanf(q, "P6 %zu %zu %zu%*c", Q, & j, & n) ||  n   >255);  }
    +  )== *(* ( S + 3 ) + 2 ) - d && 3 ^ fscanf(q, "P6 %zu %zu %zu%*c", Q, & j, & n) ||  n   >255);  }
```

Yes that's right: I XORed 3 with the return value of `fscanf()`: a totally what
the hell move. The reason I am showing the diff (and not just the code) is so
people can see how it transitioned. The reason I did this btw was to save bytes,
nothing else; when I thought of it I had forgotten about fscanf(). When I saw it
I knew it'd be hilarious to change that one too. There is another place that
does `!= 3` and I almost changed it to be `^3` but I thought that would be more
revealing so I kept it at `!=`. Besides that as I get to I wanted to limit
bitwise ops except where necessary (or where `^` is used to save bytes).

A few others are also kind of what the hell but not as much:

``` <!---diff-->
-               *(*(S+7)+ 6),L))||b!=j*2)X; c=calloc(1,(F=9,H**Q*j)),x=- (tr
+             *(*(S+7)+ 6),L))||b^j*2)X; c=calloc(1,(F=9,H**Q*j)),x=- (tr

-         b*j,q)!=j *j *2)X; m(Y=-Y,Z,B=4); m(-x,- y,(--u,t+=F,++B,7)); fclose ( q
+       b*j,q)^j *j *2)X; m(Y=-Y,Z,B=4); m(-x,- y,(--u,t+=F,++B,7)); fclose ( q

-       q, "P6 %zu %zu %zu ",b,j,n) <0||fwrite(e,3,*Q*j,q) !=b * j) l "Hollow Earth"
+     q, "P6 %zu %zu %zu ",b,j,n) <0||fwrite(e,3,*Q*j,q) ^b * j) l "Hollow Earth"

```

Briefly: the change looks rather wrong because how is `b^j * j * 2` equivalent
to `b!=j * j * 2`? What you need to remember is that `^` has lower precedence
than `*` and both have left to right associativity too so I can get away with
this, saving bytes. I did not want to do those three but on the other hand
they're kind of amusing.

This dropped the code size down by 5 to 2085, just 32 over the old limit: a
rather fun number.

There's a bit more bitwise ops that are needed but not many. A quick look there
are:

- five `&`s.
- zero shifts.
- zero `|`s.
- those four `^`.
- zero `~`s.

The bitwise ops besides the `^`s (XORs) are needed so I guess a total of 9
bitwise operations five of which are required and four of which are amusing (not
to say the four XORs are not amusing).

Anyway I thought shortly after the above: well if it's no longer 'scaling' and
no comments readers might ask why I'm not just using 1 instead of `d`? But
shortly after that it dawned on me how simple that question is to answer: the
code is screwy and `d` is used in funny ways. The reader already is being
screwed with with `d`'s value and that is plenty of damage. And the fact is I
also DO use 1 in other cases so the fact it's different might trigger suspicion
that it's not 1 but then the question is what is it? Also in some cases I'm
pretty sure I use one number to get another and I might even use one number to
get that same number indirectly.

In fact I played with the idea of actually adding to it but forcing it back to
its proper value (at this point) of 0. This worked well but the problem with
that is it can be clearly seen to be part of an array index and if I added to it
every time that would obviously be bad. That would mean you'd be forced to look
at the masking and figure out it just sets it to 0. There were other ways I
contemplated but the simple fact is that the comment shows how you cannot change
the `!= 1` suggesting it is 1 and given that it MUST start at -1 (which I
challenged you to prove to yourself) and since 1 is not bad for the array (or
seemingly - it's hard to know what is what after all) it seemed more plausible
this way. The dare to change != 1 is kind of true anyway: if you do do it it
WILL break. The part that is false is that just because it needs the `!= 1`
does not mean it's actually 1. Sneaky.

Oh and there was another really sneaky thing I did with this one. What happens
if you change it to a value that's not 1 or 0? Well:

```
    prog.c:49:25: warning: result of comparison of constant 2 with boolean expression is always true [-Wtautological-constant-out-of-range-compare]
       48 |                 ==e)!=d/2,d=d/2; /* CHANGE != 1 AND PROVE d IS 1 */ if  (d=(c!=e==!d
          |                                                                            ~~~~~~~~~
       49 |                !=d!=d==1&&e!=c)!=2||/* NOW YOU KNOW d IS 1! */fread(c, -*(S[F])-d*3 ,
          |                ~~~~~~~~~~~~~~~~^ ~

```

That is too revealing so I also added to the Makefile
`-Wno-tautological-constant-out-of-range-compare` so that this is not triggered.
Isn't that just great? It's a rather unique way to abuse the Makefile: not using
macros to save bytes or to obfuscate but simply to disable a warning just to
make you miss something! I am not sure if that's ever been done in the IOCCC but
OBVIOUSLY I had to do that.

The fact some people might wonder why I don't just use `1` (instead of `d`) is
frankly not an issue because lots of people do this, even outside of obfuscated
code. Plus it forces you to keep track of `d`: after all you can CLEARLY see how
variables are changed in main() and main() is what calls `m()` and `main()`
itself heavily modifies `d` for a while too, so this makes it MUCH harder to be
sure of its value. Even if you figure out the lie that it's 1 (because in truth
at that point it is 0 even though removing `!= 1` or changing the 1 to something
else will break it) you still have to contend with the fact that it could be
changing without you realising it. This combined with the comments (including
the true ones) adds to the devastation.

The fact you already saw that `d` is changed a lot might make you doubt yourself
even more. Yes I could have it 'modified' in `m()` and I even did this before
but the fact it is being used as an address would be too suspicious: it would
make you look at it more rather than just believe it is 1. Finally on this as I
do use `1` elsewhere you might be more likely to believe that it did change.

The REAL point is that if you convince yourself it's 1 (which it looks like)
then you convince yourself that it's not 0 which is what it actually is.

BTW: as it is a 'boolean' it is not clear to me if you change it to some odd
value it'll work or not. However given that it's actually making sure it's not 0
(and thus exit) but presumably just 1, I guess that's not the case. Obviously I
did not check every possible number!

Before I get to the other parts in between: at the end whether or not to do
`fscanf()` or not it 'changes it back' to '1' which of course is still 0.

``` <!---c-->
    return((S[I][*V-d]&*V)== *(* ( S + 3 ) + 2 ) - d && 3 ^ fscanf(q, "P6 %zu %zu %zu%*c", Q, & j, & n) ||  n   >255);
```

So when is `fscanf()` going to be executed? Well let's evaluate that last line a
bit.

Remember that `V` points to different locations at different calls to `m()`
because `u` is different at different invocations (another way it differs from
some other table abuse you've might've run into, though the real thing is it's
so many different things, I guess). That means:


``` <!---c-->
    for (*V=0; *V<d+*(*(S+7)+3); ++*V)
```

will modify DIFFERENT locations at different times (and that's assuming it is
run at all which it is not always the case, which is key here, see below). I no
longer know what `*(*(S+7)+3)` translates to but from the output of
[debug.c](debug.c) it would appear it's always 6 (okay it's easy enough to do
without debug.c). But this one:

``` <!---c-->
    if((d+s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V- 1:*V+1])
```

apparently varies. One time at least (it appears it's not based on the image but
I cannot say that with certainty) it started out like: 5, 6, 1, 4, -3, 8, 80 and
many more.

I **believe** this is the parity (I will return to the fscanf() soon - this is
part of it) check to determine the right cell to check if a pixel should be
drawn. Remember the data was interleaved twice, one after the other. I did this
manually so I had to come up with everything manually so I cannot really explain
it any more at least without much care. This removed patterns.

But it gets far more diabolical because as you're about to see that `*V` which
is at different locations at different times, that is critical in whether or not
to call fscanf(): which is vital because the first file opened (the source) is
read only but the second one, the output file, that is write-only and it is
undefined to read from a file not opened in write mode!

I think I said somewhere that `fscanf()` might be only be called twice. That
might or might not be true (it can only be called twice though, see below) but
`m()` is called only once after the output file is opened. It so happens that at
the last two times (see below) `*V` will be 6 at the end and not 3 (which means
the loop was entered - see below).

Now the fact that `*V` also is used (in part) to determine if the pixel should
be drawn should be kept in mind. I'll return to this in a while.

But if `d+ *(*(S + 7) + 3)` is always 6 this must mean that when the loop is
done `*V` should always be 6, right?

Well perhaps not. As you'll learn it is not always entered, that loop, and that
is vital, because it will remain at 3 and the other expression I will show,
that'll remain at 178, and `3&178` is 2 which is the gatekeeper to fscanf(). In
call #2 and call #3, but especially call #3, it CANNOT end up with the result of
2! And in call #3:


```
    in m(call #3): *V: 6, S[I->12][*V->6]: 6
```

But in call #0:

```
    in m(call #0): *V: 3, S[I->12][*V->3]: 178
```


This is absolutely VITAL! Let's figure out why this is. That return starts out
like:

``` <!---c-->
    (S[I][*V-d]&*V)==* (* ( S + 3 ) + 2 ) - d
```

What is `(S[I][*V-d]&*V)`? That is 2 in the first two calls. So in order for the
fscanf() to be called the lhs of the == must be 2. I already said why it would
be 2 but let's look at both `*V` and `S[I][*V-d]`.

In call #0 `*V` will be 3 and `S[I][*V-d]` (output above might have omitted `-d`
because that came later and I'm out of time; but even if you've convinced
yourself earlier on that `d` is 1, as I hope you did :-), it is not, so we can
simply ignore that) is 178.

What this all means is that `178&3` will ONLY happen in call #0 and call #1,
though the second call should not matter as it will be at EOF (so fscanf() will
not do anything useful). Actually I am not even sure IF the second call will
call fscanf() and I don't have the time to worry about it.

But in call #2 and #3 (the third and fourth calls) it (`*V`?) is 6. Now `178&3`
is 2 so the rest of the expression will not be evaluated in the other cases
because the AND will not end up being 2! You can confirm this with debug.c
although earlier on I did a check in the code with `abort()`.

And remember how `*V` is at different locations and what it might end up as
depends on this. The first time we see it in the debug output it is 3 and that
is because that loop was never really entered (the condition did not allow it).
This holds in call #1 too. But in call #2 and onward, it IS entered and
modified. I am not sure which cell that is though: and that's entirely the
point; each time the cell might very well be different. It does change a lot.

A fun fact is 178 can show up elsewhere, for instance:

```
    in m(call #2): (d+s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-1:*V+1]: 178
```

As you can see in the `if` of the loop it is doing what looks like a parity
check. In fact it is THIS code I BELIEVE that checks if a pixel should be drawn
(again I believe). It seems likely. It will then do horrible things if the cell
it picks (which is also done horribly as I trust you've noticed) is non-zero
(again coordinates, or possibly coordinates: not sure, but I had to carefully
write the code to not mutate or to only mutate in ways that do not break
functionality - though as you might or might not have realised I MIGHT have been
able to get away with different values - but this is not certain as some other
values must remain the same so I can't just modify any value). Those horrible
things start out like:


``` <!---c-->
    for(M=&S[S[J][d+S[d+*S[*(d+S)[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(*(S+H)+2)][3]],*M=0; *M<5; ++*M)
    for(A=S[S[J+d][S[H][2]]]+(*S[2]&S[2][*S[F]*-1]),*A=0; *A<*D; ++*A)
```

And there is the `e=c` assignment so HOW is it that that is even reached earlier
on if the `if` prevents it from being reached? Well that's for you to parse. Now
I think on it I believe it is these two that check for row/column but honestly I
haven't the slightest clue now.

It seems yes though. Anyway inside the inner loop (or innermost loop) you can see
it determining where to draw a pixel if it is meant to:

``` <!---c-->
     {
        P=a+(S[u][S[t][B]]-*D)**D+*A;
        G=p+(z-*D-d)*(F-5+1)+*M;
        if(P>=0&&P<b&&G>=0&&G<j)
        {
            e[i=/*R*/ ((G*b+P+-*(*(S+5)+3))-5)**S[*(*(S+15))+**(S +F)+*(*(S+13)+6)]*-*S[*(S-d)[15]]-*(S+d)[F]+*(*( S+6)-d-*S[9])]=s?W:r;
            c[-d+/*G*/+--i]=s?K:k;
            c[-/*B*/- --i+d]=s?v:w;
        }
    }

```

Now realise that `u` is not the same value in every call to the function. As for
`B` that also changes. I had to carefully construct the array to work. Some rows
are easier to change than others but just because it is easier does not mean
that you can do it without changing other code. The rows that are easier are the
ones that are not cells that control drawing of pixels (how to certainly and it
seems when to as well).

But because of how things are designed that might not be easy to find. Also even
for rows that are easier to change it does not mean you can change just any cell
in said rows.

Do you see how I write the RGB to memory?

The comments suggest I'm going in order but they look funny, breaking up what
would otherwise be `++` and `--` (including illegal ones). Amusingly one
beautifier (a version of bcpp) actually moved the `/*R*/` to above the
assignment of `P` **before** the `if` that is the block I just showed you!

In the first case I'm using `e` and in the second and third I use `c` also.

But more interesting is I'm also doing it **out of order**. I am updating the
data **backwards**.

The calculation of the index, assigned in `i`, is formidable. I don't even
remember what it really is. But the last part I can say: it does + 3. That's how
I can go backwards in memory without it being wrong.

But to throw in more confusion I had to add in `d` didn't I?

Now the `s?` determine whether or not it's the up or down arrow (yes this also
is part of selecting which 'array' to 'use' when doing `d+s+S` which for all you
know might be `1+s+S`).

In the past it was simply green 255 up and red 255 down but for more user
friendliness I put macros in the Makefile so that one can redefine in it (yes
this is why it used extra bytes). Before the change it was still doing the `s?`
of course because it still needed to know which arrow it was!

Of course `s` SHOULD be 7 OR 0 but as you'll see it's not always the case and
that partly bogus call it sets `B` to 4 (which is required!) but that value is
what becomes `s` so the cell that is checked (the 'parity' one which I get to
somewhere) is accessed like `d+4+S` which you might or might not think means
`5+S`. But of course it's not. If it is indeed 4 like I think that means it must
be:


``` <!---c-->
    0,0,0,-5,0, 0,5
```

but did you notice something else diabolical? Look at the line:

``` <!---c-->
    if((d+s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-1:*V+1])
```

What this means is that STARTING from what looks like `1+4+S` (but I **believe**
is ACTUALLY `4+S` (see above data assuming I counted right which is not clear to
me) it is selecting cells to do parity for figuring out the arrows. But consider
how `V` is assigned: `S[U][S[t][B]]` I think (though it doesn't look like that).

Now remember what `B` was set to? That was `4` (which in this case appears to be
`s` as well. Of course the entire value of `z` which is about to be used in the
`if` (as you see above) is set to `(*(S+4))[*(*(S+3)+1)]` (I think) and that
will become important momentarily.

But notice how the table is being addressed: remember it is (again I think)
`(4+S)` so the fifth row in `S`. `V` points to `&S[15][S[t][B]]` and so `*V` is
the value of `S[15][S[t][B]]` and `z` is the value given about (and doesn't look
like it and I can't tell you what it is either).

However is the `if` (described more below) even reached in this case? It is if
the `!(*(S+d)[*V]&*V)&&z<2-*(*(S+5)+3)` is true (and already `V`'s new location
based on `t` and `B` is being used here as part of the table access so I guess
the first row, ANDed with itself) but it is not clear to me if that is the case.
So that COULD explain how the first call to `m()` (after reading the header) can
be skipped: IF the side-effects are done anyway. However I do not know I just
guess so. If it's true we have an answer of how it does not draw the arrow in
the wrong spot but why in the world would I have it access (or try) `(4+S)`? I
have no clue myself.

But that `if` is diabolical too. I can't even tell you what it evaluates to the
first time it is entered but I GUESS it is:

``` <!---c-->
    if((0+7+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-1:*V+1])
```

...but that is in a loop in a loop and the inner loop and outer loop both use
`V` and `S` and the inner loop uses `z` as well. This I believe determines where
to check for the arrows (if to draw?) but I do not have the slightest clue on
this. And as for what the entire if evaluates to I also can't say. It does not
help that every iteration it will change with `z` in multiple ways (the parity
and the calculation) PLUS `*V-1` or `*V+1` on top of the `(*V&1)`: which means
there are two different parities being checked and one is on `*V` which is
dynamically selected and the other, `z`, it just so happens that it ALSO is
dynamic, based on `t` **AND** `B`!.

This is diabolical and it's only ONE of the MANY uses of the table! This is NOT
usual table abuse and I think the actual proper use (to render arrows) of the
table is unique to the IOCCC too (and I know Landon is an astronomer so I think
and hope he'll really enjoy it, all the more as I include educational remarks
and teach about antipodes which I believe is not so well known and also debunk
the myth that if in Europe or North America you dig through the Earth far enough
you end up in China).

Now let's return to `V` in general. As you can see it is being used as a
temporary variable (or perhaps you can't see it :-) ) and thus it's being
changed, wherever it currently points to (which remembers it depends on other
values - see above some examples amongst others - which means it might not be
as easy to trace and it also means you have to contend with the question of
whether or not the cell is used in another place another time, with the new
value: which is not easy to tell).

Worse is that it would appear that this is part of the check of whether to draw
an arrow or not (though I cannot confirm this)! And of course `V` (where it
points) depends on the value of `u` and `t` and `B` as well as `z` and who knows
what else! It depends on so much. So how does that work?

If you look at the huge output of debug.c, it seems that it's only the last rows
but I DON'T know if this is actually strictly true (I said it was all at one
point but I've lost track of it myself). What I **DO** know is that the first 14
rows ARE used to figure out how to draw the arrows and I BELIEVE row 12 is used
as part of whether or not to call fscanf().

You can see, again, it (`*V`) is initialised to 0 but it's not so easy to
determine how far it goes or where it even points to (also a question you have
to ask yourself is: does that cause a problem with where to draw a pixel or not?
Obviously not so: how does it get away with this? Or is it related? As noted it
does appear to be but I can't say how precisely now).

There is an important point though. `V` is only changed (location and `*V`
value) IF the first loop condition is true. Remember this?

``` <!---c-->
    !(*(S+d)[*V]&*V)&&z<2-*(*(S+5)+3);
```

The `z` check is funny too. I could be wrong but the `*(*(S+5)+3)` might be
negative but I don't remember now and it's possible it will change values on
different calls. It might be that it's not in debug.c because of where it is and
because before it `V` might not be pointing anywhere valid. I don't know and I
don't have time to check now.

But you have the other thing, the AND of the cell value based on `*V` (and since
it points to different locations at different times, which might or might not
even be inside the first 14 rows: it seems implausible but I have this memory of
it being inside it at some point, this makes it harder to keep track of) and
itself (as in and `*V`).

If that entire expression (which I unhelpfully negated) is not true then `V` is
not updated (or rather `*V` is not: the pointer IS, if nothing else assuming
another call is made to the function but maybe in other ways too: not sure).

And that is part of the key to `fscanf()`. I already talked about it but I
forgot some important points and I do not have the time or energy to try and get
it in the right location (even if all of it could be talked about then which
might or might not be the case).

``` <!---c-->
    return((S[I][*V-d]&*V)==*(*(S+3)+2)-d && 3 ^fscanf(q, "P6 %zu %zu %zu%*c", Q, & j, & n) ||  n   >255)    ;
```

The `d` part can be ignored and the `3^` part and the `n > 255` can be ignored
here too (but only for now!). Let's extract the important part:

``` <!---c-->
    (S[I][*V-d]&*V)==*(*(S+3)+2)-d
```

First of all what is `I`? Well it's set in the first call to `m()` (an important
point!) though not as an arg to it (think: comma operator). As you know `*V` can
be different values and `V` is pointing to different locations (meaning that in
some calls `*V` might be 2 or it might be 6 [2 certainly and I think 6 though
don't hold me to either]).

Remember how I said `d` starts at -1 and it must not change? Well in that first
call to `m()` (again not as args) I do `J=u` (`u` starts out at 15) and then set
`H` to `d+4` (there is the reason IN PART it must stay at -1 at first) and then
set `I` to `J-H` which is the real reason it must start at -1. Some of this has
been noted.

After that I do another assignment (`D=*(S+u-1) +1`) and then adjust `d` to 0
followed by the real final arg to `m()` (`L` which is set to `-U` which you can
probably figure out if you look at the usage string - maybe you can anyway;
certainly easier than some of the other things). So here we have determined the
row in `S`. This is the first call I think so the above discussion (about the
`s` becoming 4) is not relevant I think.

Here is how it's adjusted to 0 (I think):

``` <!---c-->
    d -= *(*(S+7)+ 6)
```

I might have shown this. I'm not sure but yes that is in the first 14 rows so
you can see an example of how I had to work with the coordinates.

Now at this point `d` is 0 so `*V-d` is still just `*V`. I said in an earlier
version of this document that this would mean 0 because of no mutation this pass
but this actually I think cannot be true for the following reasons (though maybe
I'm wrong): the `&*V`, if it was 0, would mean that the AND would be 0 and when
we call fscanf() we actually need 2! The debug.c output shows I think that the
first two times it is 2 and the third and fourth times it is 6 (yet the first
two times it starts out at different locations I'm almost certain).

So `*V` is controlled in such a way that `fscanf()` is ONLY called when the AND
expression evaluates to 2, based on other cells, including some that are
actually part of coordinates (in the first 14 rows) (I think!).

I believe it's in row 12 in which case I did have to work real life coordinates
into it. I have this memory I did indeed.

Whatever the case you can now know that `V` (which means the cells) is (are)
carefully controlled so that `fscanf()` will ONLY be called when `(S[I][*V - d]
& *V)` is 2 and that later on the value MUST NOT have that value because that
would mean `fscanf()` would be called when a file is open in write-only mode
(and it shouldn't be unless a final mistake was made but I think not, especially
because of debug.c and it also works in multiple systems).

The amusing thing here, and this makes me wonder if the coordinates actually ARE
modified, is that `*V` is used in the return as an expression and location and
since `*V` points to different locations and it seems to point inside the first
14 rows and since I do `*V=0; *V<d+*(*(S+7)+3); ++*V` maybe the coordinates
really are modified but controlled. I don't know how I could contrive that but
it certainly APPEARS like it if nothing else. There is another possibility,
namely that the 2 is already there but again I don't know. IF they are modified
then it MIGHT be on the last column (which is not needed and is highly unlikely)
or else because it stays non-zero (in the end) it's okay.

I suspect now (12 March 2026) that they start out at 2 and the condition in the
first for loop prevents the change. Again this is just a guess but I think a
reasonable guess.

Obviously there is no need to conceal the `=0` part. It won't help you much at
all if at all because of the rest of it and the fact it points to different
locations at different invocations. Granted I could have concealed 0 but why
bother? I probably do in some cases anyway and I wanted to keep the size down.
Hiding 0 in every place is pointless especially as it's the value it gets to
(and HOW it gets to it) that REALLY matters for later in the function.  Well
maybe no value does get to 0: I don't know.

But if the value was not carefully controlled then the program would not even work
because the `fscanf()` would not be called!

Oh btw: have fun trying to reverse the order of the loop.

I noted how there are some self-referential accesses to `S`. Not terribly so and
it's more how it's done with other things but there can be no denying these are
some terrible examples of self-referential access. I guess these might be the
worst offenders but I don't know:

``` <!---c-->
    for(M=&S[S[J][d+S[d+*S[*(d+S)[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(*(S+H)+2)][3
    ]],*M=0; *M<5; ++*M)for(A=S[S[J+d][S[H][2]]]+(*S[2]&S[2][*S[F]*-1]),*A=0; *A<*D; ++*A)
```

Actually here is another horrible one in that function (you already saw these
but time to discuss them even more):

``` <!---c-->
    for ( V =&S[ u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]; !(*(S+d)[*V]&*V)&&z<2-*(*(S+5)+3); ++z)
```

Now we all know how it works when using a cell's value to pick another cell but
I have done it in multiple references (not just one) and the array is not
particularly nice. The real problem is not that.

The real problem is that the variables are different values at different times.
Depending on `u` the `V` will point to a different location. And depending on
`h` (which changes in the loop, see the snippet above the above one) a different
cell is accessed AS WELL. And as far as many readers can tell, and my comments
help with this, `d` is 1 which only adds to confusion.

As you see, and this is done throughout the code, I also have assigned variables
different values in places that this should not be done, including in the
indices THEMSELVES (yes in the `[...]` part as you probably remember). Not only
that but different kinds of assignments including pointers and integers.

It's hard to be sure which of those above lines is hardest to deal with but when
you consider it uses variables to do so and when there is that `d` with its lie
and as other variables too (like in the line with `if ((d+s+S)` which also uses
somewhat horrible dynamic cell selection) and when they're nested (especially
the for loop inside a for loop which has an if which has a for loop and inside
that for loop is another for loop, for example, but maybe other things too: not
sure), it's even more formidable.

I said how `m()` is called at a time it might not be needed and I explained why
I THINK this is but there is something I cannot myself answer: WHY did I do it?
Why would I set `s` to 4 and thus access `d+4+S`? What did it do? I have no clue
but what I do know is that it does not break the code but IF the function call
is removed (but why on our Flat Earth would I do THAT?) you still have to make
sure the side-effects are kept!

The thing about this is that from all appearances you might think that the arrow
is drawn another time but clearly this is not happening: or else there is some
VERY Deep Magic going on that I'm unaware of (where are you Aslan?).

More like Dark Magic: especially as I cannot explain everything: not even close
(and I hope that means something to the judges). With [debug.c](debug.c) I think
everyone would be surprised if I could after writing it a month and a half ago
or so.

BTW: earlier on I did a check to verify that fscanf() is only called at the
right time. As I said earlier the values changed but this was the idea.

``` <!---c-->
    if (V!=3 && (S[12][V+d]&V)==2){ printf("%ld\n",V); abort(); }
```

then if there was an error in my logic it would call `abort()` and the program
would terminate. But of course it didn't and debug.c would suggest this would
not happen now either although obviously the code is way more formidable. A
difference is now it can be called more than once I think, but that should not
matter unless a terrible mistake was introduced (shouldn't be, see below).

I BELIEVE it MIGHT be called twice but it'll be at EOF anyway as after the first
call I call `fread()` which unless the file has more data than it's supposed to
(i.e. the header is a lie) it'll be at the EOF. This means that if `fscanf()` is
called it'll just return EOF itself. I only check the return value of `m()` the
first time.

There should be no risk of it being called a third time and definitely not when
it's in write-only mode (the last call):

```
    in m(call #2): (S[I][*V-d]&*V): 6
    in m(call #3): (S[I][*V-d]&*V): 6
```

and:

```
    in m(call #0): *(*(S+3)+2)-d: 2
    in m(call #1): *(*(S+3)+2)-d: 2
    in m(call #3): *(*(S+3)+2)-d: 2
    in m(call #3): *(*(S+3)+2)-d: 2
```

and 6 is not 2. The only time the file is in write-only mode is in the fourth
call. The first call (call #0) is when the file is scanned. The second time is
after the calloc() (assuming no errors) and it would be (in theory) read in full
but it'll be at EOF so it'll just do nothing. The third time, call #2, it is 6
and the same with call #3 (last call), so there is no problem here (as tests on
multiple systems also confirm).

Thus the `m()` function serves AT LEAST THREE purposes (if it has others I can't
say what they might all be - I just know it works, and I had to run LOTS of
tests because of how this code is designed):

0. Read the header of the image (it's an error if there is an error or invalid
data i.e. invalid header).
1. Draw the arrows.
2. Set up vital variables like `e=c` (without which this can crash). Yet it does
it at the right time and sometimes it might or might not run (the code in the
function in general I mean). It also is hidden deep in the function in an place
that seems like it should not run at first (maybe).

But the function probably does other things too.

It does all this with **varying** values so that pointers point to **different**
locations _based on **global** variables_ (though they might be 'passed into' via
comma operator, which really means it's set up prior to the function being
entered). Values are controlled and selected properly. Touching the table is
perilous. Everything is constructed very carefully.

It does all of this and maybe more whilst concealing a great amount of things.

It was very carefully designed and so far as I can tell, and my `make test`
seems to confirm it (as do other tests I have), it works just fine in my
systems.

There is a lot of misdirection in that single function and how it's used, and it
plays with the lie about `d` too. Which remember the comments encourage you to
mess with values to show what I want you to believe (and the fact that the
comments are true, the -1 must be -1 and the `!= 1` must be that too, also only
help you believe others). Actually an extremely amusing thing about the `!=1` is
done that I'll explain [later on](#tautological). It is probably NOT what you
think!

Have fun figuring it all out without looking at the table and much care.
Although [debug.c](debug.c) might be useful, it is not complete due to where
some of the expressions are, and it's a VERY long file as there are so many
expressions that are there. Some are part of other longer expressions, such as
assignments in the address of the table in some cases, amongst other examples.

If you missed in the code (and did not discern through my remarks) I negate
global variables in assignment but during any use of them they're negated back
to where they started - and then used normally the next time.

Incidentally, as for `V`: because of the lie about `d` it might appear (but it's
harder to tell because I in some cases conceal the end condition) that I go out
of bounds. You might guess I don't since the code works and indeed it doesn't
(unless something horrible happened last minute but I doubt it as ASan did not
report anything and neither did UBSan, though at one point it reported the false
positive about unsigned 'overflow' - and the code works as well).

Here is something amusing. It no longer is this code (but it's not any better
and actually it's worse which means it is better now I think) as you know but I
had a check like:

``` <!---c-->
    d=c!=e!=d!=d+1==d*d
```

But these were all equal:

``` <!---c-->
    d=c!=e!=d!=d+1!=d
    d=c!=e!=d!=d+1
    d=c!=e!=d!=d+1!=d-1
    d=c!=e!=d!=d+1==d+d
    d=c!=e!=d!=d+1!=d+d
    d=c!=e!=d!=d+1!=d*d
```

and probably other variations too. What this shows is just how hard it is to
keep track of `d`, whether anyone finds it 'easy' or not. The horrible part is
that in this part, when checking for NULL at the very least, you have to keep
track of what `d`'s OLD value is and that IS CONSTANTLY CHANGING in ways that
make you question your ability to deal with strange operator chaining, even if
you know operator precedence and associativity very well.

Of course just because it LOOKS LIKE it is changing does not necessarily mean it
is as I trust you noticed. That doesn't mean it doesn't change. Try adding
`,c=0,` between the call to `calloc()` and the next part, compile and then run
it on a file to see how the program will exit as if a memory allocation error
occurred.

These were also equivalent:

``` <!---c-->
    d=!-!(c!=e)!=d-1!=d+1
    d=!-!(c!=e)!=d-1!=d
```

But what I have in prog.c is obviously way better as it looks like `d` must be 1
when in fact it must be 0.

Regardless this is psychologically devastating and even if it does not do your
head in personally it still is not traditional and it's a TERRIBLE way to check for
`calloc()` failing. To then use the flag in as an offset into an array is even
nastier (even worse when it's not actually anything but 0 but looks like it).

This is funny:

``` <!---c-->
    fread(c,-*(S[F])-d*3,b*j,q)
```

You could be forgiven if you think that's illegal. It looks illegal. But it
isn't. That expression evaluates to `3`. Isn't that great? Also if you currently
believe `d` is 1 and you figure out what `-*(S[F])` will that change what you
think is passed to `fread()`? It might but it might not (obviously it only has
one answer and obviously passing in any value, whether 0 or something other than
the number of bytes required, would be silly at best but still).

But not to be outdone there I used it in another way that also looks funny - and
like a totally different result which is one of the reasons I have used it.
You'll have to find that yourself if I did not include it somewhere because I
unfortunately forgot what it is.

But as you saw earlier how I use it you probably also realised that I made it
really hard to determine where or if it is even still there.

If you haven't yet I highly recommend you locate all the calls to `m()` to see
how data changes in the call (again outside the parameters to the function
itself), thus making the function itself harder to reason with. Better yet if
you've not tried [debug.c](debug.c) try it!

One thing is certain though: it is vital that the cells with 0 remain 0 (at
least...certain cells and at the right times - but which ones?).

If any does change then before checking if a pixel should be drawn it must be
reset to 0 as 0 means don't draw a pixel. But as you saw there is no arrow shape
because of interleaving and because of the formatting too (which would not be as
much of a problem with a good beautifier but the dynamic selection, the
interleaving and mutation (including of dynamically selected cells I think) -
that all makes it very hard to keep track of things!

I hope you noticed that although I have used the array a lot and possibly reused
some of the cells I do it in different ways. Also as you know the array has data
of different kinds, it's changed yet remains correct, different cells are used
at different times (except for drawing pixels, although some of those are also
used for other purposes including I think the gatekeeping of `fscanf()`!, and it
at least appears that they are changed as well, at least some of the non-zero
ones), it's coordinates in real life yet still the code was designed to work
with that, some of the cell selections are really twisted etc., and they are
dynamically selected as well: `V` which is a main entrance point is selected by
the value of `u` which varies from call to call, even out of order sometimes.
Pointers are also assigned in different ways too. Here's an example:

``` <!---c-->
    D =* (S +u-1)+1
```

and the question is what is `u` at that time? And yes I did it like `=*` because
of how the compound assignments used to be (see my [remarks on
warnings/compiling](index.html#compiling) if this makes no sense to you) and
because it looks funny.

Critical numbers are, as I said, often hidden.

This is a fun one:

``` <!---c-->
    for(M=&S[S[J][d+S[d+*S[*(d+S)[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(*(S+H)+2)][3 ]],*M=0; *M<5; ++*M)
```

Yes I already showed that. What I mean is this part:

``` <!---c-->
    [++h%S[*(*(S+H)+2)][3 ]]
```

That is rather critical, every part of it, but it looks wrong too. I no longer
know what these cells evaluate to but as you can see also the cells are mutated
throughout execution, and there is the fact that there are many dynamically
selected cells.

And yes that code also controls in part which cell is being selected (but in
other places like with `V` it's done differently) so that I could order the
cells in such a way that they have the real coordinates and still work. In
particular I mean the modulus. The full part is:


``` <!---c-->
    S[S[J][d+S[d+*S[*(d+S)[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(*(S+H)+2)][3 ]]
```

and what this means is in yet another way the cells are being used: magically I
am dynamically selecting the cell based on `h`. I already do it in other ways
(based on variables that change) but in this case it's part of the loop.
Unfortunately I no longer know what this is doing I just know it's critical.

Did you notice how `m()` uses `F` which is not assigned any value at file scope
(so 0) but the expected value is 9? Yet in the first call to `m()` the variable
is not 9. Can you figure out how this happens? Note that it is (for one example)
used as `*S[F]` in that function. If it was 0 it would be `0` but that's not
important precisely because it's 0 (well there might be places where 0 is used
in the table but differently). But in the call to `calloc()` then `F` is set to
9 in an amusing (wrong) way.

At one point I did try changing it so `d`'s comments were not lies but it proved
to be a problem and I wanted to keep the following critical properties:

- it starts out as -1 (and changing this will break the code - which you might
have tried doing as I dared you to; if you haven't please try it).
- it ends up as 0 but it looks like it's 1 (and the comments encourages you to
change the `!=1` to 'prove' to yourself it is in fact 1).
- if it is NOT 0 then it's an error.
- yet it simply is used as an offset into the array and yet it's not really an
offset at all (it's also used in other places).

Happily I had the thought that there should be no scaling since that removes a
lot of weaknesses in the idea I just mentioned and the 'scaling' itself.

Did you notice how `t` changes between calls to `m()` yet the following still
works (and it's hard enough to follow even without that due to cell addresses in
`S` being determined based on another cell in `S`, if it was a constant number,
but as you're about to see, and as you already saw in other places, it's NOT
constant)? Well where is `t` set in the first place? In a funny place it is:

``` <!---c-->
    if(tr<(t=6,0))tr+=T;
```

...where very few people (and no sane person? :-) ) would expect it.

But why would anyone throw in an assignment on the rhs of a comparison? It can
be useful on the lhs (as the value might be needed as well) but on the rhs -
that is not normal. The answer to that question is: why not?

Before the next use of `t` it does `t+=F` (in a function call itself, not the
function) and `F` starts out at file scope (so 0).  Before the `t+=F` it's
assigned a value (inside the `calloc()` call also via comma operator).

Both `F` and `t` are used in that function too (not `calloc()` - the one that in
the call to it it does `t+=F` i.e. `m()`) so there is a lot to keep track of.

Now you saw this code before (yet again, sorry: different things to talk about):

``` <!---c-->
    for ( V =&S[ u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]; !(*(S+d)[*V]&*V)&&z<2-*(*(S+5)+3); ++z)
```

but I didn't talk about the `t` and how it's used there: so `S[t]`. Well what is
`t` anyway?

The first time `m()` is called is when the code has not yet parsed the header of
the PPM image. `t` starts out as 0 but before the first call to `m()` it is `6`
(see above). In the call to `calloc()` `F` is set to 9. `m()` is called again
but this time `t` is not modified (I think). On the third call it becomes `t+=F`
so `6+9==15`. Then in the fourth call before it is entered it becomes 14 (`(++u,
--t, 0)` is the last parameter passed in).

And yet every single cell of `S[t][B]` is correct when setting `V` (and of
course `F` is also correct). What kind of sorcery is that?

What's more is, and I hope you noticed this, is that cell, `S[t][B]` is actually
what determines the column in the row `u`.

What is more amazing is this started before I added the extra rows that are
simply data and not coordinates (or I don't think they are coordinates - they
might actually be partly coordinates but if so I don't know what to any more),
as those rows are only the last three or so. So the coordinates do indeed
control what cell is being selected yet it always works and the coordinates were
selected not to be the 'right' cell as such but to be a coordinate of a specific
place though of course the table also has zeros (but as part of coordinates as
well as to not draw anything).

That is sneaky and diabolically hard to follow. Even if you determine what cell
is being selected each time you still have to contend with the fact that it can
vary. Oh but there is something even worse here, something that I forgot to
mention.

This is `V`. So...what is done with `*V`? It is a loop iterator: `0..5` (so it
stops when 6). You saw the code.

But what that means is the cell starts out at 0 (since it dereferences
it) and yet I make sure there is no mutation (at least in the array where it
matters for drawing arrows). Actually: does it ever point into those cells at
all? It appears to but I thought I saw from [debug.c](debug.c) output that it
might not. I am therefore unsure but that is probably a good thing for the
contest :-)

But another question you then have to ponder is: is this specific cell ever touched
in the inner loop or nested for loops? It MIGHT be obvious if you think a bit
about it but looking at the code might be overwhelming, especially as there are
lots of other obfuscations to select cells (`M`, `A` being pointers to different
cells also, including some that select cell indices based on another cell's
value) and other things.

Basically `m()` is polymorphic in what it does and the table was constructed
very carefully. Touching it is perilous. I would not want to do it now.  At best
it will lead to incorrect results but it could be a lot worse than that.


### Challenges to those who think they understand the code

If you think you understand the code can you make the arrows a different shape
WITHOUT breaking or changing anything else? This might be a lot harder than you
think but maybe some can do it? Although I made it I would not wish to try
changing it now. Even trying to make the arrows even bigger (which is not
necessary I know) was problematic. Yes I actually tried it.

I already explained why it's not easy. The interleaving does not help matters
either of course.

Note that if you do embark on this journey you have more than just the shape to
contend with because you also have to consider width, height and the map. For
instance will it map well on the coordinates `0 1`? My program does but there
was a bug that prevented this at one point due to having resized the arrows
(before I twisted everything with a brand) - it was partly off the map (and in
fact that was at 0 5; now 0 1 and 0 5 and in between should work, although I
only tested 0 1 and 0 5: but since 0 1 is closer to the edge it should not
matter).

Something you should keep in mind that I mention [here](index.html#scaling) is
how scaling can affect display (also discuss it elsewhere but there are some
experiments noted there to show how even when it looks like there is no
difference there actually IS a difference) and this includes (but is not limited
to) the scaling at the edge of the map, including that it APPEARS that at the
top of the map arrows might get a little bit closer to the edge: however not by
much IF it is happening (could be the coordinates for example) and it's risky to
change the parameters so I'm not going to do that as that could introduce actual
bugs.

Actually there are other things you'll have to do too including changing the
`if`s and possibly the `for` loops and maybe even calculations in `m()`. I
**believe** that one of the required values is in row 12 but I might be wrong
there (code and debug.c seem to suggest it iirc).

Another one. Can you flip the loops order? For example can you change this loop:

``` <!---c-->
    for(*V=0; *V<d+*(*(S+7)+3); ++*V)
```

to start out at `*(*(S+7)+3)-1` and decrement while it's >= 0? I'll give you a
hint: the answer is no, at least not that one (if any others). It's relatively
simple to see why this is IF you understand the code well enough but doing so
might be hard without looking at my tips above (or if you're a masochist if you
look at the output of [debug.c](debug.c) although I'm not even sure if that
would be helpful).

Well I don't think it's possible anyway. Maybe you can prove me wrong?

On the other hand as you saw I do go backwards in memory in
some places so just because I have to go forwards in loops (which also saves a
byte or two here and there) does not mean I always go forwards! If you thought
otherwise you've not seen my code; clearly I am very backwards in nature.

Enjoy and safe travels! If you dare :-)

<div id="table">
### How the table is much more than a table and how it's other things too
</div>

Going back to the table before I finish out. One might think that this is the
main obfuscation. It is true that the main obfuscation **uses** the table but
it's not just the table by itself.

There are many ways to abuse a table even if it's (like mine) simply one of
numbers. There is so much potential that each use and abuse of a table (or in a
sense in my code multiple tables but flattened into a two-dimensional table
rather than two two-dimensional tables) is in its own way unique. This holds for
mine too.

The reason I think every abuse of a table is unique in its own right is because
every table is unique in its own right. They hold unique data, they are used for
different things, they are utterly different. Some of the common tricks might be
employed but even those can vary in use. A common example is using a cell to get
another cell's address. I do this a bit. A similar one is to use a cell to
calculate the value of another cell OR something else entirely. I believe I do
both.

But I do way more.

My table/map abuse is far from what is expected. It holds coordinates on our
beautiful Flat Earth (again if you think I'm serious I don't know what to tell
you because it's not flat; our Earth is really a beautiful Hollow
Tetrahedronic[^1] Earth) and the table is an actual map (hence having
coordinates), obviously shaped like some twisted and mutilated square[^2]
(because why not?).

This map actually tells the program the location of HOW to
render a pixel (and I believe when to, indirectly) WHEN the location on the
image is correct (which would be 'when' :-) ).

But the
coordinates that do this might be modified (or some of them) - though that is
not necessarily clear (and I no longer am even sure of it) - and some of them
have other uses too, and even when not modified (if they are), at the end of the
function, the value of `*V`, which is dynamically selected in each call to the
function and which might or might not be modified (also due to the table and
other variables), is used, in order to determine whether or not to call
`fscanf()` (and in a funny check, namely I don't check the return value by `!=`
or `==` but I XOR the call to fscanf()!). That is an unusual feature of a table
but it's still so much more.

The coordinates are special because those that are 0 must remain 0 and those
that are non-zero must remain non-zero. MUST I say and I mean it. IF they are
ever modified (and by coordinates I might clarify I mean the first 14 rows), and
it is not clear to me if they are (debug.c suggests no but that does not
necessarily mean they are not even if I think they aren't: and it would seem
risky to do so and that's the best case scenario: but it's still in theory
possible), then they are repaired (if they're ones that must remain zero) before
use.

The `*V` SOMETIMES points to a cell that evaluates to 2 (but I think there is
more than one in this case) that MUST be 2 or else the PPM image will not be
read! The very last call the cell MUST **NOT** evaluate to 2 or it would run
fscanf() on a file opened in write-only mode!

Now you might think that I could, if it happens more than once, just change the
cell to not have 2. That MIGHT be the case but it also might not and it will not
matter because as long as the file is in read mode fscanf() will either do what
it needs to do (the first time) or it'll be at EOF (unless the header is lying
but there will be no harm as the extra data simply won't be read in or written
to the new image) and that means `fscanf()` will return EOF itself. I don't care
about the return value of `m()` except the first time which is when fscanf() is
called in a vital way (but again the value is checked in a wrong-looking way
even after you figure out the rest of the return statement).

It might look like, but I cannot confirm now, that some of these coordinates
change. This seems weird at a first thought because these coordinates are used
in determining other things including whether to draw a pixel or not.

However it is possible that since `*V` ends up at whatever the value of
`*(*(S+7)+3)` which I believe is 6 (didn't check), at least on the third and
fourth call, that even if it's set to 0 it will be set back to non-zero. I don't
think so, not any more, but I don't know. But it is sneakier than this.

The thing is that that loop might not even be run (which is why the coordinate
would not be changed). It depends on the outer loop
condition: `!(*(S+d)[*V+d]&*V)&&z<2-*(*(S+5)+3)` which is pretty formidable: all
the more because what `V` points (see below).

In some cases it's not run, which means that some locations (remember that `V`
is pointed to different locations, whether or not `*V` is modified, at different
times as it's dynamic selection) might never be modified. This clearly includes
the first time which means it is 2 as I said.

These things mean that it's quite possible that the coordinates are changed to
other values (but they're certainly used as both a plotter and some for other
things) but carefully so that it still works.

But I still am sceptical I did this due to the risks and much more importantly
because of what has to happen with the variables that help select the cells AND
the fact I have real life coordinates in the table: yes that means, and this is
also significant, that I had to change code to match the coordinates and do it
safely: meaning also that if the last time the cell had 2 I would have to change
the order! In fact earlier on the number I needed was 3. I do not remember why
this changed except obviously that a cell value changed which meant my check had
to also change.

You also cannot know easily determine if a cell that is needed for a certain
purpose (which might not always be needed - but who knows if that's the case) is
always needed because of that condition above, for one example of possibly
(likely) others.

What is clear is the coordinates in the first 14 rows, they are vital to know
how to and I think IF it should render a pixel or not. But they do more than
that as you can see, or at least some do. But you also have to keep track of
what it points to (what location in the table which is not easy to do, even if
the cells were not dynamically chosen (which by itself is crazy).

Earlier on the coordinates were just 1s and 0s and this was too revealing. More
to the point it was clearly showing the shape of the arrows. I then interleaved
the cells, first one direction and then the next. This was STILL not enough to
my liking because the shape was still there! So obviously I made them real
coordinates: which is fitting as this program calculates coordinates (and draws
arrows) on an equirectangular image (presumably a map). It's rather fun also
that arrows in the table (albeit interleaved) tell the program how to draw
arrows: in fact how to draw themselves (just not interleaved i.e. it determines
based on other values - which OBVIOUSLY change in the loop if not elsewhere as
well! - and the cells in question, what to actually access to know how to draw
what essentially is itself but in colour on the image via the `unsigned char
*`).

As you might've seen I was sure that some of the cells that are telling the
program how to draw an arrow (I might've said earlier that it's when but if so
and that's true it's only part of it as it absolutely helps it render the arrow
too, unless I've lost my mind, which some people might think is the case - not
that that would mean it does not necessarily do what I say anyway :-) ) are
changed but I am no longer even sure of this.

The output of [debug.c](debug.c) is over 2MB (if debug option is used) and it
APPEARS that only the bottom rows are modified but just because debug shows this
in some cases does not necessarily mean anything because it's entirely possible
that it's modified elsewhere too. The only real way to do check would be to
attach to a debugger and add a trap (i.e. watchpoint) so that when a location
changes (and there are a lot of locations!) it will be stopped. That is not
something I think many people would want to do: except maybe gluttons for
punishment (btw from this logophile: did you know that glutton is an old
fashioned word for wolverine?).

There is some indirection as well but this is a lesser matter even if it looks
formidable (esp because of the dynamic addressing). The fact that sometimes a
number is used to get that SAME number is amusing and it does use the table for
that (why would I do that when I COULD just use the actual number? Because this
is the IOCCC, that's why).

I however cannot tell you what the dereferenced cells are and even if I could I
certainly cannot tell you if they are constant. It's entirely possible that they
are not. As you can see some values do change: it's just a matter of determining
WHEN, HOW and WHICH (cells).

That's partly because sometimes the code that increments a cell's value is
completely skipped over and that is based on the values of variables (that are
assigned in various unusual places) that change value in order to tell it
whether or not to go through the table (and where in the table!) and increment
the cells.

It is fun that REAL coordinates (or part of coordinates as I break them up into
several numbers, including that fractional parts are in another cell and they
tend to go backwards, kind of like how I do in writing to memory) control
whether to call fscanf() or not (combined with other coordinates of course) and
are selected based on other things, global variables included, all to find the
right location (based on the antipodes: how does that work together?) to draw a
pixel and how to do so, along with other things too (I think?).

The fact I cannot do `S[d+s]` but have to do `(d+s+S)` is rather funny.

But it's not only the table; it's other variables too that are part of (not
totally) an address into the array in just the right location at just the right
time so that that function `m()` does different things, carefully avoiding
dangerous things, even crashes.

As for cell selection you have to contend with the manipulation of the reader
with comments that tell the truth (even daring you to test it) in **full**
(even the last comment is true: you really CANNOT remove or change the `!=1`: if
I said it's a lie elsewhere that is not really true, ironically enough :-) )
which could easily convince you that `d` IS 1 which changes which cell is
addressed by `V` (and maybe otherwise).

I believe that last part is more unique in the contest but if not I am sure the
way I have manipulated the **Makefile** so that you miss something when you
follow through with one of my dares: that is sneaky. I don't think that's ever
been done. Abusing the Makefile for macros for obfuscation sure but how many
disable a warning that does not need to be so that when your comment dare is
attempted the reader is not alerted to what is REALLY happening? I could be
wrong but I'm pretty sure this has not been done yet but either way it's quite
amusing.

I also use `d` elsewhere of course. The fact it is in a boolean hell only adds to
confusion with the misleading comments since it can be so overwhelming that you
might just go ahead and assume it's the truth, especially when you might've
already proved to yourself that it must stay -1 (though it of course changes and
you know that too). That is of course why I added the `-Wno-` option: just so
you miss that it's actually being used as a boolean rather than an int!

As for the Makefile see a bit further down.

But this all means the table was created in such a way as to not only have the
coordinates that are required to tell it how to draw the arrow (and if you
change them all to ones or zeros that won't help you figure out the shape due to
the interleaving and not only that but it would also break the code) but to also
control everything: whether or not to scan the header, whether or not to enter
additional loops (that might or might not do things depending on the value of
those mutated cells), what colour to use (kind of) and every other part of it.

Well actually the table does NOT control everything, at least not by itself.
This is because other variables determine where in the table to 'go'.

What this translates to is the table is quite multipurpose yet it's carefully
designed in such a way that it controls in multiple places whether or not to run
certain code but based on cell selection depending on other variables. But it
does much more of course. Maybe the most important thing is it tells the program
how to draw the arrows but the funny thing is it also tells the program when to
draw the arrows (indirectly - I think?).

In fact with the exception of the non-zero values in the first 14 rows it's hard
to know the value's purpose. But even the first 14 rows is not entirely clear
because I use some of the cells for other things too (and NOT just to know if to
call fscanf() or rather when to call it). And even when you do figure that out,
if you do, it might change right out from under you.

That's because some cells are modified (and I do not even know which ones are
other than some are temporary variables but maybe not all: not sure) and the
cells being modified depend on conditions from OTHER cells that are dynamically
selected and sometimes (if not always?) are also determined in part by cells
that are selected dynamically. And the first cells in this paragraph, the ones
that might be modified, those are ALSO selected dynamically.

Again: it's fun that the coordinates are real coordinates in the world, and on
theme too, as if I recall I do in fact have antipode coordinates of the
continents (plus the antipode of that easter egg location): but of course I
reversed most of them.


<div id="tautological"></div>
As briefly noted above I did something far less common if not new; I added to
the Makefile `-Wno-tautological-constant-out-of-range-compare` so that when you
do try changing the `!=1` you're not alerted to the fact it's a boolean!

Actually it depends on what you change it to whether or not the warning would be
triggered. What is certain is if you remove it OR change the value it no longer
functions (or it shouldn't - I have tried removing it and I have tried changing
the value and every thing broke it: as part of my testing the trickery of
course). But because of this it will make you more likely to not see that it's
boolean.

And on that note, the lie about `d` (even though the comments are actually
telling the truth: misleading comments that tell the truth is rather fun I think
too, don't you?).

I help you 'discover' the 'true' value through those true comments. It's true
that the second and third comment are leaving something out and the Makefile
further improves this, but what the comments say are still true:

- `d` MUST start out at -1 and if you change it the code will break (it might
crash it might just not work);
- you MUST not change `!=1` in main(); if you do then it will also break the
code, causing an error.

The third comment comes right after the dare to change `!= 1` (and the warning
of certain things you might change it to, that's really mean and clever abuse of
the Makefile and even more than that it's totally legal as you're allowed to
disable warnings without any repercussions: unlike using too many macros or too
many `-include`s), reminding you that `d` must truly be 1! That changes
everything. Or it would if it was actually true!

Because of this you might truly believe that `d` is one. But if you do discover
the truth how will you figure out (some might but not necessarily and that
Makefile trick does not help you out) if I can be trusted? See below.

It's pretty amusing that a check for `!=1` means is true when the value is
actually 0!

And if you do believe it's 1: you have to then modify the addresses and other
things, which already are formidable. Since I conceal the ranges it stands to
reason since it does not crash that that out of bound addresses are not
accessed: which makes it even harder to find any pattern, if it's possible at
all!

And there's another devious thing with the true comments that have potential to
trick you that just dawned on me. Let's say you DO figure out it's 1. At this
point you assume I am lying. That's despite the fact that the comments are true.

So how can you trust anything you see at all? And if you can't trust it, how do
you know what is going on?

I thought of having it updated only to be decreased back to 0 again
but this would attract too much scrutiny so I left it at the trap of changing
`!=1` only to cause it to break.

BTW: it was just over three days left when I updated the Makefile to help
further manipulate the challenges in my favour. Very unusual I think.

The hilarious thing is that all the changes of `d` are carefully controlled so
that it remains 0 (after the initial change to 0) UNLESS the pointer is NULL!

Yes code like:

``` <!---c-->

    &S[S[J][d+S[d+*S[*(d+S)[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(*(S+H)+2)][3]]
```

or better yet:

``` <!---c-->
    V =&S[u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]
```

might have a few indirections into the table but those values can change,
especially the last one (certainly the location can but I am not sure which
cells are actually modified though some certainly are), and yet it still works.

What's more is the loops hide how many iterations there are, and with `+ d` it
makes it even harder to reason.  That code actually looks like:

``` <!---c-->
    for ( V =&S[ u][(z=(*(S+4))[*(*(S+3)+1)],S[t][B])]; !(*(S+d)[*V]&*V)&&z<2-*(*(S+5)+3); ++z)for
    (*V=0; *V<d+*(*(S+7)+3); ++*V)if((d+s+S)[z<-*(*(S+4)+3)+1?(z&1)?z-1:z+1:z][(*V&1)?*V-
    1:*V+1])for(M=&S[S[J][d+S[d+*S[*(d+S)[9]**(*(e=c,S+6)+3)]*3][2]]][++h%S[*(*(S+H)+2)][3
    ]],*M=0; *M<5; ++*M)

    /* even more deranged code */
```

So this is much more than obfuscating indirection into a table. That is more
minor yet still formidable as it's only one piece of the puzzle - and there are
a lot of pieces.

It is amusing that `u` and `t` change between calls to `m()` and yet there
actually only needs to be three calls to `m()` yet there are four. So how does
it not draw another arrow in the wrong spot? I am not sure now but it might be
because of a conditional check before it (I BELIEVE that and I believe I talked
about it earlier).

However including that extra call to `m()` (which is indirectly important due to
the side-effects: there are ways to get those as not side-effects obviously but
if you don't see them or just try commenting out the call it'll break) - well
it's totally worth a few extra bytes as it only further hides things.

I have shown much more with the table earlier in the file. It is polymorphic, it
was carefully crafted with real life coordinates, it controls whether code is
run, it controls whether to draw pixels or not (or if not when then at least
HOW), it does things in backwards ways (including actually backwards such as
writing the RGB in the opposite order in memory but with comments suggesting
otherwise, and funny comments that prevent illegal code), selection of cells are
dynamic based on other variables and conditions and other things.

Throw in the misleading (yet TRUE!) comments and the direct manipulation of
pixels without a library and everything else I showcased (and the output of
[debug.c](debug.c)) and you can see there is A LOT going for this program, not
just table related, but even the table itself is used in MANY ways: VERY
different from regular table use (or as the case is table abuse): precisely like
every other table in every other program (or most?), even unobfuscated code.
Because different programs require different things and different data. But
there is no denying my table has MANY uses and is used in MANY DIFFERENT WAYS.

The comment I include at the top:

``` <!---c-->
                                        // I DARE YOU TO TWEAK d
                                             long d  = - 1,
                                  // Map of our Flat Square Earth
                                                 G
                                                ,P,
                                               S[][7
                                              ]={ { 0
                                             , 0,0,25,
                                            0,0, -6} ,{
                                           0,0, 0,4,0,0,
                                          4} , { 7,0,1,5,
                                         0,0, 8} ,{ 1,0,2,
                                        1 } , { 0,0,0,-5,0,
                                       0,5 } ,{ 4,5,7,-5,0,4
                                      ,7} ,{ 0,0,0,-1 } ,{ 0,
                                     0,0,6, 0,0,-1} ,{ 0,0,0,5
                                    ,0,0,5 } ,{ -3,4,80,8,0,2,6
                                   } ,{ 0 ,0 ,0, 1,0,0,2} ,{ 8,0
                                  ,1,6,0,0,2} ,{ -49,0,68,178,0,0
                                 ,6} ,{ 0,0,0,78 ,0,0,9 } ,{ 0,5,1
                                ,4,6,5} ,{ 3,1,16,1,1,0,5} ,{ 1 } }

```

is a joke but it rather foretells what is to come. It really is a map of arrows
which is funny because those arrows tell it how to draw arrows: which brings up
the 'chicken and egg problem'. But it's so much more: almost everything in fact!

The fact I am not even sure if the coordinates stay the same or not is amusing
to me. It LOOKS like they do change, at least some of them, but they're used in
multiple ways including how to draw arrows and maybe if to draw a pixel.
Regardless it works well because it's all carefully constructed.

And my test script and my insanely large values in [antipode.c](antipode.c) show
this even more, though of course for out of range coordinates although it
appears fine (from smaller values) I do not know if I missed something in the
calculations. [antipode.c](antipode.c) suggests it's okay but it of course uses
the same algorithm (just not as messed up in syntax).


[^1] Yes. I know the word is tetrahedral and the object is a tetrahedron! But if
YOU'RE going to make up things about it being hollow or flat then why shouldn't
I make up things too? Why shouldn't I get to have fun as well?

[^2]: If you rip part of a square out you can form a triangle, after all.
