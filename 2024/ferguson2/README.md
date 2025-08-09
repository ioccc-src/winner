## Award presentation:

Watch the [Our Favorite Universe](https://www.youtube.com/@OurFavoriteUniverse)
YouTube show for this entry:

> [IOCCC28 - 2024/ferguson2 - Prize in yil-tas](https://www.youtube.com/watch?v=KmSzapLxDnA)


## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./prog 'some string'
    ./prog +file
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Alternate code:

The author provided alternate code which takes the output of `prog` and decodes
it back to the original input.

### Alternate build:

``` <!---sh-->
    make alt
```


### Alternate use:

``` <!---sh-->
    ./prog.alt 'some other string'
    ./prog.alt +filename
```


## Judges' remarks:

The IOCCC is honored to present this entry with an award that, in turn,
recognizes the [Navajo Code Talkers](https://en.wikipedia.org/wiki/Code_talker#Navajo)
who served with distinction during World War II.

As noted in a [NY Times article on Chester Nez](https://www.nytimes.com/2014/06/06/us/chester-nez-dies-at-93-his-native-tongue-helped-to-win-a-war-of-words.html):

> Not fully declassified until 1968, the Navajo code remains the only oral military
> code that (was) never been broken (in the field of operations).

This submission encodes (pun intended) the basic algorithm used by Navajo Code Talkers
to encode and decode messages.  We invite you to attempt to decipher the C code,
and then to explore the fascinating cryptographic history of [Code Talking](https://en.wikipedia.org/wiki/Code_talker).


### On a personal IOCCC Judge note

One of the IOCCC Judges had the unique opportunity to engage in
discussions with Code Talkers, sharing insights into the intricacies of
the code as well as the practical variations that were developed in the
field between pairs of Code Talkers.

The discussion provided some fascinating insights into the amazing
[Navajo language](https://en.wikipedia.org/wiki/Navajo_language)
including its unique grammar, and examples of some of the intricate
nuances available to a native fluent speaker.  Due to the complex
syntax, phonology, and numerous dialects available in the Navajo
language, the IOCCC Judge was only able to grasp a superficial
understanding of the topic.  Nevertheless, it was evident to the
IOCCC Judge, why the Navajo language developed an ideal Code Talker
framework during World War II, and it is worth noting that
[fewer than 30 non-Navajo individuals](https://archive.library.nau.edu/digital/collection/cpa/id/44718)
could comprehend the language during World War II.


## Author's remarks:


### Navajo Code Talker language of the Second World War

This entry (`ctt`) is a translator of the Navajo Code Talker language used in
the Second World War.

However since the language is too long for the `iocccsize` restrictions I have
had to read in the dictionary from a file (default `dict` defined in the
Makefile so one can override this - if they figure out the format anyway, as
that is also somewhat encrypted, albeit not much, though I explain the details
later on).

At the same time I have made it more fun because I have made it so that one can
translate back and forth words that were not in the dictionary. This is done
because we have the alphabet as well so we can simply spell out words; the Code
Talkers also did this so this is completely in line with a translator. That's
done with the alt code with a different definition of the macro `X`, although as
you'll see there are some differences in the code (not just format but
output too).

A note about the iocccsize and the dictionary. If you take a look you'll see
that the alphabet is in the source code (well some of it: the letters that have
more than one translation only have one again for the reason noted). Actually
the dictionary has the letters too but this is about all I could fit in and it
offers for some fun obfuscation as well even though the alphabet is not
enciphered (there was more than one word for each letter, or at least some if
not all, however, and only one is included in the code).

The program does not include literal translations although it is possible to
modify the code to do this. Instead it is the English to Navajo word that was
used in the military; the literal translation was what it meant in their
language.

With the `DICT` macro the dictionary is not hardcoded although the dictionary is
not English in look. I discuss how it's done [here](#how).


### Who were the Code Talkers ?

One of the original Code Talkers had this fascinating thing to say:

> We acted as coding machines, transmitting messages that would have taken a
couple of hours in just a couple of minutes. We could never make a mistake,
because many communications involved bombing coordinates.
>
>    -- Navajo Code Talker Chester Nez in a 2012 interview with the website ArmchairGeneral.com.


This is one of the reasons I think this language should be in an IOCCC entry:
they were coding machines, transmitting messages that would normally take hours
but they did it in their head in just a couple of minutes!

Chester Nez also wrote a fascinating book (which I highly recommend if the
Second World War is your interest): [Code Talker: The First and Only Memoir By
One of the Original Navajo Code Talkers of
WWII](https://www.amazon.co.uk/Code-Talker-Memoir-Original-Talkers/dp/0425247856/ref=sr_1_1?crid=2CZLDH32F4AFG&keywords=code+talker+the+first+and+only&qid=1689845060&sprefix=code+talker+the+first+and+onl%2Caps%2C457&sr=8-1)
(if you're in the US you might prefer the [US Amazon
link](https://www.amazon.com/Code-Talker-Memoir-Original-Talkers/dp/0425247856/ref=sr_1_1?crid=3BJX333D0QZIW&keywords=code+talker+the+first+and+only+memoir&qid=1689845102&sprefix=code+talker+the+first+and+only+memoi%2Caps%2C229&sr=8-1).

Really funny story he tells in the book, although some of the finer details are
from <https://mishpacha.com/code-talkers/> as it's been so long since I read it
and I don't feel like picking the book up: it was so top secret that when they
were practising on a ship heading to Guadalcanal they were overheard on the
radio but because it was top secret the rest of the ship thought that the
Japanese cracked their communications. They were so concerned at first that they
shut down communication to listen in.

In fact (and this comes from the website): it would appear that one of the radio
operators overheard what he thought was Japanese. The ship's officer thought so
too. Then one of the admirals informed the commanders that there were marines on
the ship who were communicating in their own language.


### But how did it work ?

It had a two layer design. Let's say someone intercepts the word for CODE:
`YIL-TAS`. In the case they don't know what that Navajo word means they're lost.
But _even if they do_ they'll instead interpret it as Navajo for PECK which means
nothing useful in the context of the war.

Not all words had this. For instance CONTROL: `NAI-GHIZ` is the literal
translation of CONTROL.

Some were rather close as well: 'COUNTER ATTACK' was `WOLTAH-AL-KI-GI-JEH`
which translates to 'COUNTER ACT'. If a word was not coded they could spell out
the word which is exactly what I do here as well (as noted earlier, I think).

And on the subject of how it worked: I decided to not put a man page about this
submission because the language was so secret that they could not have a manual
either! I will explain the syntax though which really is all that's needed; that
and the limitations/bugs section (though they're not strictly bugs).


### The Navajo Code Talker's Dictionary

The dictionary can be found at the US Navy history website [Navajo Code Talkers'
Dictionary](https://www.history.navy.mil/research/library/online-reading-room/title-list-alphabetically/n/navajo-code-talker-dictionary.html).
But alternatively you can find it in the file `dict`. Looking at this file will
be useful to help you understand some of the output assuming `dict` is not
encrypted itself (and of course it is but not as complicated as any of the Code
Talkers; see [explanation here](#how)).

From the [Navajo Code Talkers Fact
Sheet](https://www.history.navy.mil/research/library/online-reading-room/title-list-alphabetically/n/code-talkers.html):

> When a Navajo Code Talker received a message, what he heard was a string of
seemingly unrelated Navajo words. The Code Talker first had to translate each
Navajo word into its English equivalent. Then he used only the first letter of
the English equivalent in spelling an English word. Thus, the Navajo words
"wol-la-chee" (ant), "be-la-sana" (apple) and "tse-nill" (axe) all stood for the
letter "a." One way to say the word "Navy" in Navajo code would be "tsah
(needle) wol-la-chee (ant) ah-keh-di- glini (victor) tsah-ah-dzoh (yucca)."
>
> Most letters had more than one Navajo word representing them. Not all words
had to be spelled out letter by letter. The developers of the original code
assigned Navajo words to represent about 450 frequently used military terms that
did not exist in the Navajo language. Several examples: "besh- lo" (iron fish)
meant "submarine," "dah-he- tih-hi" (hummingbird) meant "fighter plane" and
"debeh-li-zine" (black street) meant "squad.

**NOTE**: from the above it might look like the code is wrong, where at least
one letter above is translated wrong. But at least some letters had more than
one translation and it was a matter of choosing one. However from my file, the
word for `YUCCA` was actually `TSAH-AS-ZIH` rather than `TSAH-AH-DZOH`. But if
you try that you'll get `tsah-as-zih no-da-ih moasi moasi wol-la-chee`; to
translate that you can use `./prog.alt tsah-as-zih no-da-ih moasi moasi
wol-la-chee`. The reason it works this way is because that is the **literal**
translation for `TSAH-AS-ZIH` which they used as the letter `Y`. Thus if you do
`./prog Y` you'll get `TSAH-AS-ZIH` and if you do `./prog.alt TSAH-AS-ZIH`
you'll get `Y`.

Additionally, if you try `./prog navy` you'll get the output `tal-kah-silago` as
that **is** the word in their dictionary for `navy` (the literal translation was
`sea soldier`).

**NOTE**: the alt program, which uses very similar code but has to be in an alt
file (`prog.alt.c`) due to the differences and because of encroaching on the
size restrictions of the contest (it's also clearer and easier to maintain for
me even though the most important part is a simple macro of `1` or `0`), will do
these translations. However there are some oddities that will be explained later
in this file.


### Examples

The word 'bikini' is obviously not in the dictionary and not really relevant to
the IOCCC or the Second World War: at least not at the time; however there's a
connection to that word just after the Second World War and believe it or not
it's related to something from the war (yes really: see below!). So how do we
rectify this problem when using the program?

Well since we have the alphabet also we can just spell out words that are not in
the dictionary! Try:


``` <!---sh-->
    $ ./prog bikini
    shush yeh-hes ba-ah-ne-di-tinin yeh-hes tsah yeh-hes

    $ ./prog BIKINI
    SHUSH YEH-HES BA-AH-NE-DI-TININ YEH-HES TSAH YEH-HES
```


Okay but what about the letters? The translation for `shush` (literal
translation) is `bear` and they used it for `B`. So let's try it:

``` <!---sh-->
    $ ./prog b
    shush
```

Okay to then translate it back:

``` <!---sh-->
    $ ./prog.alt shush
    b
```

Or to be less error prone (though this form will not work in every case - I'll
highlight some examples later on):

``` <!---sh-->
    $ ./prog.alt $(./prog b)
    b
```

But here's an interesting one...

``` <!---sh-->
    $ ./prog bear
    shush dzeh wol-la-chee dah-nes-tsa
```

How come if `shush` meant `bear` it doesn't translate to just `shush`? Well
that's because in the war dictionary there was no word for 'bear' directly, only
the literal translation (though there certainly were bears in the war including
the (in)famous [Wojtek](https://www.britannica.com/animal/Wojtek-the-Bear)).
It is the indirection involved with the language and that made it so powerful.

Okay but for the ailurophiles like myself (not that I don't love bears), what
about cats (such as the legend of [Unsinkable
Sam](https://en.wikipedia.org/wiki/Unsinkable_Sam), see [amusing medical record
for Sam](#sam) below for a few laughs)? The word for `cat` was `moasi`.

So:

``` <!---sh-->
    $ ./prog c ; ./prog.alt $(./prog c)
    moasi
    c
```

Of course you might want to print out the actual word so how to go about it?

``` <!---sh-->
    $ ./prog.alt $(./prog cat)
    cat
```

You can of course do this with `bear` as well.

``` <!---sh-->
    $ ./prog.alt $(./prog bear)
    bear
```

If you want to see the alphabet:

``` <!---sh-->
    $ for i in {a..z}; do ./prog "$i"; done
```

...and you'll see the alphabet that happens to be in the code, although that's
in upper case.


#### The etymology of the word 'bikini'

I said above that the garment 'bikini' has a namesake in a product of the Second
World War but what is it? Well there's an atoll called Bikini in the Marshall
Islands that in 1946 the US exploded an atom bomb. The idea of the name of the
garment is its supposed 'explosive' effect. If you didn't know this you now have
an interesting bit of trivia (you know, for the beaches or parties I'm sure you
go to ...  :-) ) where the bikinis are related by name to the atom bomb!


### Difference between `dict` and `dict.orig`

In the original dictionary there are some words that are followed by
parentheses with a letter in it. For instance:

> WITH  BILH(W)    WITH

I am not sure but I believe that might have been another way to say the letter
W but since it could cause problems in output I have removed it from `dict`
(removed the parentheses and what was between them, I mean). It might also be
something else seeing as how there the alphabet is in another part of the file.
In any case we do not need it.


### What about input files ?

Obviously it'd be ideal if one can encipher a file. The question was how to
specify that the input was a file. The prefix `+` seemed reasonable as usually
one wouldn't write a `+` before a word without a space and it saves from having
to write an option parser (or adding to it). There is a subtle point that I
refer to in the limitations.

But what about error handling in file mode? If `getline()` returns < 0 (actually
it returns `-1` on error) it's just skipped. I've never actually seen this happen but I
suppose it could. If it's not a file no text is printed. Of course I don't check
if it's a text only file and it's not even clear what should happen if it isn't.
Like with `cat(1)` and many other tools, don't feed non-text to this program!

File parsing is strange in output, however, possibly due to the shell but it
demonstrates how the strong the language was as a code, and how word boundaries
prove to be an issue.

See the [issue of spaces](#spaces) for more details on spaces which is necessary
in order for the `English<->Navajo` bi-directional translations.


### Questions to ponder as you look at and try and understand the output

Above we saw that the input `bikini` (see above for its relevance) gave the
value `shush yeh-hes ba-ah-ne-di-tinin yeh-hes tsah yeh-hes`.

Now try the input `BIKINI` and you'll see that you will have the same output but
a different case (which was also shown). But can you get it to show other output
that's also equally valid? An earlier version did this but it was changed to
save bytes. Can you guess how? This ability is a fun and very strong feature of
the language.

The alphabet had more than one translation per letter. But as I was pushing the
limits in size (especially considering I wrote this before the size restrictions
were lessened) I had to remove the extra letters. Also it is not clear to me
what letter should even be translated so after the size limit was lessened I did
not put them in. On the other hand I do have them in the file still, just not in
the source code. This also actually increases the obfuscation of the code though
so all the better.

Can you get the program to show literal translations instead? This is actually
much easier than it seems at least for words (including the alphabet) in the
dictionary file. Obviously this can't be done for words not in the dictionary
which is a good reason to not have it; it was a misleading part of the design.

Why does

``` <!---sh-->
    ./prog.alt $(./prog +prog.c)
```

show no spaces (or it shouldn't) and a single line (I think it is only one
anyway) when

``` <!---sh-->
    ./prog +prog.c > foo
    ./prog.alt +foo
```

does? What does it mean? As noted elsewhere it is unrealistic with the [spaces
issue](#spaces) to expect an exact match.

Also: why does the first one seem to show (at least in my systems) what appears
to be files in the directory? Let's just say it's an 'eavesdropping' feature for
a language that was designed to be impossible to decrypt even if it was
overheard, even by the same side (on theme, you see)! Or we could just say it's
an abuse of the shell, especially as it depends on the file's content.

**HINT**: the prog.c has the `*` and so the shell is interpreting that
character! Everything is normal in other words.

The fact is the file is contrary to what they had as they had to do it all in
their head - kind of like you typing the strings. I offer the prog.alt as a
helpful one but due to the way the language worked (including words having more
than one word) there will be oddities depending on how it was done. I did
workaround some of this when it comes to !isalpha() though.

As for the spaces seeming wrong in the second commands I explain why this
happens later in the [issue of spaces](#spaces); it's not wrong. A quick
way-too-simplistic answer: it is because of how the alt code functions with word
boundaries. This is a feature, not a bug!


### Changing the translation to convert Navajo to English

This is very simple to do and it's already done. Simply run `make alt` and use
the alt version of the program; it'll translate translations back to English
(but **not the literal translation!**).

However it should be noted that as there's not a good way to decide word
boundaries so for spaces in some invocations (not all) you have to specify a
literal space. For instance don't do:

``` <!---sh-->
    ./prog.alt $(./prog b " " c)
```

but instead do:

``` <!---sh-->
    ./prog b c > foo
    ./prog.alt +foo
```

The former might show `bc` and the latter will show a space and possibly a
newline.

At various points I had it where you could do the first but it was a battle and
it did not seem worth fighting when I could spend more time on other things like
obfuscating it and submitting it. It also used to read from stdin as an option
but this seemed not very useful and in some cases caused (depending on the
file's contents) the program to want to read from stdin (as I already gave an
example of the shell interfering I won't get into this more). It's not a
limitation and besides they did this all in their head; they had no files or
even computers as we know it.

You might find quotes can cause strange output in some cases (or did - not sure
now). Even worse what happens if the Navajo word translates to one of the
military words but you don't want that? Nothing we can do about that! I don't
even think **they** could have done something about that. That's the multiple
layers of the system/code.


### Literal translation notes

I already hinted at this and asked you to ponder this: but there are actually
other ways you can configure this program so it translates between different
lists. You could (but this is pointless because it isn't authentic then) have it
translate of Navajo to literal meaning. I was seriously considering taking this
out as I don't even like the idea (due to the fact it would dishonour the
language) but technically it's possible with some modifications to the code.


### Notes / Limitations (of the language)

The dictionary file has to be in a specific format. I don't really see this as a
problem but it's worth pointing out that it won't work if the dictionary file is
in an invalid format. It's not necessarily what it seems! But it does also allow
for further obfuscation so it seemed like a good idea.

See the [how the dictionary file works](#how) if you're curious.

Actually if you figure it out you can use this entry to translate other
languages as well! Kind of. As you'll see in the file it's not quite as it
seems. You can indeed make it translate other languages (notwithstanding
diacritics - or actually that might be possible too but not sure of it) but you
have to do a bit of work first. That especially goes because the alphabet (for
words not in the dictionary) would still be spelt out as Navajo Code Talker
language!

Something else about the Navajo language and the case of letters. As I don't
know Navajo I don't know if something I did is strictly correct. As the
dictionary had everything capitalised I took some liberty in not doing this in
that if the input letter or word is lower case it's made all lower case; but if
it's capitalised only the first letter for each word is capitalised at least for
the words in the dictionary (I think I did that). This goes for words in the
dictionary.

An example: in German all nouns are capitalised; this is why `ich` (I) is only
capitalised at the beginning of a German sentence (no, 'I' is not a noun). But
this was also due to the difference in lengths and keeping track. The issue of
length of words will be brought up again.

In the case of titles this might be wrong but I wanted it to read naturally
which (if translated back to English - not the literal translation) would be
better if it preserves the case of the input. This does mean acronyms won't be
all capitalised at least if it's in the dictionary (can you figure why I can't
do that?) but I deem this an immaterial technicality.

Obviously if the dictionary file is missing or invalid format the words will not
work. In this case the program will just spell each word (it might also show an
error but continue to spell it out - for instance if you move the file to
something else).

This is not the fault of the program but the language as well as the environment
and/or user. Well it might do the individual letters right but I'm not sure of
this; it might even do something funny for all I know.

There were spelling errors in the dictionary. For instance they had `straff`
which I can only assume was meant to be `strafe`. Perhaps this is wrong but so
is `straff`. Okay actually `straff` is a German word but it was English, not
German.

Newlines might not be printed well unless reading from a file with the `+`
prefix. They might but might not. It would seem they won't be given that at the
command line as there aren't newlines per se. As I noted in the file mode
section the alt code only prints literal spaces but it also just passes
non-Navajo words as is.

On the other hand one can mix files and input at the command line. Note that
`clearerr()` is called so one should be able to use the file again though I do
not guarantee this part (given that it's closed it's probably especially not
even needed though as it's just opened again).

Due to the nature of the processing if one does specify a `+` before text that
is not a file (user error) and no input following that there will be a blank
line (might be two, not sure) and then nothing else will be printed.

This is because the `+` is separate from the word itself; the letters constitute
a word but the `+` is not even part of the Navajo language (in the Code Talking
sense (if at all?)). The same goes for other `!isalpha()` chars except they will
be printed with words that are not in the language (and I think even those that
are - that was a later addition if so). There's a function that does
an operation similar to `strcasecmp()` but which ignores `!isalpha()` chars so
that `test.` and `.test..` are equal (in comparison, not in output). That's used
in the case of a dictionary word like `B`: hence `./prog ..B..B` should show
`..SHUSH ..SHUSH ` (observe the space after the first one - that's a feature and
is shown elsewhere too, including [the issue of spaces](#spaces)).

I believe that the way it's done (with printing the characters too) one can do
`./prog.alt $(./prog -code)` and get `-code` (this was no always possible but I
believe I added this later on - a quick test suggests it).

Some of the military words are more than one word which can cause a problem;
what could be done? Actually there is a way here but not when reading from
files.

Here's an example of the two:

``` <!---sh-->
    $ ./prog 'COMMANDING OFFICER'
    Hash-kay-gi-na-tah

    $ echo commanding officer > test

    $ ./prog +test
    moasi a-kha be-tas-tni be-tas-tni wol-la-chee tsah chindi yeh-hes tsah jeha a-kha chuo chuo yeh-hes moasi dzeh dah-nes-tsa
```

What happened? It reads in the file delimited by lines and delimits each by
spaces. It does try reading it word by word (by the shell) but it can't handle
multiple words as one word unless it's in the dictionary and one word in the
shell. It needs it to be a single word, hence the `'`s. This will work fine
because it simply leaves them untouched:

``` <!---sh-->
    $ ./prog.alt +test
    commanding officer
```

This will also work:

``` <!---sh-->
    $ ./prog 'commanding officer' > test

    $ ./prog.alt +test
    commanding officer

```

The extra newline is added by the program.

There is a solution to this but it makes it hard to use the program (I think). My
understanding is the dashes were only used in the Code Talking so: make the
multi word military terms not space delimited but dash delimited like the Navajo
language. This would require the input to follow the same format though (e.g.
commanding-officer) which might not always be the way it is and would put a
burden on the user as well. This is actually very easy to change though. Perhaps
it would work better than I expect but it is unnatural and also not the way
their dictionary even has it - there is no dash in the 'commanding officer'.

Whereas they could control the boundaries, we cannot, and even though they wrote
down the translation, they were familiar with the language and they added spaces
where necessary. Unfortunately in order to translate we have to have some kind
of delimiter and what would it be if not space?

Mostly the problem is when trying to decipher an already enciphered string - due
to word boundaries. Sometimes (not now) adding a literal `" "` as a word
separator would help but as I think I said before it was a battle, where it
might break one thing to fix another, and I got tired of trying to make it
perfect as it probably shouldn't even be perfect due to the nature of the
language. Mostly this is if you do it like this:

``` <!---sh-->
    $ ./prog.alt  $(./prog b " " c)
    bc
```

This works fine though:

``` <!---sh-->
    $ ./prog b c > foo

    $ ./prog.alt +foo
    b c

```

That might or might not be the shell messing things up.

What about not spelling out words not in `dict` (leave them untouched)? This
could be done easily but it wouldn't be authentic so I've not done it (in
prog.c). On the other hand:

``` <!---sh-->
    $ ./prog.alt  a b
    ab

    $ ./prog.alt  a " " b
    a b
```

work fine because there is no translation being done!


### Portability

**DON'T EVEN THINK ABOUT** using this on non-ASCII systems; it heavily abuses
arithmetic on strings and other calculations. It might require two's complements
as well but I'm not concerned about either as other systems are rare now, if
that's the case - I am not even sure of what all I did, a reasonable symptom of
writing confusing code a long time ago.


### Bugs / Mis-features / Limitations

There are a few things I've not touched upon in other sections that might appear
to be bugs and some that some might argue as bugs but might be called features
as well.

Here's a fun one. Why:

``` <!---sh-->
    $ ./prog include
    el-tsod

    $ ./prog '#include'
    #el-tsod

    $ ./prog b
    shush

    $ cat foo
    #include
    b
    #yeh-hes tsah moasi nash-doie-tso no-da-ih chindi dzeh
    shush
```

In other words, why does it spell it out words but letters seem to be untouched
(or some - are all?) when reading from a file?

This is a challenge I am giving you for you to figure out when it comes to file
mode! Can you actually get it to do what else you might (or might not) prefer?
And before you say 'bug!': would I really even offer file mode when they did not
do this with computers (they did it in their head), if this was a bug? I didn't
think so :-) Carrying on...

The OS will have to deal with some memory leaks; some memory is freed but I was
not able to free all due to the large amount of data (I could have just read it
all in but I wanted to show that I was not trying to abuse the size limit - even
though other entries in the past have read in dictionary or similar files) in
the code along with needing more bytes for obfuscation and so reaching the size
limit.

It was even worse when the size limit was more strict (I started this
before that happened and then put it out of sight for a while). Memory from
`getline(3)` should be taken care of but the linked list and its associated
memory is/are not freed. Actually below you'll see in some cases a memory error
occurred but that no longer happens (except due to the bug **in `getline(3)`
itself**).

And on that subject of `getline(3)`: there is actually a bug in it, at least in
some systems; this was actually [reported as a
bug](https://inbox.sourceware.org/glibc-bugs/bug-28038-131@http.sourceware.org%2Fbugzilla%2F/)
(not by me but someone else).  It's reported by valgrind and unfortunately
adding a workaround broke the output. It was driving me crazy until I finally
tracked it down; I was sure my code there was fine but I could not discover it
until I dug deeper and saw it was a reported issue.

Yes I realise that bug report is from 30 June 2021 and it's in status
'UNCONFIRMED' but the report describes the exact same symptoms.

Anyway valgrind will (did?) if reading from an affected file report:


```
    Uninitialised value was created by a heap allocation
    ==1271819== Conditional jump or move depends on uninitialised value(s)
```

The function (`Y()`) is the function that does the comparison without caring
about non-alphabetical characters (I think?). It doesn't seem to be that I do not use
`strdup()` prior to the `strtok()` and in fact using it **caused** a read error so
that was obviously the wrong choice as well (plus it's unnecessary in this case
and it allowed more functionality and obfuscation). If I recall correctly that
was the `a->A` prior to using `strtok()`.

And besides the bug report for `getline(3)` it works fine if there is text on
the last line. And like I said I can add a workaround which if the length read
is > 0 zero out the `buf[len-1]` but this breaks the output of the program so I
don't do that. Actually as I recall the error still happened if I checked the
length > 1! Nonetheless it breaks the output if it's 'fixed'.

Multiple systems have not shown any behavioural issues **unless** I add that
workaround. In any case valgrind reports no additional issues.

Now: why does the alt version sometimes show words that are English in English?
It's not actually a bug but maybe it would appear to be. I already showed this
and gave a brief explanation but there are also other occasions it can occur. It
can also depend on the input/command line itself (and for instance because it's
translating back to English so if it's English there is nothing to do - which
brings up an interesting quest of how does it know that?).

A command line that does not make sense:

``` <!---sh-->
    $ ./prog.alt b $(./prog)
    b
```

Actually what is happening is the `./prog` part is
empty string so `prog.alt` is simply printing all it can print, no translation
at all (notice the `b` prior to the `$(./prog)`! Try breaking it up:

``` <!---sh-->
    $ ./prog.alt b
    b
```

Why? Well again there is no translation to do! Now what does `./prog` by itself
do? It is an empty string (or maybe just a newline), as noted. Thus this does
make sense:

``` <!---sh-->
    $ ./prog b
    shush
    $ ./prog.alt $(./prog b)
    b
```

(which I've shown before.) Is this a bug?

``` <!---sh-->
    $ ./prog.alt hat
    hat
```

Nope. It's because there's no translation to translate back into English so it
just passes it as is.

Here's a translation:

``` <!---sh-->
    $ ./prog.alt $(./prog code file)
    codefile
```

Uh oh! What happened? Well I already explained this part (and much more detail
in the [issue of spaces](#spaces) section). Fixing this caused
other things to break and going back and forth with the twisted code was doing
my head in so I had to stop. It was at one point possible to do `./prog code " "
file` and at one point it had the space there but that made reading from files,
which seems more useful to me, have bad output. Note the issue here: both `code`
and `file` are actually in the language: yes when I say they had no files I
meant no files to read from like we have on our computers.

It is possible to do that
directly though as I showed (earlier I think). This will work though:

``` <!---sh-->
    $ ./prog.alt $(./prog code.file)
    code.file
```

**THIS** works too:

``` <!---sh-->
    $ ./prog.alt shush " " chuo
    b f
```

as does:

``` <!---sh-->
    $ ./prog.alt +foo
    b f
```

(assuming `foo` has the right content of course.)

As a consequence of how the words have to be tokenised you have to be careful if
you want a translation. For instance don't do:

``` <!---sh-->
     ./prog code.file
    moasi a-kha chindi dzeh .chuo yeh-hes nash-doie-tso dzeh
```

(but notice how the command `./prog.alt $(./prog code.file)` does work where it
'translated' it back to `code.file` - can you figure out what is **really**
happening there?). This is because there is nothing breaking the word apart. The
`Y()` function does check for matches ignoring `!isalpha()` but what is it
comparing against? Again if a known delimiter could be specified this could be
resolved but trying to do that would assume the user's intentions. It is better
to require a space than to do that. You can do this instead:

``` <!---sh-->
    $ ./prog code . file
    yil-tas . ba-eh-chez
```

or even better:

``` <!---sh-->
    $ ./prog code file
    yil-tas ba-eh-chez
```

BTW: don't try this:

``` <!---sh-->
    ./prog +prog.c > foo
    ./prog.alt +foo
```

without anticipating an extra space issue. Unfortunately this is **necessary**
because the only sane delimiter is a space. In particular, if you take a look at
the file `foo` (after the `./prog +prog.c > foo`) you might pick up on why this
happens. In fact somewhere in this file I showed the same thing at play (or I
think I did): it's a matter of word boundaries with the letters; since the words
have to be spelt out the spaces are there! That is a feature, not a bug.

Frankly I prefer the look here though I'll return to that idea later on.

Without the space the match cannot occur (although an example above would seem
to belie that, which just adds to the obscurity of my program).

There was a way I played with but it was too cost prohibitive in size, it was
problematic and I could not determine all edge cases. Besides like I said and
demonstrated the spaces **need** to be there (with more space it **might** be
possible but that is not the case).

Other cipher systems work differently and don't rely on two sets of ways to go
about it - it's one or the other (there might be exceptions but for instance
rot13 and Enigma both have a one-to-one mapping - okay the Enigma had many
possible combinations for the same word depending on what came before it but you
know what I mean; as long as the settings are the same you can derive the same
result). As I note elsewhere they actually had more than one word for letters
too and I have made them in an array which means that not all translations are
even used.

The real trouble, basically, is that a word can be spelt out OR have a
translation so a choice had to be made. I chose to spell things out without
having to write an even more messed up parser (though as I note later on I tried
it it just caused even more problems than it was worth).

So this is a feature, not a bug!

You can summarise the above with the following statements:

- When translating to Navajo (prog, X=0) if the word is not in their dictionary
it will spell it out, each letter (a word or words) being separated by a space.
- When translating to Navajo (prog, X=0) if the word IS in their dictionary
print out the Navajo word (sometimes with a `-` in it).
- When translating Navajo to English (prog.alt, X=1) with a known Navajo word
(in the Second World War sense) the translation is printed without spaces, as
the words are on a space boundary and since it's not a letter-by-letter basis
with known translations, there is a single word (or words in some cases, maybe,
although I don't recall that) printed (though depending on input it might or
might not have the space there - I showed an example above).
- When translating Navajo to English (prog.alt, X=1) but there actually is no
original translation, it prints each letter separated by a space (well if you
have an explicit space there like I showed above). If you can figure out why
this happens you have a bit better understanding of the function `I()`. Okay
actually one can do things like `./prog.alt $(./prog book)` and get `book` when
`./prog book` will print out each letter but you saw what I mean here.
- Because of having to deal with `!isalpha()` characters in input (at least to
be the most user-friendly - I could have avoided it to make it more like 'the
real thing' but that would have prevented other features) the `Y()` function
will ignore those characters (though in the front of the word `I()` should print
it). Also if a translation is found it might remove some of the characters that
are not part of that translation (or it did - it might be different now but as
they didn't have to deal with files or grammar, doing it all in their head very
quickly, the fact it sometimes does it fine is a kind afterthought on my part).

Oh and as far as tokenisation goes: it occurred to me that even this will not
always work. I was playing with the idea of having output tab separated: then I
could use `strtok()` on the input and do it that way. It was looking somewhat
promising and then it occurred to me that while this might help with the
program's output (though making it harder to read for most people) it won't help
if someone puts in the string manually! So there really is no way to deal with
this satisfactorily in ever case and trying to do so actually takes away from
the brilliance of the language. And we don't want that, do we? :)

Spaces shown now are necessary and in the case where spaces are not shown but it
seems like they should be, that is an unfortunate technicality that's a feature,
not a bug.

Actually if the spaces are not precisely correct it can cause gibberish to
appear and the fact is the only gibberish we see is the language, and it's only
gibberish if you don't know the language!

To the Code Talkers the issue of spaces and grammar was entirely inconsequential
anyway because it was done all in their head, kind of like as you're reading
this very sentence (even if you read it out loud the spaces and grammar are only
visual aids to help you so
`youdonthavetoreadsomethinglikethisuntilyougetaheadache` - as most people,
although I am a rare exception, cannot read well without spaces between words)
and therefore they are inconsequential to us too.

The language was not to be understood by any others and it was very successful
at that; thus you do need to expect some oddities when it comes to printing
words that are not in their dictionary. This is a feature of the program and it
can actually result in some fun output! This is part of the obscurity of the
program and the language as well.

This is also why I tried to put a lot of whitespace in the program code, just to
really drill it into your head that spaces are both important and not important,
depending on the context, and depending on what is needed. Since you won't be
speaking out the code, spaces don't matter any more than they matter in the
output. In other words, spaces don't matter. But they also matter as they are
necessary for translation to work.

For more details on the real problems with the spaces and why only alt code
might be considered, see later in this file in the [spaces issue](#spaces)
section.


### Obfuscation

This section might not be complete. This is because I added a heavily commented
[deobfus.c](deobfus.c) file and although it's not technically deobfuscated the
comments might help explain some of it. Though as you'll see even some of it I'm
not sure about; by looking at this file you will probably curse me and you might
have some kind of respect (or awe) but you'll also see just how twisted this
code is (and how messed up I am, presumably). It is truly awful and I'm
extremely proud of it. I don't think I could do this again as I have no bloody
idea how I did it. I have no idea how I came up with the calculations let alone
anything else that's obscure.

Please, if you do read it, and I know the judges will at least, take care and
maybe eat some great chocolate (like the final comment suggests) after doing so
as you might need it. It was really hard for me to go through and I had to go
through it more than once after making some significant changes (and fixes) to
the code (when printing files it used to add an extra space to the beginning of
lines after the first line, for example) I have provided the file as the judges
now appreciate educational value and also because by commenting it I could show
the obfuscation techniques in the code itself, plus it is so twisted it amuses
me (sorry if I stress anyone out). Nevertheless I will try and list a few
things, some of which were not mentioned in the code (I think).

I might also add that if there is some inconsistency it came later on though I
don't think there is any.

The `dict` is kind of obfuscated. Not really but kind of (see [how to unravel
it](#how) if you wish to know). Even after you figure it out though it won't
help you understand the program.

`main()` is rather funny. Who cares about 'possible' misuse of comma operator,
unused parameters and bitwise negation of a boolean expression if it hides
details? Comma operator is used elsewhere as well but who cares? Actually the
great thing, which is discussed in the Compiling/Warnings section, some warnings
actually, if fixed, **WOULD BREAK THE CODE** (and none of them are relevant in any
case); some can be silenced by casting to void but even in some of those cases
the warning is incorrect in what it's saying.

That includes 'unused value' or should I say '"unused" value'?

The array `B` won't make any sense to most people. How I use it probably is not
exactly clear either. Earlier on I had words of the Navajo language as variable
and function names but I couldn't do everything I did without changing it; in
fact when I originally wrote it before the change in size limits the program was
pushing the limits and obfuscation was not as good and there were several bugs
to fix as well, leaving virtually no space for obfuscation!

But of course single letter names don't convey anything either.
But before I can discuss anything else I better discuss the anonymous struct
that holds state that can vary from function to function. Here are some
examples.

``` <!---c-->
    F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));

    Z(&(struct a){ .v = { t, I } ,.l=c, .h=a} );

    if &lpar;a->v[2]&lpar;&&lpar;struct a&rpar;{ .w=a->a->w, .c=a->x} &rpar;&rpar;

    c->w = strdup&lpar;X?a->v[a->l]&lpar;&&lpar;struct a&rpar;{ .s=a->S} &rpar;:a->v[a->e==0]&lpar;&&lpar;struct a&rpar;{ .s=a->N} &rpar;&rpar;;
    c->c = strdup&lpar;X?a->v[1]&lpar;&&lpar;struct a&rpar;{ .s=a->N} &rpar;:a->v[a->l]&lpar;&&lpar;struct a&rpar;{ .s=a->S} &rpar;&rpar;;

    while (a->S)
        if ((a->y=strdup(a->S))) {
            (*a->v)(&(struct a){ .v[2]=Y, .x=a->y} ); a->S = strtok(0, " \t"); free(a->y); a->y=0;

```

These are truly nasty beyond the look because what it does is it allows me to
have the same data in a struct (outside the struct **and** in a sense in the
struct) do **different things in different places**. In fact the only reason I need
the two variables `struct a *f` an `struct a *c` is because of the linked list;
everything else is anonymous in the functions!

Here are some funny statements / expressions:

``` <!---c-->
    o = *"";

    s=z+-*"1"-*"1"- -97,L=putchar(!s&&isupper(a->x[0**"z"])?a->a->c[s]:tolower(a->a->c[s]));

    c = calloc(1**"0"-47, sizeof *c);

    for (a->a = f, z = 0**"1"; a->a; a->a = a->a->e)

    for (z = 2/ *"z", s=1+0**"1"; z[a->x]; ++z)

    for (J = *"1"-*"1"; J < 26 && B[J][X?1/ *"1"+s/
            *"1"+1/ *"1"+s/ *"1"+1+(s-s)**"1"+(s*(s-s))**"1":((((s-1)**"1")**"1")**"1")**"1"]; ++J)


    (((*a->h[--a->l]=='e'-':')&&(*a->v)(&(struct a){ .v[0]=I, .s=((a->l)[a->h])+1} )
      &&++a->l&rpar;||&lpar;a->v[1]&lpar;&&lpar;struct a&rpar;{ .v[2]=Y,.x=&lpar;&lpar;a->l&rpar;[a->h]&rpar;} &rpar;,++a->l&rpar;&rpar;; if &lpar;g&rpar; puts&lpar;""&rpar;; }

    if (*B[J][0+*"1"-*"1"] == toupper(z[a->x]))


    for (k = (s*2)**"9"-171+*"9"; H=B[J][X?*"1"-49:s/ *"1"+s/ *"1"+1/ *"1"+(s*s*s)][k]; ++k)

```

And you really thought you couldn't mix arithmetic and strings in C? Now that you
know better can you tell me what's going on or keep track of what it's doing? In
some cases it's actually nested but with this there are few numbers that are
what they appear to be.

Some of these are really funny (and a bit nasty) because if you try removing
spaces you'll turn the expression into a comment! If you need help in
unravelling these, I gave it my best go in [deobfus.c](deobfus.c); but as it
says there some of it I really cannot parse well - some of it seems so wrong and
yet what looks 'right' is wrong (for instance it looks like `-1` will be the
index in an array but trying to 'fix' it will break the code).

Fun fact: in C, the following are both legal:

``` <!---c-->
    char **c;

    char * *c;
```

(in particular, the whitespace is allowed, although in **some** cases it can cause
unexpected output). So in my code depending on the command, for example:

``` <!---sh-->
    ./prog.alt $(./prog +prog.c)
```

will show funny output (remember also it ends up passing `*` to the shell!)
whereas:


``` <!---sh-->
    ./prog.alt +prog.c
```

won't.

As for the `*` in the code causing the shell to show files in the directory
interspersed with other text (which I think is hilarious but not the fault of
the program) there are other funny things that can happen due to the shell and
command line. For instance I have at times seen `returnreturn`!

Consider this a fun Easter egg, if your system is affected, that I chose to keep
because the formatting was more important and output is actually correct when
not abusing the shell. Considering too I was able to spell out `IOCCC` in the
formatting of the code which I might not have been able to do as easily is
another reason for this.

Compress some if/while loops with `&&` and comma operator. The biggest example
is the while loop in `Z()` which acts on the argc/argv of `main()` (and the loop
condition increments, then the body immediately undoes the increment and then at
the end redoes the increment so that at the next pass the `c` (argc) is back to
where it was left at the start of the loop body) which is a single statement but
which would normally be several. Also in `Z()`: why is this valid?

``` <!---c-->
    while (a->h[a->l++])
```

How is `a->h[a->l]` set to a safe value? Well in `main()`:

``` <!---c-->
    F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
    Z(&(struct a){ .v = { t, I } ,.k=0, .l=c, .h=a, .j=f} );
```

The `c` (which is the `argc`) is set to the correct value. Of course that
expression is insane. The [deobfus.c](deobfus.c) explains just how nasty this
really is, particularly for the `Z()` function.

Can you explain this behaviour?

``` <!---sh-->
    $ echo $(dirname $(type -P file)/$(./prog file))
    /usr/bin/file

    $ $(echo $(dirname $(type -P file)/$(./prog file))) prog.c
    prog.c: c program text, ASCII text
```

when this happens?

``` <!---sh-->
    $ ./prog file
    ba-eh-chez
```

And yes here again `file` is used but not in the way we know it on our computers.

What is:

``` <!---c-->
    putchar(('\0'+'!'-1));
```

? It is a screwy call to `putchar(' ');`. Obviously this requires ASCII but that
should be obvious with some of the other ways the code works too. The fun thing
is how I formatted the code I was able to make it look like I did
`putchar('\0')` - or at least it starts to look that way!

All the functions besides main return a `char *` and take a `struct a *`. But
rather than poison the structs needed for operation, the functions are called
with anonymous `struct a *`s with the specific values set in the function call
themselves. For instance the following will create call a function `foo` that
takes a `struct bar *foo` with an `int baz` set to `1`:

``` <!---c-->
    int foo(struct bar *foo)
    {
        return foo?foo->baz:-1;
    }

    foo(&(struct bar){.baz=1});
```

Why make extra objects when we can use anonymous objects, especially when it the
latter is far more obscure and much harder to keep track of? And why poison the
structs when I can poison your mind's ability to parse the code? Thank you very
much to the C standards body for what probably was a terrible idea (except for
the IOCCC)! (Though I can think of a few cases it might be useful it's clearly
bound to be abused - and I believe this is the first time in the contest's
history it was though I might be wrong.)

A special mention is due I think as well. I noted this in the
[deobfus.c](deobfus.c) file a bit but I want to elaborate a bit more. In
`main()` I do something extremely nasty so that `Z()` (which is also extremely
nasty, see below) works right without accessing invalid memory.

The function call:

``` <!---c-->
    F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
```

does a number of things but one of the things it does is it sets up `c` to be
valid for the call to `Z()`. `c` is `argc` in `main()`. As above, `Z()` is
called like:

``` <!---c-->
    Z(&(struct a){ .v = { t, I } ,.k=0, .l=c, .h=a, .j=f} );
```

That's fairly simple but `Z()` itself is nasty. This is what it looks like:

``` <!---c-->

    char *Z(struct a *a)
    {
        while (a->h[a->l++])
            (((*a->h[--a->l] == 'e' - ':') && (*a->v)(&(struct a){ .v[0]=I, .j=a->k,.s=((a->l)[a->h])+1 } )
            &&++a->l&rpar;||&lpar;a->v[1]&lpar;&&lpar;struct a&rpar; { .v[2]=Y, .x=&lpar;&lpar;a->l&rpar;[a->h]&rpar;,.z=a->j } &rpar;, ++a->l&rpar;&rpar;;
             return "";
    }
```

So in this function `a->h` is `argv` from `main()` and `a->l` is `argc` from
`main()`. What I am doing with this:


``` <!---c-->
    (a->h[a->l++])(((*a->h[--a->l] == 'e' - ':') && (*a->v)(&(struct a){ .v[0]=I, .j=a->k,.s=((a->l)[a->h])+1 } )
            &&++a->l&rpar;||&lpar;a->v[1]&lpar;&&lpar;struct a&rpar; { .v[2]=Y, .x=&lpar;&lpar;a->l&rpar;[a->h]&rpar;,.z=a->j } &rpar;,++a->l&rpar;&rpar;;
```

is quite devious. We all know that the order of evaluation in functions is
unspecified (or was it implementation defined?) but am I actually doing this?
In fact I'm not (but see below): I'm circumventing this by using
short-circuiting rules and the comma operator, ensuring that the order **is**
specified and also **extremely** hard to parse (the constant updating of argc
makes it even worse, see next part). The reason for the comma operator on both
parts of the expression (that is the lhs and rhs of the `||`) is to ensure that
the argc (`a->l`) is incremented no matter what.

More so, I'm not even sure the order of evaluation matters here as there is only
one function parameter for all the functions besides `main()`, and it's a
`struct a *`; but if it does matter I'm circumventing the problem anyway by
short-circuiting it and using the comma operator, both of which control it to
the way I need: if the lhs of the lhs fails I still update argc and if the lhs
fails itself the rhs is done but if the lhs of the rhs fails the argc is still
incremented for the nest iteration in the loop! How is that done?

Well on the lhs if the first char of the current arg is a `-` it will call the
appropriate function (`t()`), which because it will never return NULL the argc
will be updated; but if it fails, which means the first char of the current arg
is NOT a `-` then the function `I()` will be called, and this too will never
return NULL. But in that case I use the comma operator instead of `&&` to update
argc.

The use of the highly nested `()`s and the anonymous structs and the
short-circuited logic along with the comma operator makes it really hard to
follow but it also controls everything in precisely the way I need it.

Oh but there's even more in that code...

Did you notice that in the call to `Z()` it sets the anonymous struct `j` to `f`
and `k` (all of which are a `struct a *`) to 0? Now what happens in `Z()`. First
this part:

``` <!---c-->
    (*a->v)(&(struct a){ .v[0]=I, .j=a->k,.s=((a->l)[a->h])+1 } )
```

calls a function (I'm trying to finish this up and I added this late so I am not
even sure which one exactly even if I said it above or have it in the commented
code) and in **THAT** function the `struct a *` (again anonymous) has the `j`
pointer (a `struct a *j`) to `a->k` which was set to 0 in the call to **THIS**
function. This might be called a red herring though because right after that you
have:

``` <!---c-->
    &lpar;a->v[1]&lpar;&&lpar;struct a&rpar; { .v[2]=Y, .x=&lpar;&lpar;a->l&rpar;[a->h]&rpar;,.z=a->j } &rpar;
```

which sets in **THAT** function `z` to `a->j`. With the formatting above it's
bad enough but in prog.c it's even worse. Now then the function that this calls
is `I()` (I think the other one might be `Y()` but I'm not sure - in any case it
doesn't matter as the pointer is not needed there or if it is it's not used by
that name) and that does:

``` <!---c-->
    ... for (a
    ->a
    = a->z,
    z =
    0*
    *""
    "1";                    a
    -> a; a ->

    a = a->a->e) {
    ...
```

which means that in `I()` the pointer `a->a` is set to `f`.


### Format of code

It's kind of crazy too though not as crazy as the code itself. Besides the
spaces (to point out that spaces in the code are both important and not
important - or important in the output but not necessarily in the code - or is
it perhaps vice versa? Neither? Both?) there are some fun shapes and things
spelt out.

There is an arrow in the code.

There is an I in the code. Well okay it's actually `IOCCC`. Actually that's
still not accurate! It's `IOCCC CCCOI` (I think - that's what I aimed for)!

If you use your imagination you can kind of see a Christmas tree (though that
was quite by accident) (I suppose the arrow could also be seen as a Christmas
tree if modified a bit or you imagine a thin trunk). Another fun thing to point
out:

``` <!---c-->
        * *

      "9"-15u/
```

kind of looks like a face (perhaps a hooded face?).

As for prog.alt.c: I thought another approach would be fun. The judges don't
like submissions that are just lines merged but since this is just alt code
(though useful in the submission) and since it took a lot of time and energy to
format the submission code, I joined the lines mostly and removed all the spaces
that were possible (I think I managed that). This is an interesting exercise as
you can see that there are a lot of places that are untraditional (in code) but
that **must** have spaces. Obviously things like `struct a` cannot be `structa`
but consider the `/ *`: there are at least 10 of those (I think?) that cannot
have the space removed because doing so would turn it into a comment! Although
some of the same expressions are used they are not all the same expression. This
happens in prog.c though I did not count them (and I have a headache, probably
from the code, so maybe I miscounted). Another place a space is required (also
in prog.c):

``` <!---c-->
    s=z+-*"1"-*"1"- -97,L=putchar(!s&&isupper(a->x[0**"z"])?a->a->c[s]:tolower(a->a->c[s]))
```

and the reasons are obvious! I am not sure now if there are other places though.


### Compiling and warnings

If `DICT` is not defined it is defined as `"dict"` so it's not really necessary
if running the program from the same directory - as long as the file exists of
course.

When I tested this with `clang -Weverything` in macOS (no guarantees the judges
will experience precisely this - and in fact this might have been with macOS 14,
not 15, although it works fine with 15.5 and presumably in between those
versions and possibly - and I'd guess likely - earlier) **NO FEWER THAN THREE
COMPILER WARNINGS ARE WRONG** (actually a fair few more depending on how you
count them) and if these were 'fixed', it would **BREAK THE CODE**, potentially
if not outright (in fact some absolutely would)!

One even would be removing the `,` for a function call (well, not really a
function but the side-effect is **NEEDED**). That's the ridiculous `-Wcomma` one;
it's also triggered elsewhere but the side-effects are also being used there and
as you saw in the Obfuscation section one place this is used to circumvent the
order of expressions in function calls being unspecified (though that might not
even be necessary - not sure now).

Some warnings also appear with `gcc` instead though and some might appear with
both; it's hard to keep track but here is a list of warnings I have disabled.
The warnings were before I formatted the code and I added obfuscation in at
least one. I'll note that below.

Note that this was before formatting and maybe I did change some code although I
doubt it.

This is warning is **WRONG**:

```
    prog.c:32:22: warning: possible misuse of comma operator here [-Wcomma]
       32 |                 s=z+-*"1"-*"1"- -97,L=putchar(!s&&isupper(a->x[0**"z"])?a->a->c[s]:tolower(a->a->c[s]));
          |                                    ^
    prog.c:32:3: note: cast expression to void to silence warning
       32 |                 s=z+-*"1"-*"1"- -97,L=putchar(!s&&isupper(a->x[0**"z"])?a->a->c[s]:tolower(a->a->c[s]));
          |                 ^~~~~~~~~~~~~~~~~~~
          |                 (void)(            )
```

and `-Wcomma` is one of the most ridiculous warnings of many other ridiculous
warnings. It would appear that adding that cast might silence the warning but
it's not the only one and it's totally bogus anyway.

This is **ALSO WRONG**:

```
    prog.c:48:38: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
       48 |                     for (k = (s*2)**"9"-171+*"9"; H=B[J][X?*"1"-49:s/ *"1"+s/ *"1"+1/ *"1"+(s*s*s)][k]; ++k)
          |                                                   ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    prog.c:48:38: note: place parentheses around the assignment to silence this warning
       48 |                     for (k = (s*2)**"9"-171+*"9"; H=B[J][X?*"1"-49:s/ *"1"+s/ *"1"+1/ *"1"+(s*s*s)][k]; ++k)
          |                                                    ^
          |                                                   (                                                   )
    prog.c:48:38: note: use '==' to turn this assignment into an equality comparison
       48 |                     for (k = (s*2)**"9"-171+*"9"; H=B[J][X?*"1"-49:s/ *"1"+s/ *"1"+1/ *"1"+(s*s*s)][k]; ++k)
          |                                                    ^
          |                                                    ==
```

and 'fixing' it (especially the last part) would **BREAK THE CODE**! It's
assignment **AND** (implicit) comparison, not just a comparison, and the
parentheses are pointless. The assumption it is meant to be an equality test is
also absurd.

This warning is **ALSO WRONG**:

```
    prog.c:137:44: warning: bitwise negation of a boolean expression; did you mean logical negation? [-Wbool-operation]
      137 |     F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
          |                                            ^~~~~~~
          |                                            !
    prog.c:137:46: warning: bitwise negation of a boolean expression; did you mean logical negation? [-Wbool-operation]
      137 |     F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
          |                                              ^~~~~
          |                                              !
    prog.c:137:13: warning: bitwise negation of a boolean expression; did you mean logical negation? [-Wbool-operation]
      137 |     F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
          |             ^~~~~~~
          |             !
    prog.c:137:16: warning: bitwise negation of a boolean expression; did you mean logical negation? [-Wbool-operation]
      137 |     F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
          |                ^~~~
          |                !
```

and 'fixing' it **WOULD BREAK THE CODE**! No I did not mean logical negation and
the assumption here is ridiculous as well.

Additionally, this warning is **ALSO WRONG**:

```
    prog.c:137:52: warning: possible misuse of comma operator here [-Wcomma]
      137 |     F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
          |                                                    ^
    prog.c:137:8: note: cast expression to void to silence warning
      137 |     F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
          |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          |        (void)(                                     )
    prog.c:137:58: warning: possible misuse of comma operator here [-Wcomma]
      137 |     F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
          |                                                          ^
    prog.c:137:53: note: cast expression to void to silence warning
      137 |     F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
          |                                                     ^~~~~
          |                                                     (void)( )
```

Removing the comma would **BREAK THE CODE**. In particular, the side-effect of
it is needed (see next one too). Casting to void is totally unnecessary, though
it will at least compile without warnings, if done the way they want (did not
test the outcome but I know in some cases this 'fix' can break code as well so
I'm not going to risk that with code that's already highly obfuscated). Besides,
as you can see, there are other reasons to disable the warning, all because it's
wrong.

Also, as for another place where `-Wcomma` is triggered:

```
    prog.c:67:68: warning: possible misuse of comma operator here [-Wcomma]
       67 |       &&++a->l&rpar;||&lpar;a->v[1]&lpar;&&lpar;struct a&rpar;{ .v[2]=Y,.x=&lpar;&lpar;a->l&rpar;[a->h]&rpar;} &rpar;,++a->l&rpar;&rpar;; if &lpar;g&rpar; puts&lpar;""&rpar;; }
          |                                                                    ^
    prog.c:67:19: note: cast expression to void to silence warning
       67 |       &&++a->l&rpar;||&lpar;a->v[1]&lpar;&&lpar;struct a&rpar;{ .v[2]=Y,.x=&lpar;&lpar;a->l&rpar;[a->h]&rpar;} &rpar;,++a->l&rpar;&rpar;; if &lpar;g&rpar; puts&lpar;""&rpar;; }
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          |                   (void)(
```

The side effect is **REQUIRED** and casting to void is utterly pointless
(unknown if it is harmful). Actually as I said before, as this is function
`Z()`, something extremely nasty is being done here, which is detailed better
(if not to complete satisfaction) [deobfus.c](deobfus.c) and the Obfuscation
section earlier in this file. And this one is one that changed at the end, where
it has the new pointer assignment of the `struct a *` in `struct a`. I am trying
to finish up writing my remarks as the contest is not running for much longer.

Besides that, as it's so complicated I would risk breaking something by trying
to squelch the warning. In fact at one point I tried to break it down into
smaller chunks and I failed. I could not do it. It abuses the comma operator but
it is not a misuse of the comma operator.

Personally I believe that this warning is an antitheses to C and although I
might be wrong I do believe that anything other than in a for loop (or similar
say `int a, b, c;`) triggers this warning but the question is is that even
considered the comma operator in those cases (don't believe so in the latter but
unsure on the former)?

The gcc warnings (plural):

```
    prog.c: In function 'I':
    prog.c:48:51: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
       48 |                     for (k = (s*2)**"9"-171+*"9"; H=B[J][X?*"1"-49:s/ *"1"+s/ *"1"+1/ *"1"+(s*s*s)][k]; ++k)
          |                                                   ^
    prog.c: In function 'Z':
    prog.c:67:16: warning: value computed is not used [-Wunused-value]
       67 |       &&++a->l&rpar;||&lpar;a->v[1]&lpar;&&lpar;struct a&rpar;{ .v[2]=Y,.x=&lpar;&lpar;a->l&rpar;[a->h]&rpar;} &rpar;,++a->l&rpar;&rpar;; if &lpar;g&rpar; puts&lpar;""&rpar;; }
          |                ^~
    prog.c: In function 'main':
    prog.c:137:37: warning: suggest parentheses around arithmetic in operand of '|' [-Wparentheses]
      137 |     F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),c&=9u,&(struct a){ .l=1, .s=a[c],.v= { &w, &w } } ));
          |                     ~~~~~~~~~~~~~~~~^~~

```

are **ALSO** wrong and the value **IS** used in `Z()`! Additionally the
parentheses not there NEED TO NOT BE THERE! The function `Z()`, again, was
updated for even more obfuscation and that is not reflected in the above
warning, like the earlier one.

The warning `-Wmissing-prototypes` is stupid because the functions are defined
before use, obviously. The warning `-Wmissing-variable-declarations` is equally
as stupid for the same reason. What clang is saying is it wants `static` or
`extern` some declaration elsewhere (like a header file which is not allowed and
is pointless anyway).

The misleading indentation warning (if it is triggered) is nonsense and so
frequently has to be disabled by many contestants for the contest; whether after
formatting it is still a problem or not I do not know as I disabled it earlier
on. It is style policing and should NEVER have been added to gcc. Unfortunately
clang followed suit.

These are primarily triggered by `clang -Weverything` but some are triggered by
`gcc -Wextra` (I think it's `-Wextra` and not `-Wall`).

The empty while loop warning is asinine. There is no need for a body and it's a
standard C idiom. The notion the `;` should be on a separate line is format
style policing but if they deem it 'confusing' I guess that's a good thing!


#### A special warning worth mentioning is `-Wusing-C`

Okay obviously that's not what it's really called but it should be: in some
systems the warning `-Wunsafe-buffer-usage` is triggered in **MANY** places.
This is because one is using pointers as a buffer or to access a buffer or some
such but it's essentially warning that the program is in C; hence they should
just rename it `-Wusing-C` and be done with it because that's basically what
they're warning against!

The fact you can't even safely iterate through `argv` of `main()` even when
`argv[argc]` is required to be NULL should say all you need to know about it
being a TERRIBLE idea. Just like a lot of warnings in clang. Okay and gcc too...

Of course changing the code to not use pointers like I do would **ALSO BREAK THE
CODE** (if it's even possible - which of course it's not, especially seeing it
requires argc/argv)!

On this system, with `clang -Weverything`, a total of **81** (!!) warnings were
issued and **NOT A SINGLE ONE** was valid (and perhaps it's more now after last
minute changes - not sure)!


#### Warning summary

Basically the warnings that are triggered are either plain wrong or useless and
with several (quite a few) if I were to 'fix' them it would break the code. It
**MIGHT** be possible to 'fix' some of them but this is FAR from clear and it's
unnecessary as well.

**IF** any could be 'fixed' without sacrificing obfuscation AND not break the
program due to not it being so twisted (which is quite unlikely) I would guess
it's the ridiculous cast to void one. But that can cause bugs as well. As I
said, and as you probably saw, the comma operator is used extensively and trying
to placate that ridiculous comma warning would be a nightmare even with casting
to void. It'd be impossible to change the code without deobfuscating it - and
likely it would break as well.

Even so it's clear that a lot of abuse of the language is in this program, some
of which makes it quite hard to follow. As I said for `Z()` (how fun that that
rhymes) its loop is deranged and when I tried to numerous times break it up for
some issue I could not do it without causing numerous errors in the code, and I
am not referring to syntax errors.

Plus the set up in `main()` for that (and other) functions is something else.
The anonymous structs in each function call with different meanings of the
members of the struct is really nasty to follow as you can never know what is
really going to be called or what is what in general, exactly as it should be in
<del>production</del> obfuscated code!


<div id="how">
### How is the dictionary file 'encrypted'?
</div>

Well it's just that `Z` is `A`, `Y` is `B` etc. If you need to undo the
substitution try:

``` <!---sh-->
    tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'ZYXWVUTSRQPONMLKJIHGFEDCBA' < dict
```

Beware that the language did have quite racist terms for certain countries; I
will not point them out but did want to warn. This won't matter for the
translator however as those are the literal translations of the words used for
other things - so you won't see those words unless you look at the file.

I might also add that to have the file translated back to the original format
would remove obfuscation - if I could even fix the code to work in the first
place. That is not the only reason I did it but it is a reason it is staying
that way.

If you wish to know what the words actually are, I gave a link earlier on, which
might (haven't checked it in ages) have more context as well. So I would
recommend you check that instead. Still now you know what I did if you wish to
try and figure out how the obfuscation works. I guess the function that does
this transliteration is `w()` and of course that also uses the anonymous struct
so you'd have to trace the call to that.

Of course, as `w` is also a member in the struct that does not help (can't
search for `w` on a word boundary without encountering the members too, members
that mean different things at different times). If you must know, and I'm not
guaranteeing this (the heavily commented file might be better at this - you'll
have to check as this edit is on the last full day of the contest!) it would
appear to be `v[0]` and `v[1]` and called in some function from `main()`. No
that's not a typo of `main()`. Both 0 and 1 seem to point to `w()`.


<div id="sam">
### Unsinkable Sam Medical Records - funny card
</div>

<img src="sam.jpg"
 alt="medical records card of fabled Unsinkable Sam of Second World War"
 width=640 height=640>

<div id="spaces">
### The issue of spaces
</div>

Here I will talk about the more technical details on why the spaces have to be
there as well as things I tried to get it to work, keeping in mind the
constraints of the size limits that I was under (while maintaining the
obfuscation - if I could even unwind it). I also talk about spaces in general:
oddities that might be noticed at times.

Anyway, to have the reverse with just a few mods is just a bonus, and to have
the reverse is a bonus in general. It is not clear to me how else it could be
done.

The real trouble is how the language worked. If there was not a word in their
dictionary they would take the letters of those words and just spell it out with
their words for the letters. But of course this included multiple words so there
is the identification issue: what word is actually meant? What if the user means
something else (which as shown elsewhere this already is a feature of the
language!).

But with translations being multiple words, how would it work without spaces
(which are mostly an invention for written text, something they only did after
translating it in their head)? This system does not allow a reverse simply by
passing the ciphertext back into it. If it did have that it would be far weaker
(and remember that's not even the only layer) and would have been much more
prone to being compromised.

In order to make it as natural as possible for input, spaces have to be used,
and as said, the translation back is just a bonus - not even strictly needed but
I wanted to be complete.

Another question is how to translate it back to English when the word might not
be in the dictionary? Consider this word: `foo`.  If we print the translation
without spaces we will get:

```
    chuoa-khaa-kha
```

and with spaces:

```
    chuo a-kha a-kha
```

Consider the first one. If we're searching for exact matches (ignoring
`!isalpha()`) how can the first translate back to `foo`? It can't because
`chuoa-khaa-kha` is not any word (that is, the 'word' does not even indicate a
letter to spell out the word)! There is no space there.  That is the problem
at the core.

Now as for what might be done with it. There are a number of things that can be
considered and I have tried all of these - and others. Unfortunately they do not
work and I believe would be a disservice to the language as well.

Why would it be a disservice? Because it would not be a genuine translator.
There would be no point in it.

Anyway here are some things I did try (amongst others not listed) (keep in mind
I also had already heavily obfuscated things when I tried some of these, but I
don't think that even matters - and it was not as obfuscated as it is now, btw):

- We could just ignore the problem; after all they did. In fact the Americans
did not even know it - hence the story I mentioned earlier on in the
introduction of this. That's what I'm doing and of course this is what does
work.
- We can try with the shell adding `"` or `'` and then having spaces we can
tokenise it with `strtok()`. This almost worked but it had problems with some
translations for the same reason as noted above. In some cases without the
tokenisation in `I()` it does work but not in all. But tokenisation is
problematic anyway.
- other things as well, some mentioned below.

Now, what can be done about this lack of spaces (in some cases and in other cases
extra spaces, though as discussed this does not always happen - see further down
for more details on this and why it's actually a feature and one worth having)?

One thought - which I tried - is that I tokenise it by spaces and then add a
space for each 'word' translated. But still what to do about the fact that a
word is no longer there if the letters are merged?

Well in the case of words in the dictionary it is not an issue. But the words
that were spelt out - those are an issue.

Another thing I tried, and this was the closest thing to working (but it did not
work in full), is to check by length. That would be updating the `Y()` function.

It would have to skip `!isalpha()` prior to entering the loop and then it would
in the inner loop (the one with a 'break' if the condition is met) check that
the length is not beyond the word.

The theory there is that if the letters match (other characters ignored) and the
length (number of times we iterated not counting the ignored characters) is the
length of the encoded string we would then 'break out' and so as long as the
string is empty or the length is the same it would be a match.

This did not work so well either although I did confirm that the `Y()` loop
broke out in what appeared to be the right place. One thing is that the code in
`Z()` would have to be updated in ways that caused other issues and so this was
obviously the wrong choice too.

Keep in mind this too: the matching routine does do some nice things to make it
a bit easier for input, some of which I already mentioned (I think). Having
extra spaces is not a big deal. We might even say it is kind of like how the
Code Talkers had to take a brief moment in translation - and under high stakes.

There were other problems as well though. If I got one case fixed another was
then broken.  Worse was that the way it has to be tokenised (it is the only way
if we want to translate back, which again is just a nice bonus, and not
something they even had to do!) it means the shell has to help out sometimes (I
showed an example earlier I think). In one case I got what seemed to work (but
not completely). But this:

``` <!---sh-->
    ./prog.alt $(./prog foo) # where foo is the correct format
```

did not work (but it should now); instead I had to do something like:

``` <!---sh-->
    OUT=$(./prog ...)
    ./prog.alt $OUT # or maybe it was "$OUT", not sure now
```

This is not useful and very unwieldy, to say nothing about it being error prone
and problematic in other ways. That might still be useful in cases where I noted
oddities but I'm not sure of that. Fortunately the above example is not needed
now.

As it is spaces abound!

So given these facts and given the amount of frustration I had, and a large part
of that is because the code is so ridiculously twisted (as you certainly have
seen and appreciate by now), as well as how the system worked, I decided to
recall to you the fact that the Code Talkers did this all in their head, they
knew the language, and they had the convenience of not having to come up with
word boundaries. They did not need spaces but it didn't hurt if they had them.

Some space issues were resolved, an example above. Another one is that it used
to on the second line (and those beyond the second line) when reading in from a
file print a space at the beginning of the line. This was solved with the code
that uses the `L` int.

As I noted elsewhere (I think) other cipher systems are not problematic in this
case; for instance with the Enigma they transmitted it over Morse and they had
spaces. I don't recall how this was transmitted but it was markedly different in
how it worked; whereas in the Enigma (and many other ciphers, though I believe
the Culper Code is one of the exceptions) you aren't limited to specific words,
with this you are, and you have to spell out the words by the words for its
letters (the Culper Code might also be this but I'm not sure).

Going back to the disservice part: I believe it would be an **injustice to the
language** if this was resolved, if it even can be done without reaching the
IOCCC size limits (I was able to several times get it down but more problems
showed up which required more code, and I never did solve it to a satisfactory
level, based on what I just explained and you now hopefully understand and
appreciate), because the spaces are a testament to its obscurity (even though
those over radio do not need spaces), though as you noticed I did get some of it
resolved.

Oh and yes: the size is not at 2503 now. But trying to resolve these 'issues'
brought it there and beyond.

I do not actually believe it is possible to get rid of the spaces where they are
and might be deemed incorrect, especially if there is to be a way to translate
back to English which seems like a good idea (although I did say it might be a
disservice here, obviously they had to do it, but they didn't have to worry
about spaces or word boundaries); this is just the way it is given the multiple
ways a word can be translated (dictionary translation or else spelt out with
multiple words, the real trouble).

The file mode could have been removed to help with bytes but this limits input
even more though perhaps given the potential traps it is not really worth it.
Maybe I should spend time doing something else but given the issues and given
the amount of obscurity in the code, it would seem to me that it fits the Navajo
Code Talking language quite well.

The fact they did this in their heads in mere minutes, they really were coding
machines (or maybe encoding and decoding machines) and they had no room for
error; the fact trying to remove spaces introduces errors and input problems is
another reason to not worry about spaces, especially as they did not worry about
it either as they had no need to break it up, not needing word boundaries in the
way I do! Nobody speaks like this (and I hope this doesn't change):

> Bang. Space. Bang. Space. Maxwell's. Space. Silver. Space. Hammer ...

That would be ridiculous. We don't need spaces when speaking. We don't need to
see or not see spaces as one is speaking as we're listening, not reading (okay,
fine, maybe there are a few very rare exceptions but in general not).

Even so I believe the only spaces left are those that are required and in some
if not all cases they (those) are mere technicalities.

Basically, and this is important if you wish to be critical of the spaces:
spaces are not meant for speaking and that is what they did. They had no visual.
It was all in their head and they translated it in a matter of minutes. They DID
write it down for their comrades but the spaces IN translation were utterly
irrelevant just as they are irrelevant when you're speaking.

I will close this out with these final remarks:

In particular, the spaces are added to **help out** in **use of the program**.
This means that sometimes the output can look odd. You'll notice this especially
if there is not a word in the dictionary and it has to be spelt one letter at a
time. This is done so that translations can at least work even if sometimes (for
instance in `./prog.alt $(./prog b c d)` the spaces are not as you wish (or do
not exist - or presumably not as you wish).

If a file being read, depending on how you use the program, has a character that
is interpreted by the shell (such as `*`) then just like any other command that
could cause problems as the shell will have done its thing before the program
gets the input.

Of course to expect one to be able to translate prog.c to Navajo Code Talkers
and back to English to compile is rather absurd, although you might notice the
alt code can read in the code and redirect to another file that can then be
compiled (at least in some cases). It's important to remember though that the
alt code simply prints words that are not in Navajo AS IS, UNTOUCHED, and it
does not print spaces between words - so any spaces are literal. You can observe
this at the command line too:

``` <!---sh-->
    $ ./prog.alt shush moasi
    bc

    $ ./prog.alt shush ' ' moasi
    b c
```

This is a feature and actually can demonstrate the momentary pause as they
encoded/decoded the message!


### Why I think this entry is worthy of winning

The Code Talkers should be honoured and acknowledged and what better place in a
contest about obscuring code?

I've shown everyone that you can do arithmetic on strings in C! Even those few
who might know this fact would have to actually think about what each of these
evaluates to (maybe there are a few people who wouldn't but that's probably
extremely rare) and then test their theory out each time (even those who might
not need a moment to evaluate it in their head might have to do this). The odds
are they'll have to look at the ASCII table first.

That some of these are recursive and in ternary operator in a loop makes it
harder to follow still. For instance:

``` <!---c-->
    for (k = (s*2)**"9"-171+*"9"; H=B[J][X?*"1"-49:s/ *"1"+s/ *"1"+1/ *"1"+(s*s*s)][k]; ++k)
```

is not easy to parse but that's probably a simpler one. A much more ridiculous
one is:

``` <!---c-->
    for (J = *"1"-*"1"; J < 26 && B[J][X?1/ *"1"+s/
        *"1"+1/ *"1"+s/ *"1"+1+(s-s)**"1"+(s*(s-s))**"1":((((s-1)**"1")**"1")**"1")**"1"]; ++J)
```

The array `B` is not going to be easy to parse for most people and the use of it
is hard to parse too, given the arithmetic on strings (and other things).  I
thought about making the alphabet itself encrypted but I needed bytes for more
interesting things; after all what difference does it make if you can translate
the rather unknown language when the program (or alt code) can do it for you
anyway?

The anonymous structs for each function which has different values per call,
often in confusing or misleading ways, is something I have not seen in the
IOCCC, certainly not like this. It makes it hard to follow the code.

Beautifiers (at least some) are not going to help much as they tend to keep
spaces in place. Of course if the beautifier is not careful it can turn some of
my code into comments. Some beautifiers are better than others when it comes to
shortening the program length but I'm not going to help you with that.

Oh and btw: what is prog.obfus.c? I think that was a file that I at one point
ran the code on though I might have had to manipulate the output a bit, in order
to get it to compile. It very likely (based on the timestamp) was an older
version of the code, perhaps one of the `prog.2.c` or `prog.3.c` files. I'm not
sure now though. What is `prog.pre-format.c`? That was a copy of what was
`prog.c` at 8 March 2023: so you can see how much it has changed since then as
well. Similar with some of the other code files. The [deobfus.c](deobfus.c) is
as noted a heavily commented file although as you'll see there is some I cannot
parse even myself.

One more thing. The [try.sh](try.sh) script has a fun demonstration of
`prog.alt` on itself which is then compiled and run on that source file and then
runs diff on the two files, showing something interesting. I did not have it as
a try.alt.sh because the try.sh already relies on both being compiled so I
figured I'd save a file.


<!--

    Copyright © 1984-2025 by Landon Curt Noll and Leonid A. Broukhis.  All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
