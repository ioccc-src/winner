## To build:

``` <!---sh-->
    make
```

The author provided alternate code that prints the output one character at a
time to make it a bit more like the real thing in that it isn't dumped out all
at once. See [Alternate code](#alternate-code) below.


## To use:

``` <!---sh-->
    ./prog

    # get recode help:
    ./recode -h

    # general syntax for recode passing to Enigma machine:
    ./recode [options] | ./prog - 2>/dev/null
    # general syntax for recode without passing to Enigma machine:
    ./recode [options]

    # recode prompts for settings; pass to Enigma machine:
    ./recode | ./prog - 2>/dev/null

    # recode reads from input file, prompts for settings; passed to Enigma machine:
    ./recode -finput | ./prog - 2>/dev/null

    # recode reads config from string or file; passed to Enigma machine after
    # prompting for input:
    ./recode -R<string|file> | ./prog - 2>/dev/null

    # write config to output file; passed to Enigma machine after prompting for
    # input:
    ./recode -o<config> | ./prog - 2>/dev/null

    # pseudo-randomly select settings
    ./recode -r

    # show Enigma machine settings after selection / generation:
    ./recode -v
```

**NOTE**: in [recode](%%REPO_URL%%/2020/ferguson2/recode.c) no spaces between options and option arguments
are allowed.


## Try:

``` <!---sh-->
    ./try.sh
```

What does:

``` <!---sh-->
    echo | ./recode
    echo | ./recode -v
```

do?


## Alternate code:

This version, [prog.alt.c](%%REPO_URL%%/2020/ferguson2/prog.alt.c), writes a character at a time, sleeping
after each character, so that one can read it more easily (for longer output)
and to make it a bit more like the real thing.


### Alternate build:

``` <!---sh-->
    make alt
```

The default time to sleep is 400000 microseconds but you can change this by
doing:

``` <!---sh-->
    make clobber SLEEP=600000 alt
```

to change it to 600000 microseconds. It guards against negative numbers.


### Alternate use:

Use `prog.alt` as you would `prog` above.


### Alternate try:

``` <!---sh-->
    ./try.alt.sh
```

Notice how only the last part should use the `prog.alt`. Why? Try it and find
out! Can you figure out why this works this way?


## Judges' remarks:

This code is an [enigma](https://youtu.be/ybkkiGtJmkM).  Try to decode it!

There is a good deal of useful documentation that is provided with this entry:

* [enigma.1](%%REPO_URL%%/2020/ferguson2/enigma.1)      -  A useful man page for this entry.  To render, try:


``` <!---sh-->
    man ./enigma.1
```


* [recode.html][]
    - Some useful information about [recode.c](%%REPO_URL%%/2020/ferguson2/recode.c)


* [enigma.txt][]
    - NOTE: see [recode.html][] (or [recode.html](recode.html) for details about how to decrypt this!

* [testing-procedure][]
        - How the author tested the code and why it was necessary to do it in the way it was

[recode.html]: recode.html
[enigma.txt]: enigma.txt
[testing-procedure]: testing-procedure.html


## Author's remarks:

My remarks about my [Heer][] (army) and [Luftwaffe][] (air force) [Enigma
machine](https://www.cryptomuseum.com/crypto/enigma/index.htm) [simulator](%%REPO_URL%%/2020/ferguson2/prog.c) for
the 27th IOCCC.

I want to dedicate this entry in part to the millions of poor souls that were
lost during the tragedy that is the [Second World
War](https://en.wikipedia.org/wiki/World_War_II). There are so many people
who are unknown, unloved, unclaimed and even unidentified. And who knows what
they might have gone on to do if their lives weren't - like it is with all other
wars - needlessly taken from them? When one considers it was all because the
most powerful man in the world at the time felt he should rule all others it
makes it somehow even more tragic: there wasn't even a good reason for the war
(is there ever?).

If one were to write the name of every person who died in the conflict in a
book, it would take so many pages that the book would be so heavy, so long, so
expensive to print and it wouldn't bring anyone back to life nor would it erase
the suffering. Nothing will. It's horrible.

There really are no words that can truly describe the tragedy but I wish to with
my [Enigma][] simulator honour each and every soul who was lost, or suffered, or
suffered the loss of friends or loved ones, as well as the world itself, in and
from one of the greatest tragedies in the history of mankind.

I have more information on this entry like the testing procedure at
<https://ioccc.xexyl.net/2020/enigma>.


<div id="toc">
-   [IOCCC: an Enigma?](#ioccc)
-   [The 1992 Nathan Sidwell entry](#nathan)
-   [Usage](#usage)
    *   [Example run](#example)
-   [The recode.c configurator](#recode)
-   [A parser subtlety that could cause confusion](#parsersubtlety)
-   [On the source code layout](#layout)
-   [Obfuscation](#obfuscation)
-   [Bugs, limitations, differences from the real Enigma machines and general notes](#bugs)
-   [Kriegsmarine support?](#kriegsmarine)
-   [Portability](#portability)
-   [Winning thoughts, dedications and thanks](#winning)
-   [Resources](#resources)
</div>

<div id="ioccc">
### IOCCC: an Enigma?
</div>

Is there a better single word that could describe the code that is IOCCC?  I'm
sure there are some other words that are equally as valid but I believe 'Enigma'
is a great word nonetheless.

However it's curious that no winning entry has ever been a simulator of the
[German Enigma machine](https://en.wikipedia.org/wiki/Enigma_machine). I was
actually quite surprised (though pleased as it gave me the chance to learn about
it and submit and win an entry) at that because it's such a brilliant piece of
engineering of the time even though it had a critical flaw: that no letter could
be itself; this combined with cribs (known or suspected plaintext) - which was
down to carelessness, capturing an Enigma and sometimes settings sheet, as well
as known messages the Germans started out with - allowed for [cracking the
code](https://en.wikipedia.org/wiki/Cryptanalysis_of_the_Enigma).

Combining this entry with two of the [Morse
code](https://en.wikipedia.org/wiki/Morse_code) entries is particularly
interesting because that's what the Germans did: the party sending the message
would first set up the machine, write down the letters and then transmit by
[Morse code](https://en.wikipedia.org/wiki/Morse_code) the encoded message. Then
those picking up on the message would note the Morse code, translate it to the
alphabet and then input it into their Enigma machine configured in the same way
and thus have the original message.

The [1998 ASCII / Morse code translator][] entry by [Franz van
Dorsselaer](../../authors.html#Frans_van_Dorsselaer) prints the Morse code of text;
and the [2014 Morse audio transcoder][] by [Daniel
Vik](../../authors.html#Daniel_Vik) can be used to allow for the actual sound of it.
With my entry we can complete the loop!


<div id="nathan">
### The 1992 Nathan Sidwell entry
</div>

The author [Nathan Sidwell](../../authors.html#Nathan_Sidwell) of the [1992 Worst
Abuse of the Rules][] had this to say about his program:

> This program is a hello world text encrypter/decrypter. It uses an
[enigma](https://www.cryptomuseum.com/crypto/enigma/index.htm) (I think) style
encryption algorithm, where the encryption key character is modified by a value,
determined from the previous character.  Non-printable characters (those with
ASCII values `< ' '` or `> 0x7e`) are passed unaltered, thus any kind of file
may be successfully processed, but if the original is printable, the processed
file will be too. The input is read from stdin, and the output presented to
stdout. The key, a text string, is presented as a command argument. This is
optional, and if omitted, the file is self-{de,en}crypted. To specify
decryption, a `-` should be given before the key. (Actually encryption and
decryption proper inverse operations, so you can use decrypt to scramble and
encrypt to descramble, if you're perverse.)

But the Enigma algorithm is more complex than that and my entry can encipher
(and by extension decipher) text in the manner of the Enigma machines of the
[Heer][] (army) and [Luftwaffe](https://en.wikipedia.org/wiki/Luftwaffe) (air
force); the [Kriegsmarine](https://en.wikipedia.org/wiki/Kriegsmarine) (navy;
literally `War Nazy`) was more complex (see section [Kriegsmarine
support?](#kriegsmarine) for more information on that.

My entry should also work as a non-military grade Enigma; they had no
[plugboard](https://www.cryptomuseum.com/crypto/enigma/i/sb.htm) and by
default mine is empty. I explain how to set up the simulator later.

[Yusuke Endoh](../../authors.html#Yusuke_Endoh) asked the judges and me if the real
1992 entry source was available. Simon Cooper didn't have access to it because
it was before his time in the IOCCC; but before the other judges could answer
[Ilya Kurdyukov](../../authors.html#Ilya_Kurdyukov) sent a link to the original 1992
code. As of 4 March 2023 the original before unseen code was published but I
leave this in for historical purposes.


<div id="usage">
### Usage
</div>

If you run the program by itself it'll use the default settings and prompt you
for input (end with EOF). At that point it'll process the input string and print
the result (after finishing the enciphering).

If you run it like:

``` <!---sh-->
    ./prog -
```

It will prompt you for the settings of the machine (example below).

The first group is in the order of
[rotor](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm) (number),
[ring setting](https://en.wikipedia.org/wiki/Enigma_rotor_details#Ring_setting) (letter) and
ring (starting) position (letter). It will do this for the first, second and
then third for each.

Then it will prompt you for the
[reflector](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm#Reflector) (by number).
The first one is reflector B and the second is reflector C.

Finally it'll prompt you for the [plugboard
pairs](https://www.cryptomuseum.com/crypto/enigma/i/sb.htm).

After that you can input the string and it'll go from there.

<div id="example">
#### Example run
</div>

BTW: There's a much more entertaining way to explore this entry. See
[recode.html][] for more details. There's a secret message that one might like
to decipher. These however show the general program as well as how to use the
two winning entries of the [Morse
code](https://en.wikipedia.org/wiki/Morse_code) that I referred to earlier:

``` <!---sh-->
    $ ./prog -
    Ring 1: 3
    Setting 1: I
    Position 1: O
    Ring 2: 1
    Setting 2: C
    Position 2: C
    Ring 3: 5
    Setting 3: C
    Position 3: Z
    Reflector: 2
    Plugboard pair 1: CO
    Plugboard pair 2: DE
    Plugboard pair 3: SN
    Plugboard pair 4: XY
    Plugboard pair 5: MS
    Plugboard pair 6: AT
    Plugboard pair 7: VF
    Plugboard pair 8: UR
    Plugboard pair 9: KL
    Plugboard pair 10: BJ
    IOCCC
    ^D
    CFDRG
```

Notice that all output except the deciphered/enciphered text is sent to stdout.

If I didn't specify the `-` by e.g. `echo IOCCC | ./prog` then it will use the
default settings; as the judges suggest this invocation I will not show it here.

But you can also type it out like this:

``` <!---sh-->
    $ ./prog
    IOCCC
    UUMMX
```

The IOCCC comes from stdin; the `UUMMX` is written to stdout.

If I compile the 2014 entry and copy it to my local directory as
`vik` I might do:

``` <!---sh-->
    $ echo TEST|./prog |./vik | mplayer -demuxer rawaudio -
```

And you would hear [Morse code](https://en.wikipedia.org/wiki/Morse_code) of the
[Enigma](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm) output
of 'TEST' (i.e. `KCWV`)! Or perhaps not in this case. I'm not sure: I discovered
a bug in that entry (Fedora, CentOS and macOS all affected).

For example I can use the syntax provided in the winning remarks along with my
entry to write it to a file. Say:

``` <!---sh-->
    $ echo TEST|./prog |./vik > test.raw
    $ ./vik e < test.raw | ./prog
    LEST
```

Why did that happen? This shows more details:

``` <!---sh-->
    $ ./vik e < test.raw
    SCWV
```

However as can be seen the first char is wrong:

``` <!---sh-->
    $ echo TEST|./prog
    KCWV
```

And piping the original output to my entry itself you get the original input:

``` <!---sh-->
    $ echo TEST | ./prog  | ./prog
    TEST
```

I'm not sure what causes that or if there's a way to fix it but that's the
idea anyway. Neither do I know if the original transcoding is correct.

What if I use the input string `LEST` instead? In that case it worked fine:

``` <!---sh-->
    $ echo LEST | ./prog | ./vik > lest.raw
    $ ./vik e < lest.raw | ./prog
    LEST
```

But there's one obvious question, right? Let's try the most important one:

``` <!---sh-->
    $ echo IOCCC | ./prog | ./vik > ioccc.raw
    $ ./vik e < ioccc.raw
    UUMMX
    $ ./vik e < ioccc.raw | ./prog
    IOCCC
```

Phew! The program redeemed itself after the test failure! :)

(Technically above it didn't print a newline after the output and this is how it
is with some of the things I pasted in the other file and maybe others here
too. Notice also how it showed the same output that my program gave it - `UUMMX`.)

What about the other [Morse code entry](%%REPO_URL%%/1998/dorssel/dorssel.c)?

``` <!---sh-->
    $ echo IOCCC | ./prog | ./dorssel
    ..- ..- -- -- -..-
```

<div id="recode">
### The recode.c configurator
</div>

I have included a supplementary program [recode.c][] that can do a number of
things which acts as a kind of wrapper and configurator to my entry. By default
it prompts you for the settings
([rotors](https://en.wikipedia.org/wiki/Enigma_rotor_details), [rings and ring
settings](https://en.wikipedia.org/wiki/Enigma_rotor_details#Ring_setting) and
positions,
[reflector](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm#Reflector) and
[plugboard pairs](https://www.cryptomuseum.com/crypto/enigma/i/sb.htm),
validating input as you go.

After that it prompts for text that you can pass to the Enigma simulator;
alternatively you can specify a file to read in.

It has a randomise mode and it can save/read the settings to/from a file to
allow for duplicity (an archaic term for the state of being double but obviously
for Enigma it has to also mean deceitful).

I recommend using this in a pipeline instead of the [simulator](%%REPO_URL%%/2020/ferguson2/prog.c) itself
if you want to change the configuration of the simulator because it offers a
much richer experience (and because you can reuse the configuration without
having to type it out again every time).

It does take the effort to try and prevent invalid input (as above) though maybe
I didn't think of everything. My entry was meant to be a simulator only as far
as the ciphering goes but I thought this would make it much more interesting:
make it more flexible by a wrapper program.

For examples using it you might enjoy a fun message that I have encrypted using
a key that you should be able to figure out (it's in a list). This might lead to
something else fun as well but I will not say more than that. Anyway, see
[recode.html](recode.html) for more details. See also the [recode.1][] and
[enigma.1][] man pages.


<div id="parsersubtlety">
### A parser subtlety that could cause confusion
</div>

The parser is in a sense rather rudimentary but allows for both interactive and automatic
(e.g., via the [recode](%%REPO_URL%%/2020/ferguson2/recode.c) program) input.
This does mean that something like the following can happen:

``` <!---sh-->
    $ ./prog -
    Ring 1: 1AB
    Setting 1: Position 1: Ring 2: 2CD
    Setting 2: Position 2: Ring 3: 3
    Setting 3: A
    Position 3: B
    Reflector: 1A
    Plugboard pair 1: BC
    Plugboard pair 2: ..
    Plugboard pair 3: ..
    Plugboard pair 4: DE
    Plugboard pair 5: FG
    Plugboard pair 6: HI
    Plugboard pair 7: JK
    Plugboard pair 8: LM
    Plugboard pair 9: NO
    Plugboard pair 10: PQ
    IOCCC
    WD
    SIRDK
```

First of all: what is that `WD`? I didn't type that but it showed up hitting
`ctrl-d` to end input.

If everything is input correctly it would show nothing except the actual
[Enigma machine](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm) output
(maybe at times ^D - I have noticed this at least when I don't fill in all
[plugboard](https://www.cryptomuseum.com/crypto/enigma/i/sb.htm) pairs - which
might or might not be possible with the Enigma machines that had plugboards; I
really do not know). I don't view this as a bug because the parsing of input is
meant to be simple and in fact you can expect the same output from the same
input even if there are errors in the input.

Anyway as you can see the first `1AB` was the first ring, setting and position.
After this it wants Ring 2 and I did similar; for ring 3 I did it each variable
by itself. However for the reflector I did `1A` but it only expects 1 char! So
will that mean that the plugboard pairs are off? Yes it does seem to be so. This
is buffering at play I believe but it's useful for allowing the `recode` program
to easily configure the Enigma machine. In the [recode.html](recode.html) file
file I give a hint as to how this could be fixed but the caveat is it would
necessitate a need for rewriting
[recode.c](%%REPO_URL%%/2020/ferguson2/recode.c).

There's another thing to be aware of and that's the way the ranges are enforced.
There are five rotors which obviously are in C 0-4 but in 'natural language'
1-5 (they were labelled I, II, III, IV and V though).

There are two
[reflectors](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm#Reflector) and the
same applies: in C 0-1 but in human it's 1-2 (technically these were reflectors B and C in
the Enigma machine which I display by name in [recode.c](%%REPO_URL%%/2020/ferguson2/recode.c) just like
with the rotors).

For more information see [recode.html][].

BTW: If you need a reminder to go to the gym just do your Enigma ABCs and it
should help you remember:

``` <!---sh-->
    $ echo ABC | ./prog
    GYM
    $ echo ABC | ./prog | ./prog
    ABC
```

<div id="layout">
### On the source code layout
</div>

The layout of [recode.c][] isn't too significant (but see below) but I want to
mention [prog.c](%%REPO_URL%%/2020/ferguson2/prog.c) especially:

I did think of a more artistic layout but
[reflecting](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm#Reflector)
on it I think that the blankness of it can be another way of honouring all the
many people who died in - like all other wars - what was a useless conflict
because - again like all other wars - a powerful human being decided that they
should rule others.

The blankness is a
[reflection](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm#Reflector)
of the millions of people who died unknown, uncared for, unloved, without ever
being acknowledged in their far too short lives, some even unidentified; it's
the presence of absence.

I find it somehow fitting that the day I have finished this is 30 April 2020,
which was exactly 75 years from the day that the person responsible for the
[Second World War](https://en.wikipedia.org/wiki/World_War_II), Adolf Hitler,
ended his life. (I later made a bug fix but I consider this inconsequential).

As for [recode.c][] though I really love this:

``` <!---c-->
              /\
    /          This is *not* what you think:
```

...because it seems so wrong in C code at first glance. Also what does the
'this' refer to?


<div id="obfuscation">
### Obfuscation
</div>


It's an [Enigma machine](https://en.wikipedia.org/wiki/Enigma_machine) simulator! Isn't
that proof that it's obfuscated itself?! :) Silliness aside [obfuscation.txt][]
has some of the ways I think this entry is obfuscated.  To decipher try:

``` <!---sh-->
    ./recode -Robfuscation.key -fobfuscation.txt | ./prog - 2>/dev/null > obfuscation.md
```

To encipher:

``` <!---sh-->
    ./recode -Robfuscation.key -fobfuscation.md | ./prog - 2>/dev/null > obfuscation.txt
```

The file [obfuscation.key][] is the key to decipher/encipher
[obfuscation.txt][].

For the lazy [obfuscation.html](obfuscation.html) has the deciphered version.

As for the [obfuscation.key][] file if you observe the contents you'll find the
word `OBFUSCATION`:

```
    2OB5FU1SC2ATIONCDEFGHJKLMPQRYZ
     OB FU SC ATION
```

<div id="bugs">
### Bugs, limitations, differences from the real Enigma machines and general notes
</div>

Ways that my simulator differs from the real thing. Not all of these are bugs
and some could be considered features; others are just differences.


*   Does not check for using the same
[rotor](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm#Reflector)
more than once. The real Enigma machines this would not work because they had to
choose from a set of rotors and there were no duplicates. This shouldn't be a
problem here however except that it wouldn't be a possible configuration of the
real Enigma machine. The `recode` program *however does validate this* (except
when reading in settings via the `-R` option which I explain in the
[recode.html][] file.

*   The way the [plugboard](https://www.cryptomuseum.com/crypto/enigma/i/sb.htm)
\- for the machines that had them - is, if you connect A to B then no other
letters can connect to A or B. Earlier there wasn't proper detection and this
caused invalid output.

    Why only 10 pairs when the German alphabet has 26 letters (the Enigma did
    not have the Eszett or the umlauts and in any case there is some
    disagreement about these being part of the alphabet; anyway for umlauts one
    can add an E after the letter and for the Eszett you can use 'ss' or 'SS'
    which is what they did)? It's theoretically possible to have 13 but the
    Enigma typically had 10 pairs.  It's easy enough to update my entry to do
    this once you de-obfuscate it but I'm not helping there (and in fact I don't
    think I could any more even if I wanted to - at least not easily).

*   It does not obviously have the clicking sound associated with the moving
parts of the real machine. I think it would be annoying to have this as it
processes each letter - but with the [2014 Morse audio transcoder][] entry you
can at least have the output played in Morse code as the Germans did; I think
that's really cool (I think it's really cool even if there's a bug in it). That
it pays homage to that (and another) entry is a bonus here.

*   The [simulator](%%REPO_URL%%/2020/ferguson2/prog.c) doesn't report errors but tries to gracefully deal
with them: if one chooses a value out of range it moves it into the range (if >
the max then the max, if < min then the min). If invalid chars are input for the
plugboard pairs then it's not added to the plugboard etc.

*   The real [Enigma
machines](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm) had
only letters: no digits, no punctuation. My entry prints `!isalpha()` chars
untouched. The Germans had different systems for punctuations, numbers etc. (one
of the documents I link to has these details).

*   My entry preserves case of letters. The real Enigma had only one case as it
was just a keyboard and they didn't need case-sensitivity. Context would be
important as some words in German have different meanings depending on if
capitalised or not (and all nouns are capitalised).

*   Later models introduced a fourth rotor. The
[Kriegsmarine](https://en.wikipedia.org/wiki/Kriegsmarine) procedures were
also far more complex than the [Heer][] (army) and [Luftwaffe][] (air force)
(though apparently the additional notch provided another flaw). I find this particularly
interesting because it was Hermann Goering who was the Supreme Commander of the
Luftwaffe and the intelligence agency Forschungsamt (FA) was his; it provided
Hitler with invaluable information so one would think the Luftwaffe system would
be more complex! See [Kriegsmarine support?](#kriegsmarine) for more
information.

*   I only include
[reflectors](https://en.wikipedia.org/wiki/Enigma_machine#Reflector) [B and
C](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm#wiringtables).
To have included more would have used too many bytes (each reflector and
[rotor](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm#rotors) is
26 characters!) and I could not include them for this reason; I include five
rotors and two reflectors and that's a total of (`5 * 26 + 2 * 26 == 182` chars)
but there are as you can see many other strings too. It is however feasible to
update the rotor and reflectors options and you could even make your own
versions if you wanted to. Doing this is an exercise to the reader however (the
idea of trying this makes me cringe because of how I obfuscated things including
encrypting some of it with the Enigma itself).

There's one thing I'm unsure of in my implementation. Because of all the
possible settings I used some other simulators as a starting point and more
importantly to validate that my code worked right. These other simulators had
bugs though and so one thing looked odd and I don't know if it is right or not.
An online simulator appears correct but I don't see the option to change that
part.

If you notice in the `Q()` function where I set up specific pointers and other
data there is a call to the macro `q` but I only refer to the first ring setting
(of which I no longer even know which element it is! Or was it position? I don't
even know that now for certain). That's because the Python code did that (though
very differently of course) but I also had to bug-fix the Python in another
part.

I do not know if this is correct but as I show somewhere my entry does match the
online simulator so I presume it is correct. It might be that the Germans tended
to have it at A but again I do not know.


<div id="kriegsmarine">
### Kriegsmarine support?
</div>

Is it possible to add [Kriegsmarine](https://en.wikipedia.org/wiki/Kriegsmarine)
support? I thought so by adding the additional rotors but looking at it again it
appeared that it's not as simple as adding the rotors to the code and then
updating the references to the array etc.

This is because it had three additional
[rotors](https://en.wikipedia.org/wiki/Enigma_rotor_details) - [`VI`, `VII` and
`VII`](https://www.cryptomuseum.com/crypto/enigma/m4/index.htm#wheels) - and had
[two notches](https://en.wikipedia.org/wiki/Enigma_rotor_details#Turnover_notch_positions)
and this changes the way things work. The [Kriegsmarine
M4](https://www.cryptomuseum.com/crypto/enigma/m4/index.htm) also had an
additional change which would complicate matters more.

I looked into trying to do this for another version after winning but some of
the obfuscation techniques dramatically complicates even attempting this so I
haven't even tried.

It is feasible that you could add your own rotors however but I leave this as an
exercise to the reader. I will say that the five rotors I, II, III, IV and V can
be found in the source code verbatim and you could confirm it by looking them
up; however much more would have to be done in order to get them to work, than
to just put the strings in. Again the way I set things up complicates this
greatly.


<div id="portability">
### <a  href="#toc">Portability</a>
</div>

I have tested it under macOS, Fedora and CentOS Linux and all seems okay under
these platforms. When I was in the final stages of obfuscation I made an error
somehow (or else maybe the vim formatting caused a problem - I have seen this
before) and I had to go back and undo some of the obfuscation to figure out what
was going on (I had a hunch where and I noted it in the obfuscation I believe)
but this made me wonder on if I made any other mistakes since it appeared to be
working before that.

I don't know if EBCDIC will work but I think it might because it appears that
the alphabet is a contiguous sequence. I don't believe endianness matters but I
no longer remember what I've done in full and I've no way to test it.

If there are any inconsistencies in input/output one also has to be certain that
input was put in correctly because as soon as a letter differs the entire
sequence will be off.

The results of my test script (not included here but I will probably have it on
my website) are the same under Fedora, CentOS and macOS.


<div id="resources">
### Resources
</div>

#### A note on Wehrmacht, its branches and other agencies and their Enigma machines

The [Wehrmacht](https://en.wikipedia.org/wiki/Wehrmacht) was the defence force
in full which included the [Heer][] (army),
[Luftwaffe](https://en.wikipedia.org/wiki/Luftwaffe) (air force) and
[Kriegsmarine](https://en.wikipedia.org/wiki/Kriegsmarine) (navy). As I said the
Kriegsmarine procedures were more complex: they had additional rotors and one of
their models had a different
[reflector](https://en.wikipedia.org/wiki/Enigma_machine#Reflector) system (thin
instead of thick - some of the documents below discuss this). The military
intelligence agency, the Abwehr, had their own system too.  Non-military grade
Enigma machines didn't have the
[plugboard](https://www.cryptomuseum.com/crypto/enigma/i/sb.htm). And so on.

However one of the documents below distinguishes the Kriegsmarine from the
Wehrmacht; when you see this you can read it as the Kriegsmarine versus the rest
of the Wehrmacht rather than the Wehrmacht and the Kriegsmarine.


[Enigma Message Procedures][]: The [Heer][],
[Luftwaffe](https://en.wikipedia.org/wiki/Luftwaffe) and
[Kriegsmarine](https://en.wikipedia.org/wiki/Kriegsmarine)
[Enigma](https://en.wikipedia.org/wiki/Enigma_machine)
procedures.

[Interactive Enigma Machine][]: Shows wiring of the [Enigma
machine](https://en.wikipedia.org/wiki/Enigma_machine) based on the
settings and input (unfortunately uses Flash). This was what I used to verify
output (as best I could find). To set this up to use the default settings in my
simulator make sure to use
[Rotors](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm#Rotors)
I, II and III and the starting positions at B, B and C respectively (as in left,
centre, right). To do this click the button at the top right that looks like:

```
    o->
    <-o
```

and then select the rotors.  Next click the button again at the left of the
rotor selection 'screen'. Then use the arrow buttons above each rotor to set
from left to right B, B and C. After this you can type your message in the input
field and watch the wiring of the rotors change and show the path it takes.

If I made use of the Enigma code in the [recode.c](%%REPO_URL%%/2020/ferguson2/recode.c) program I would
maybe consider doing something like that but I intentionally do not use it
there: as cool as it might be it would give a better idea of how the algorithm
works (unless I were to make it just as obscure as I do in prog.c but that's
also a bit risky). I don't believe I could do it now anyway.

I'm uncertain how to change the rotor setting itself in this simulator to
determine if the ring settings being different from `ABC` would cause a problem
(this is the thing I mention I'm uncertain about in the bugs section).

Going back to the configuring the online simulator try inputting the text IOCCC
and you'll see the resulting text being:

```
    UUMMX
```

Which is exactly as my entry shows! So at least for the starting position `BBC`
and an empty [plugboard](https://www.cryptomuseum.com/crypto/enigma/i/sb.htm)
and the other defaults in my entry (which appear to be consistent with the
online simulator too) I can verify it works.

[Tony Sale's pages on The Enigma cipher machine][]: This is many pages on the
Enigma machine by the late Tony Sale who was the original curator of the
[Bletchley Park Museum](https://www.cryptomuseum.com/bp/). There is a wealth of
information in these pages on how the Enigma worked and this includes some
challenges to do to see how well you understand the algorithm.

Fun fact: the abbreviation for the [Signals
Intelligence](https://en.wikipedia.org/wiki/Signals_intelligence#World_War_II)
is that of our wonderful `SIGINT`.

[Technical Details of the Enigma Machine][]: 'This page provides the technical
details of the [Wehrmacht](https://en.wikipedia.org/wiki/Wehrmacht) and
[Luftwaffe](https://en.wikipedia.org/wiki/Luftwaffe)
[Enigma](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm), and the Kriegsmarine Enigma M4.'
It is quite a nice document with diagrams, pictures of actual Enigma
[rotors](https://www.ciphermachinesandcryptology.com/en/enigmatech.htm#Rotors) and
other parts and more.

[The German Enigma Cipher Machine][]: The history of Enigma, its development,
use during the war and cryptanalysis.

[How the Enigma was Set Up and Operated][]: This is the third page in a document
series on the Enigma that explains the initial set up of the Enigma machine for
each day. This is a good introduction to the set up. There is one thing that I
was not aware of (or if I was it did not register): the operator would after
setting the positions also put in three letters before the actual message (there
were several parts to each message but this was another layer of complexity). I
did not implement this in the recode program but what would it be anyway? If the
user here wants to they could add three letters to their message beginning. I
don't think there need be any addition to the recode program - at least not
that.


### Testing procedure

There was a need for a testing procedure as a single character difference will
change the rest of the text. If you wish to see how I went about this see
[testing-procedure.html](testing-procedure.html).


[1992 Worst Abuse of the Rules]: ../../1992/nathan/index.html
[1998 ASCII / Morse code translator]: ../../1998/dorssel/index.html
[2014 Morse audio transcoder]: ../../2014/vik/index.html
[Enigma Message Procedures]: https://web.archive.org/web/20200710094321/http://users.telenet.be/d.rijmenants/en/enigmaproc.htm
[Interactive Enigma Machine]: http://enigmaco.de/enigma/enigma.html
[enigma.1]: enigma.1
[recode.1]: recode.1
[recode.html]: recode.html
[recode.c]: recode.c
[obfuscation.html]: obfuscation.html
[obfuscation.txt]: obfuscation.txt
[obfuscation.key]: %%REPO_URL%%/2020/ferguson2/obfuscation.key
[Tony Sale's pages on The Enigma cipher machine]: https://web.archive.org/web/20200621180323/http://www.codesandciphers.co.uk/enigma/index.htm
[Technical Details of the Enigma Machine]: https://web.archive.org/web/20200710094303/http://users.telenet.be/d.rijmenants/en/enigmatech.htm
[The German Enigma Cipher Machine]: https://web.archive.org/web/20200710094243/http://users.telenet.be/d.rijmenants/en/enigma.htm
[How the Enigma was Set Up and Operated]: http://www.ellsbury.com/enigma3.htm

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

To Yusuke Endoh, Dave Burton and Nicholas Carlini I very much appreciate your
wonderful comments on this program. Your comments Yusuke on this entry specially
and also Dave's comments on my double-win are both extremely special to me - it
truly takes my pride to another level!

I would like to dedicate this entry to my wonderful mum Dianne Ferguson whom I
love with all my heart and soul <3 Thank you for being the best mother
imaginable! You've been there for me in the darkest of my hours without question
without complaint and with all the love, compassion, empathy, sympathy and
devotion anyone could ever ask for. Bless you again and again and again dear
mother.

I also want to dedicate this to Vicky Wilmore who has given me a lot of
love the past few years and who was there for me in some very dark times. Thank
you Vicky sweetheart from the bottom of my heart and soul xxx

Once more besides those two I want to also dedicate this to all the many
millions of people whose lives were taken from them in what amounts to - like
all other wars - a horrible, pointless conflict and an utter waste of life,
something precious that is far too often taken for granted. As I noted before I
found it fitting that I finished this on 30 April 2020 - exactly 75 years after
Adolf Hitler, he who started the [Second World
War](https://en.wikipedia.org/wiki/World_War_II), ended his life. The blankness
of the layout is another way of honouring the poor souls who lost their lives,
many of whom we will never know even their name let alone what they might have
accomplished if it wasn't for their tragic and pointless deaths. Always remember
that life is precious and never ever take it for granted! Believe in yourselves.
Everyone. Do not let anyone ruin that for you ever.

I would like to thank my dear friend [Martijn
Schoemaker](https://www.ficture.nl) for encouraging me in my programming over
the years and who I owe a great deal to. Thank you for believing in me and my
programming abilities (and other abilities) even when I couldn't believe in
myself! Very much appreciated especially coming from an amazing programmer who I
have huge admiration for!

Finally I want to thank Leo Broukhis, Simon Cooper and Landon Curt Noll for
continuing to hold the contest after all these years - and for having selected
my entries. It's a huge honour; thank you! I also happen to love your comments
as well as the award titles. And yes indeed 'most of us could use
*[Double-layered Chocolate Fudge Cake][]*!'

If you wish to contact me please do so. Please contact via mastodon. You can try
email but I'm more likely to respond to mastodon messages.

[Heer (army)]: https://en.wikipedia.org/wiki/German_Army_(1935%E2%80%931945)
[Heer]: https://en.wikipedia.org/wiki/German_Army_(1935%E2%80%931945)
[Luftwaffe]: https://en.wikipedia.org/wiki/Luftwaffe
[Enigma]: https://www.cryptomuseum.com/crypto/enigma/index.htm

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
