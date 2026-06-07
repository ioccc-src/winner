### On the subject of comments in PPM images and why I do not and should not support them

I talk about comments rather a lot below: sorry but I really want to stress the
point as I do think comments in image files are ridiculous and it would make my
program obscene and extra large and I might have to use the library which is an
obviously bad idea. I don't think comments should be in binary files anyway and
I'll give another classic example of how far you can go with this and in a
dangerous way.

Probably this is UTTERLY pointless. As I [remarked in
index.html](index.html#akari) this not supporting comments in PPM images is
precedented in the IOCCC. That entry was brilliant and it does not support
comments, corrupting the image if it has any (whereas I do report it as an error
except after the header which I can't do anything about anyway) and my program
also supports more (with PPM P6, which is all that would fit with the size rule
and all that is needed) and when there is an invalid header (or size) I also
report it as an error rather than corrupting the image.

Frankly I think that's more than reasonable, with comments. The others maybe not
so nice but arguably a comment in a binary file is already a corrupted file.
Even so with the IOCCC it all is fine in my view.

Nonetheless I wrote this before I discovered those details and I wanted to share
with you why **I** do not support comments and why I don't think I should if I
even could (but can't, especially not with size constraints after what I have
done).

First of all: though the spec (yes this is from the library but if that's not an
authoritative source I don't know what is!) should tell you a lot (emphasis
added by me):

> Strings starting with `"#"` **may** be comments, the same as with PBM.

MAY be comments? How exactly am I supposed to deal with THAT? That would imply
that I have to deal with more than one mode and this is a parser without a
library and with serious size constraints imposed. As I get to later and perhaps
in [index.html](index.html) images do not need comments because images are
viewed in image editors and they show the actual image not the data.

As I note elsewhere later on: in files sometimes `#` exist and
are not part of comments but actually data. The fact the spec is so ambiguous
should say everything about it but it also means you have to modify or strip
things out of the header and that seems to me to be a poor design. Images don't
need comments anyway.

In fact some viewers deal with this header just fine:

```
    P6 1200 600 255 # foo
```

...despite the fact that the header already ended before the `#`, particularly
the whitespace after the 255 (see below for another similar example) and when on
multiple lines like:

```
    P6
    1200 600
    255<space>
    # foo
```

it is NOT legal (the `<space>` indicates of course whitespace: I think the judges do not
like trailing spaces in some cases so I have vim remove them in markdown files).

That is even more ambiguity and the more ambiguous a design (and the fact
DOCUMENTATION says 'MAY be a comment' is hard to fathom) the worse the design
is (that does not mean it's not a good design for the IOCCC though and this also
is a nice excuse to not add even more code).

It's actually not a terrible image format: obviously. But the idea of comments
was not well thought out.

But honestly images are not meant to be viewed in a text editor/viewer BECAUSE
THEY ARE NOT TEXT FILES; they are meant to be viewed in a GRAPHICS/IMAGE viewer
(or editor).  It's in the name I believe? :-)

I already talked about in [index.html](index.html) how I can't do the other formats as they're
too big (and P1 would be criminal abuse of the map). My program is quite robust.
It reports an error (albeit a joke comment about it) if there is a comment so my
code actually handles comments it just does not support them (again except for
after the maxval and whitespace when that whitespace technically ended the
header which is not supposed to have comments in it).

Yet I also read another thing in the standard saying comments could be anywhere.
Ambiguous wording obviously since that is definitely not true.

IF I supported comments it would also ruin obfuscation.

IF I were to support comments I would have to parse tokens one at a time or else
use a library and this is costly.

I also read one place that comments are allowed only after the magic number and
before the dimensions but others say it can be anywhere before the whitespace
after the maxval. Yet as I showed some viewers parse it after the header when
the standard says that is not actually legal!

I do scanning of the header quite nicely and simply using the `*` modifier to
fscanf(): nice and clean and easy. Actually before I discovered that other entry
[I even tried something](#conclusions).

I DO support one line headers and also two line headers as well plus the three
(which that other entry corrupts - again no disrespect to it! I'm only bringing
it up for precedence as I want you to see that I put a lot of effort and time
into it). As long as no comments screw it up of course.

Otherwise, still a comment in the image should report a read error (`"Flat
Earth"`: 'flat' since it was unable to read anything beyond where the comment
is, or rather right before hence a flat file) which is how it should be done
(maybe not in all cases but in cases I tried it did at least); this is because
it will not match the fscanf() format I have used, the most sane one (if not the
only sane one) at that.

To put it more correctly: if the format does not match the `fscanf()` then it is
a read error and you'll find out the shape of our beautiful Triangular Earth.

I'd say that I'd not put it past the judges to try breaking it except I think
they'll rather enjoy this program AND not only that but there is the other entry
and my program has some brilliant obfuscations and other things, to say nothing
of it being beautiful output (and showing a lesser known thing - antipodes).

But still I wanted this to be as sound as possible.

**Obviously** Blue Marble HAS to be used and that one is 255 maxval (and that's
good due to not using a library and having it in an `unsigned char *`) and it
also does not have a comment either. Again I couldn't support those anyway, not
without bloating the program and without breaking obfuscation and other things
including the rules! They're twice as big, images with > 255 (not that most
people think of RGB > 255). I would have to manually construct the tarball and
all tests would fail.

But I doubt the judges really want comments in images anyway even if there was
not precedent. Besides that, and just as importantly: I could do what a lot of
previous winners do: hard code input files. But I am more kind and reasonable
and I'd appreciate reasonableness too. Comments in binary files is not at all
reasonable.

I now have more to say on comments existing. It's against the PPM spec to have a
comment after the header and as I said you should expect invalid results if you
try injecting comments in random places as the full data is not read then (the
header would be lying now wouldn't it? The header tells the code exactly how
much needs to be read and if you put in data that is no longer correct).

The notion images 'need' comments is to me absurd and I'd sooner hard code the
file than allow comments and ruin obfuscation and other things.

That being said even [earth.ppm](earth.ppm) has at least one line which starts
with a `#` but that is part of the binary data. But if you inject something into
it obviously you should expect bogus output if it even reads it okay.

So even if I wanted to be non-standard I can't be.

But of course comments in the header are going to likely result in a read error
anyway. This is an **important** DESIGN choice and it IS handling them: just not
supporting them. There IS a difference (will return to this).

And yes the end of the header is detected: obviously (it's whitespace after the
maxval) but that would not help matters one bit (or any amount of bytes) in
this. When I have finished reading in the header and validate the size I read in
that many bytes (with 3 as the size due to of maxval <= 255).

So I actually do things the right way anyway: if there is an error I handle it
gracefully, unless there is an error I can't actually detect (and for example I
don't say it reached EOF or an error condition was reached nor is there a need
to do that - a read or write error is enough).

I DO however allow the image to have the header on a single line which is
standard it seems (certainly a few viewers deal with it just fine: GIMP and
Preview though they also view images with comments after the header if on one
line). I also write it on a single line to save bytes. Yes, yes comments are
also standard but this is bonkers. Images do not need comments. Images SHOULD
NOT have comments, especially binary images (and the notion of an ASCII image
that's not ASCII art seems to me absurd but as said somewhere in this or another
file the ASCII PPM images, which if any PPM images have to have comments that
would at least make some sense, are much larger so I couldn't fit them in
anyway).

And I could not find consistent details on comment formats anyway so that would
be another issue. Like I said I even found an example that is obviously broken
or at the very least not what it claims.

Having comments in binary files makes no sense at all and I MUST use binary
files. Besides this I supply the image that this program is meant for. It's an
equirectangular map (which I also validate, using bytes I might add), the Blue
Marble Next Generation map, and ImageMagick, when converting the image to PPM,
did not add a comment.

It is only a kind afterthought on my part that I allow you to specify an input
file anyway though this benefited me in the end (at first I actually did not
allow input files to be specified and at first I did not support just printing
the antipodal coordinates).

But allowing for the input file allows for some fun things and the
[try.sh](try.sh) script demonstrates this (and I also included an image that
demonstrates it as well, and more so it demonstrates how you can use the same
source and destination file).

There are many other reasons to allow an input file: if you can find an
equirectangular map of our NINTH PLANET (NOT a 'dwarf' planet) Pluto, or a
real-life Flat Earth map (maybe you can ask the Flat Earth Society?) or some
other world like Middle-earth: despite the fact that Middle-earth is actually
our world in an imagined history.

In [index.html](index.html) I explain how I constructed a map of the different
continents with their antipodes mapped in different colours (up/down arrow same
colour to distinguish but this image will sadly mean that it's harder to see
depending on how you perceive (or do not perceive) the colours in question.

Many other entries in the past have done exactly that though, hard code input files
(and some maybe output files too). I allow input files to be specified but I
also include the file that makes sense for this program. Not including one would
be problematic but including one also uses A LOT of bytes as I showed elsewhere.

It would be silly (though still possible) to use a PPM image that is not a map
assuming it's an equirectangular image (or you remove the check, in which case
expect chaos if you don't do every part right, and it is not done in the most
intuitive way, except one part but I'm not explaining how that works because it
should be obvious, the first part of `m()`, and as for the other checks they're
in different parts of main()).

But like I said I do check the header format. Consider the following image
header:

```
    P6
    1200 600
    # silly comment
    255
```

This should result in 'Flat Earth' error; on the other hand if it's after the
end of the header then as long as enough bytes (based on the width and height)
are read in then there is nothing I can do if one put extra data in the file.

And let's be honest: handling an error gracefully is the right choice. If I
tried to manipulate a file with a comment and it got corrupted that would be an
error. I do not because I simply validate it first: comment is an error. Much
like the standard for allowing them. Of course if it's after the header I can't
help that. See [silly.png](silly.png).

And like I said I wouldn't be able to write the comments either as I write the
header on one line which makes more sense anyway (if it's at the end of a single
line format it reads it in but it probably doesn't read in the full file as the
header is actually not reliable).

Remember that `fread()` does not set the EOF flag (thus I cannot check
`feof(q)`) unless it tries reading past the EOF. If someone adds data to the
file, causing a mismatch between what is read and what the header says then they
should expect bad results. And if they removed data then it won't be the right
number of bytes which is an error.

This is another reason there is no point in checking for `feof()` or `ferror()`
in the case `fread()` does not return the number of bytes expected. It would
serve no practical use: if the user is screwing about with the input then they
know what's wrong; if the file is corrupt then they should know what's wrong;
if the program was terminated due to a signal (for example) then they should
try again; and if their system has a problem they should ask Windows Tech
Support to call them to tell them all about it even if they don't use Windows!

Checking and reporting which it is is pointless and it would also ruin the Flat
Earth joke.

The point is I have done a lot of error checking and I report errors; I don't
need to check what caused the error. I have gone out of my way to detect all
sorts of errors and I think I did pretty good, more than a lot of non-obfuscated
programs do even, and they're not limited in bytes.

Now if you have this:

```
    P6
    # silly comment
    1200 600
    255
```

It also would be an error (slightly different from the above one). If however
you do:

```
    P6
    1200 600
    255
    # silly comment
```

it might corrupt the file or it might change the colour-space. It is also
against the standard. Unfortunately the earlier one is not.

Even so the last time I tried the command on a file (a smaller version of
[earth.ppm](earth.ppm)) it turned out kind of beautiful. I was able to shrink it
way down and convert it to a PNG: yes [silly.png](silly.png).

If you resize it you might do:

``` <!---sh-->
    magick silly.png -resize 1200x600 silly_out.png
```

I just make no guarantee it'll turn out well and in any case it is a corrupted
file because having a comment after the header is not even legal (and some lines
might begin with `#` in a valid PPM file).

But of course not supporting comments and not handling comments are rather two
different things anyway. I do not support them but I give a read error if they
are included (rather: if the header cannot be read in properly which is why the
`#` at the end of a one line header 'works' and also why after the header it
'works' even though it can't rely on the header) in what is arguably a bogus
file.

Writing this I guess if I supported comments I would have to strip them out as
otherwise the header would be a lie (which again seems to be a poor design) and
this would mean I would have to do one conversion at a time.

It's good I report an error and exit instead of trying to allocate the wrong
size and write to invalid memory or corrupt a file. That's how it should be
done. I might even add that another problem with comments in the file is that
since the header has a size the comment means the header is a lie. If a header
has to be modified (or have data removed from it) this is a dubious design
choice.

Critically: if someone wants to put comments in an image file perhaps they
should be doing ASCII art instead since viewers don't even display comments (far
as I know - I have never seen one anyway) and what is the point of an image if
it can't be viewed (and ASCII files I already talked about and they would not be
as lovely either I guess, even if they weren't much bigger)?

And don't try and tell me that normal graphics viewers READ it just fine. These
programs are not limited in the contest size rules and they don't have to worry
about lying headers and other things.

They're not the same type of program.

An image viewer/editor is not obfuscated like this with lots of fun obfuscation
and jokes and what it does is even more fun. As I said elsewhere the way I draw
the arrows I guess would not be possible with the library and the way I have it
looks REALLY nice and it's done in an efficient and compact way.

This is not a graphics reader and I am under size constraints with the statement
from the judges that smaller is better. Also I haven't seen (personally) a
graphics viewer that shows the comments when viewing the image - and what would
the point of that be anyway?

Furthermore it is my belief (and understanding) that the main reason for the
comments (nowadays if not entirely) is for editors to inject nonsense like
'Generated by ...' and thus is irrelevant spam. We don't want that either now do
we?

It also seems to me that comments do not belong in images and the map I provided
is what is (normally) expected to be used. If
[someone](https://www.microsoft.com/) wants to play with comments in images
maybe they should also play with executable code in images too ... [which of course
they do](https://en.wikipedia.org/wiki/Windows_Metafile_vulnerability). After
all, why in our Hollow Earth should <del>that nameless company</del> Microsoft
do something sensible?

If you MUST use an image that has a comment you MIGHT be able to get away with
something like:

``` <!---sh-->
    sed '1,5{/^#/d}'  foo.ppm > bar.ppm

    sed -i '1,5{/^#/d}'  commented.ppm
```

I do not guarantee this. I suspect it will break something. And besides that the
commands do not account for leading spaces, if that is legal, and I do not know
if it is (yes that is possible to fix but it's likely to corrupt the file anyway
and it can't be done much further in the image because some lines start with `#`
outside the header).

Anyway since `fscanf()` will report the number of conversions and I explicitly
check for that and I explicitly check that the number of bytes read in is
correct (and if you have comments in there after the header it could be wrong,
and if before then `fscanf()` should have failed unless you're manipulating it
somehow) it shouldn't be an issue at all.

And that is another thing. If I were to read in tokens I would have to contend
with how many bytes for each buffer and if someone wants to mess with an image
what am I supposed to do when I want the code to be sane and compact and not
rely on a bloated library (which also is far too revealing)?

I thought it might be funny to continue on the idea that the comments are mostly
for editors in putting something cheeky in the output files (from this code),
something REALLY stupid like:

> Generated by IOCCC best antipodal mapper

but not only would that risk rejection for not being what it says but it would
break the program itself. Comments do not belong in images. I do not support it
and in output I certainly do not support it as the standard allows one line
headers too which might or might not cause size errors: as I would have to trim
the rest of that line too.

If you must have comments in images please use a less sensible program that does
the same thing as my program. And by same thing I mean the arrows (in the same
way), the size, the colours (also allowing you to change the RGB values), the
printing the antipodal coordinates, allowing to just print the coordinates,
error checking and reporting: every part of it, and on the same map as well as
EVERYTHING ELSE I do. I guess there is no such program though who knows. Almost
certainly no program that is exactly the same.

<div id="conclusion"></div>

Finally: I actually tried to get it to work SIMPLY with fscanf() but if it did
it'd have to go into alt code. It did not work well though. I would have to, it
would seem, go into a loop and that's only if there is a `#` as I can't know how
many there are.

I could maybe check the first character and then kill that line but
that won't help with it being at the end of the line. But it would have to
actually have any `#` in it which would require pulling in `strchr()` (for the
simplest solution). It won't help with other conditions either.

Even a SIMPLER INCOMPLETE check cost 90 (!) bytes and there were other issues
with it as well. It simply isn't feasible if I want to keep the size down and
the simple facts are:

0. I allow the users to specify a PPM image rather than hard code the filename.
Many past entries do not allow this. Many past entries are custom files. Many
past entries have custom file formats as well. I do not limit you to that unless
it's not an equirectangular image but that is because it is equirectangular
projection (\*HINT!\*).
1. I gracefully exit with an error message if there is a parse error: say
because a comment - though after the header I can't detect that nor should I try
as it's also not even legal - but other parse errors as well. That is handling
them just not supporting them. There is a difference and the way I have done it
is the right approach. I also exit if the image is not an equirectangular image
(see above) or has a maxval > 255 as I should and indeed as I MUST.
2. I do not use the bloated (with no disrespect to the authors) and far too
revealing library but rather read everything in efficiently in an `unsigned char
*`. This is far more
[arcane](https://magicsystems.fandom.com/wiki/Arcane_Magic_&lpar;Dungeons_%26_Dragons&rpar;),
it does not force users to have a library (and so in that way MORE portable as I
don't assume you have the library installed). The contest likes portable
programs and not requiring libnetpbm is a gain; requiring it is a loss.
3. I've NEVER seen an image viewer or editor show the comments exactly because
there is no point in doing so: the point of an image viewer/editor is to show
the IMAGE hence '**image** viewer/editor'. This makes comments almost if not
entirely useless anyway. Have fun actually editing a PPM image in a text editor!
It has binary data.
4. Even so if someone does want a comment then make it the ASCII one. I can't
support that even if it made any sense because it's way bigger. Similarly I
can't support RGB > 255 as that is twice as big and the files are already huge!
Most people don't think of RGB > 255 anyway and most people think of ASCII art
only in the sense of ... ASCII art (how surprising).

And to really put the nail in the comment coffin:

I actually provide the file that the program is meant to use (see 0 above) and
it does not have comments and it is a sane ppm image. And like I said, the library
documentation seems to have ambiguous details on the subject of comments which I
described earlier so it's hard to even be sure of what I should do, even if it
was feasible: which it is not!

...and of course it's the IOCCC so this should not matter, especially with
precedence and the fact my program does not corrupt the image (unless the
comment comes after the header which is technically not allowed and the fact
some viewers terminate it is entirely immaterial) and the one in the IOCCC I
know of, brilliant though it absolutely is, [does](index.html#akari), but that
realisation only came later (thankfully).
