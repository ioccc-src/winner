# The recode configurator documentation (and a fun way to explore my 2020 IOCCC Enigma simulator)

N.B. At the end of this file I have given a fun exercise that can be used to
explore my [Enigma machine](https://www.cryptomuseum.com/crypto/enigma/index.htm)
[simulator](%%REPO_URL%%/2020/ferguson2/prog.c). I really encourage you to do this but of course you don't
have to if you don't wish to.


<div id="toc">
-   [What is recode and why is it recommended?](#recode)
-   [Options](#options)
    *   [Protecting against the same I/O file](#samefile)
    *   [File options parser limitation](#fileoptions)
    *   [`-R` option validation?](#validation)
-   [Piping commands to recode](#pipingtorecode)
-   [Piping recode to the Enigma simulator](#pipingtoenigma)
-   [Manually test the recode program with the Enigma program](#manuallytest)
-   [Only write config file](#onlyconfig)
-   [Reusing a configuration](#reuseconfig)
-   [Write config file, read data file and pass to Enigma simulator](#passtoenigma)
-   [Piping directly to the Enigma code once &#x28;with randomised settings, saved&#x29;](#directlytoenigma)
-   [Usage conclusion](#conclusion)
-   [Example additions](#additions)
-   [Example uses](#exampleuses)
-   [A fun way to explore my Enigma machine, with a surprise](#fun)
</div>


<div id="recode">
# <a href="#toc">What is recode and why is it recommended?</a>
</div>

To demonstrate how to and why you should use the [recode.c](%%REPO_URL%%/2020/ferguson2/recode.c) program with
the [Enigma machine simulator](%%REPO_URL%%/2020/ferguson2/prog.c) I have included some examples here as
well as brief ('brief?!' I am sure many would think but it's brief for me)
commentary.

It would not be possible to do all that the recode program does in my entry
itself but I wanted to demonstrate the features of my entry and this seemed the
best way to do that. It also enhances the use of the simulator to make it
reusable etc.

The recode name idea is that it recodes the input (validating first) to be input
for the simulator itself. It can pseudo-randomly select all the settings, it can
write the settings to a file, read from input file (e.g. for the text to
encipher/decipher if piped to the simulator) etc.

Basically it's a configurator for the Enigma simulator that makes it easier to
use the simulator as well as to reuse the configuration to decipher messages
that have been enciphered by those settings.  But it also tries to make it look
more like the real thing in that it shows the actual rotors (e.g. labelling them
with the Roman numeral, showing their actual orders etc.), the reflectors
(labelling them with B, C and showing the actual strings) etc.

In this file I will show an example of each feature and then get to the
wonderful 'challenge' for everyone.


<div id="options">
# <a href="#toc">Options</a>
</div>

``` <!---sh-->
    ./recode -h
    usage: ./recode [options]
    -v                  display selected settings
    -r                  pseudo-randomly select settings
    -f<input file>      read file for Enigma input
    -R<string|file>     init settings from settings string or file
    -o<output file>     write settings to file
```


`-r` randomises settings. It won't prompt you for settings but it will for input
if you don't give the option to read in a file for input.

`-v` shows selected settings. For example combining `-r` and `-v`:

``` <!---sh-->
    $ echo IOCCC | ./recode -r -v
    Ring 1: (  I) EKMFLGDQVZNTOWYHXUSPAIBRCJ
    Ring 2: (  V) VZBRGITYUPSDNHLXAWMJQOFECK
    Ring 3: ( IV) ESOVPZJAYQUIRHXLNFTGKDCMWB
    Ring  settings: WAR
    Ring positions: XKE
    Reflector: (B) YRUHQSLDPXNGOKMIEBFZCWVJAT
    Plugboard pair #01: XE
    Plugboard pair #02: HJ
    Plugboard pair #03: SA
    Plugboard pair #04: PY
    Plugboard pair #05: CI
    Plugboard pair #06: ZB
    Plugboard pair #07: WD
    Plugboard pair #08: QN
    Plugboard pair #09: RU
    Plugboard pair #10: VG
    1WX5AK4RE1XEHJSAPYCIZBWDQNRUVGIOCCC
```

Though you won't find some of those strings in [recode.c](%%REPO_URL%%/2020/ferguson2/recode.c) or
[prog.c](%%REPO_URL%%/2020/ferguson2/prog.c). Yes the `WAR` for the Ringstellung (Ring settings) is an
amusing coincidence *but it really did happen!*

As for `-f` the contents would be output with the settings e.g. to pipe to
`prog` itself (as if you redirected the file contents to the Enigma machine for
encipherment/decipherment). If the file cannot be opened it sets back to stdin.

`-o` outputs the settings to the file. If the file cannot be opened for writing
or is the same file name (see below) then only stdout will be used.  Example of
randomised output going to a file:

``` <!---sh-->
    $ ./recode -r -oconfig
    IOCCC
    3PP4UB5GG1ELGTKFCOPVBNUYXJAWSDIOCCC
    $ cat config
    3PP4UB5GG1ELGTKFCOPVBNUYXJAWSD$
```

Notice that a terminating newline isn't added. Also note that it outputs to
stdout so you can pipe it to the Enigma machine but at the same time have the
settings saved for deciphering the text later (the configuration does not have
the input but both the configuration and the input text is printed to stdout).

If you want to initialise the settings from previously saved settings (as a
string or an input file that has the same format) use the `-R<settings>` option.
Again note that this does not validate input! Although it detects out of range
for the arrays it doesn't detect duplicates. This is because it wasn't meant to
be any given file or anything else other than the direct output of a previous
run (thus validated). I'm not even guaranteeing that I got the array tests valid
in [recode.c](%%REPO_URL%%/2020/ferguson2/recode.c) `-R` option!


<div id="samefile">
## <a href="#toc">Protecting against the same I/O file</a>
</div>

Because some file systems are case-insensitive I have implemented a
case-insensitive `strcmp()`; if the input file name is the same as the output file
name I won't write to it. From a quick test this is important particularly if
neither file exist because if both calls to `stat()` fail then the inodes will be
the same (since what else could they be set to but the same initial value?).
This might be overprotective but I believe it better to prevent user error where
possible. Of course if neither file exists it might be argued that it's not
necessary to worry since you can't read from a file that doesn't exist. But then
what about if one exists but the other does not?


<div id="fileoptions">
## <a href="#toc">File options parser limitation</a>
</div>

Due to the way the parsing of options is done (no spaces between option char and
argument) shell expansion will not work right so for example doing:

``` <!---sh-->
    $ ./recode -R~/config
```

will _not_ read the file 'config' in the home directory. I show another way to
achieve this later.

This limitation also applies to the `-f` and `-o` options!


<div id="validation">
## <a href="#toc">-R option validation?</a>
</div>

Again the `-R` option does not validate input. For validation you have to run
the program interactively.


<div id="pipingtorecode">
# <a href="#toc">Piping commands to recode</a>
</div>

If stdin is not a tty (`!isatty(0)`) and neither randomised mode nor reading in
from a file is specified then you might just see something like:

``` <!---sh-->
    $ echo testing test tests | ./recode
    1AB2BB3CC1testing test tests

    $ echo testing test tests | ./recode | ./prog - 2>/dev/null
    mfrwxan lzng ofnlu

    $ echo testing test tests | ./recode | ./prog - 2>/dev/null | ./recode
    1AB2BB3CC1mfrwxan lzng ofnlu

    $ echo testing test tests | ./recode | ./prog - 2>/dev/null | ./recode | ./prog - 2>/dev/null
    testing test tests
```

In other words just the defaults. This was to simplify the problems with
prompting again for input if it's invalid (though as you'll see it does a good
job at this anyway).


<div id="pipingtoenigma">
# <a href="#toc">Piping recode to the Enigma simulator</a>
</div>

If you're using recode to recode the input so you don't have to type in the
input manually (if you randomise or read in from previously saved file no input
need be done at all) then make sure to redirect stderr to /dev/null. If you
don't you might see something like:

``` <!---sh-->
    $ ./recode -r | ./prog -
    Ring 1: IOCCC
    Setting 1: Position 1: Ring 2: Setting 2: Position 2: Ring 3: Setting 3: Position 3: Reflector: Plugboard pair 1: Plugboard pair 2: Plugboard pair 3: Plugboard pair 4: Plugboard pair 5: Plugboard pair 6: Plugboard pair 7: Plugboard pair 8: Plugboard pair 9: Plugboard pair 10: DEVIY
```

What happened is that `Ring 1: ` is printed to stderr but since it's not been
redirected to `/dev/null` it prints this out; at this point however it prompts for
input. Why or how it shows the first prompt instead of later on I do not know.
Anyway at this point the simulator is already expecting input to en/decipher.
That's why after I sent EOF it printed out the remaining strings to stderr.


<div id="manuallytest">
# <a href="#toc">Manually test the recode program with the Enigma program</a>
</div>

``` <!---sh-->
    $ cat input
    IOCCC

    $ ./recode -finput
    Rotors:
    (1)   I: EKMFLGDQVZNTOWYHXUSPAIBRCJ
    (2)  II: AJDKSIRUXBLHWTMCQGZNPYFVOE
    (3) III: BDFHJLCPRTXVZNYEIWGAKMUSQO
    (4)  IV: ESOVPZJAYQUIRHXLNFTGKDCMWB
    (5)   V: VZBRGITYUPSDNHLXAWMJQOFECK
    Input rotor 1 (1 - 5): 1
    Input rotor 2 (1 - 5): 2
    Input rotor 3 (1 - 5): 3
    Input setting 1 (A - Z): A
    Input setting 2 (A - Z): A
    Input setting 3 (A - Z): A
    Input position 1 (A - Z): A
    Input position 2 (A - Z): A
    Input position 3 (A - Z): A
    Reflector:
    (1) (B) YRUHQSLDPXNGOKMIEBFZCWVJAT
    (2) (C) FVPJIAOYEDRZXWGCTKUQSBNMHL
    Input reflector (1 - 2): 2
    Input plugboard pair 1: AB
    Input plugboard pair 2: CD
    Input plugboard pair 3: ..
    Input plugboard pair 4: EF
    Input plugboard pair 5: GH
    Input plugboard pair 6: IJ
    Input plugboard pair 7: KL
    Input plugboard pair 8: MN
    Input plugboard pair 9: OP
    Input plugboard pair 10: QR
    1AA2AA3AA2ABCD..EFGHIJKLMNOPQRIOCCC
```

Notice that I skipped a [plugboard
pair](https://www.cryptomuseum.com/crypto/enigma/i/sb.htm); this can be done in
a number of ways but two dots is one. Notice also that it's in a different order
than the simulator: because with the size restrictions on my entry I saved bytes
by using the same loop where I could. It just felt more natural to have them
grouped together in a configurator for the [simulator](%%REPO_URL%%/2020/ferguson2/prog.c).

``` <!---sh-->
    $ echo 1AA2AA3AA2ABCD..EFGHIJKLMNOPQRIOCCC | ./prog - 2>/dev/null
    HQNVO
    $ echo 1AA2AA3AA2ABCD..EFGHIJKLMNOPQRIOCCC  | ./prog - 2>/dev/null | echo 1AA2AA3AA2ABCD..EFGHIJKLMNOPQRHQNVO | ./prog  - 2>/dev/null
    IOCCC
```

As you can see the `recode` program prompts for the settings and outputs the
input for the Enigma program. I then copied/pasted that output to the program
and got the result `HQNVO`.

Following this I piped the original output (of `recode`) to the simulator and then
piped that to the echo of the input settings (replacing the IOCCC with the
Enigma enciphered output) and then got the result IOCCC: the original input!
(This was before I implemented the `-R` option to greatly simplify things.)

Of course the last command was redundant in that I didn't need to show the first
part again; I could have just done the latter part but I wanted to show the way
the pipeline works with settings etc.

What happens if the plugboard pairs are the same but in a different order? It's
the same output:


``` <!---sh-->
    $ echo 1AA2AA3AA2AB..CDEFGHIJKLMNOPQRIOCCC|./prog - 2>/dev/null
    HQNVO
```

Also if you flip the order of the letters in the pair e.g. the AB as BA instead:

``` <!---sh-->
    $ echo 1AA2AA3AA2BA..CDEFGHIJKLMNOPQRIOCCC|./prog - 2>/dev/null
    HQNVO
```

<div id="onlyconfig">
# <a href="#toc">Only write config file</a>
</div>

``` <!---sh-->
    $ ./recode -v -oconfig -finput >/dev/null
    Rotors:
    (1)   I: EKMFLGDQVZNTOWYHXUSPAIBRCJ
    (2)  II: AJDKSIRUXBLHWTMCQGZNPYFVOE
    (3) III: BDFHJLCPRTXVZNYEIWGAKMUSQO
    (4)  IV: ESOVPZJAYQUIRHXLNFTGKDCMWB
    (5)   V: VZBRGITYUPSDNHLXAWMJQOFECK
    Input rotor 1 (1 - 5): 1
    Input rotor 2 (1 - 5): 2
    Input rotor 3 (1 - 5): 3
    Input setting 1 (A - Z): A
    Input setting 2 (A - Z): C
    Input setting 3 (A - Z): E
    Input position 1 (A - Z): B
    Input position 2 (A - Z): D
    Input position 3 (A - Z): F
    Reflector:
    (1) (B) YRUHQSLDPXNGOKMIEBFZCWVJAT
    (2) (C) FVPJIAOYEDRZXWGCTKUQSBNMHL
    Input reflector (1 - 2): 2
    Input plugboard pair 1: AB
    Input plugboard pair 2: CD
    Input plugboard pair 3: EF
    Input plugboard pair 4: GHIJ
    Input plugboard pair 5: IJ
    Input plugboard pair 6: KL
    Input plugboard pair 7: MN
    Input plugboard pair 8: OP
    Input plugboard pair 9: QR
    Input plugboard pair 10: ST
    Ring 1: (  I) EKMFLGDQVZNTOWYHXUSPAIBRCJ
    Ring 2: ( II) AJDKSIRUXBLHWTMCQGZNPYFVOE
    Ring 3: (III) BDFHJLCPRTXVZNYEIWGAKMUSQO
    Ring  settings: ACE
    Ring positions: BDF
    Reflector: (C) FVPJIAOYEDRZXWGCTKUQSBNMHL
    Plugboard pair #01: AB
    Plugboard pair #02: CD
    Plugboard pair #03: EF
    Plugboard pair #04: GH
    Plugboard pair #05: IJ
    Plugboard pair #06: KL
    Plugboard pair #07: MN
    Plugboard pair #08: OP
    Plugboard pair #09: QR
    Plugboard pair #10: ST
```

Notice that I redirect stdout to /dev/null so that the config is only written to
the file config. But also notice that for [plugboard
pair](https://www.cryptomuseum.com/crypto/enigma/i/sb.htm) 4 I typed in `GHIJ`
and it didn't report an error. Neither did it complain about `IJ` in the next
pair.  This is because it consumes input overflow.

It shouldn't be this way for the simulator though because that could cause
inconsistent number of characters expected before the text to encipher.

``` <!---sh-->
    $ cat config
    1AB2CD3EF2ABCDEFGHIJKLMNOPQRST

    $ ( cat config ; cat input ) | ./prog - 2>/dev/null
    LRAVE

    $ ( cat config ; cat input ) | ./prog - 2>/dev/null | ( cat config ; echo LRAVE ) | ./prog  - 2>/dev/null
    IOCCC
```

What if you don't want to worry about having to specify input but just have the
settings written? You can do that too by either sending a newline or else
directly type ctrl-d (or whatever you have EOF set to) or give it an empty file.

The following are all equivalent in that they will write to a settings file (the
first one will print a newline with the echo but that won't matter):

``` <!---sh-->
    $ echo | ./recode -r -osettings
    $ echo -n | ./recode -r -osettings
    $ > empty
    $ ./recode -r -osettings < empty
    $ cat empty | ./recode -r -osettings
    $ ./recode -r -osettings
    ^D
```

(Above ^D was not shown but I typed it.) The way it works: if nothing is read
the buffer remains `NULL` and so I don't print it but still do print the settings
file. (Actually even if `getdelim()` fails you're supposed to free the buffer so I
set another variable to indicate if it should be printed.)

<div id="reuseconfig">
# <a href="#toc">Reusing a configuration</a>
</div>

``` <!---sh-->
    $ echo -n|./recode -r -oconfig
    4UH5II1RJ1SPIFEJLYGZWRTBHVCAMN$

    $ cat input.txt
    IOCCC 2020 Enigma simulator example text file

    This is a sentence.

    This is another sentence.

    $ ( cat config ; cat input.txt  ) | ./prog - 2>/dev/null > output
    $ cat output
    AAPRT 2020 Dkemny tpgnjsjai xpovrgl jvgs wxra

    Fytt ly m xyiilaqh.

    Ybbp ox dmuzerm oscwgytb.
    $ ( cat config ; cat output ) | ./prog  - 2>/dev/null > io
    $ diff io input.txt
    $
```

Alternatively you can just use the `-R` and `-f` options:

``` <!---sh-->
    $ ./recode -finput.txt -Rconfig | ./prog - 2>/dev/null > output2
    $ diff output output2
    $
```


<div id="passtoenigma">
# <a href="#toc">Write config file, read data file and pass to Enigma simulator</a>
</div>

```
    $ ./recode -finput.txt -oconfig | ./prog - 2>/dev/null > output
    Rotors:
    (1)   I: EKMFLGDQVZNTOWYHXUSPAIBRCJ
    (2)  II: AJDKSIRUXBLHWTMCQGZNPYFVOE
    (3) III: BDFHJLCPRTXVZNYEIWGAKMUSQO
    (4)  IV: ESOVPZJAYQUIRHXLNFTGKDCMWB
    (5)   V: VZBRGITYUPSDNHLXAWMJQOFECK
    Input rotor 1 (1 - 5): 2
    Input rotor 2 (1 - 5): 5
    Input rotor 3 (1 - 5): 3
    Input setting 1 (A - Z): C
    Input setting 2 (A - Z): O
    Input setting 3 (A - Z): D
    Input position 1 (A - Z): E
    Input position 2 (A - Z): L
    Input position 3 (A - Z): O
    Reflector:
    (1) (B) YRUHQSLDPXNGOKMIEBFZCWVJAT
    (2) (C) FVPJIAOYEDRZXWGCTKUQSBNMHL
    Input reflector (1 - 2): 2
    Input plugboard pair 1: TR
    Input plugboard pair 2: SN
    Input plugboard pair 3: OG
    Input plugboard pair 4: ME
    Input plugboard pair 5: XY
    Input plugboard pair 6: WZ
    Input plugboard pair 7: UV
    Input plugboard pair 8: AB
    Input plugboard pair 9: CD
    Input plugboard pair 10: FI

    $ cat config
    2CE5OL3DO2TRSNOGMEXYWZUVABCDFI
```

Besides a famous book that I happen to love (who doesn't? Ah, but what is it
Cody?) there's also a reference to code which I also love (just as all
participants of the IOCCC do). Other things there don't mean anything but what
does is the output:


``` <!---sh-->
    $ cat output
    DBFAF 2020 Ittejg ltblwriac uqdfqvr dhqh ghhf

    Jsjy ce v pxdmullo.

    Sara tj rtaayak uxfhjcti.

    $ ./recode -Rconfig -foutput | ./prog - 2>/dev/null
    IOCCC 2020 Enigma simulator example text file

    This is a sentence.

    This is another sentence.
```


<div id="directlytoenigma">
# <a href="#toc">Piping directly to the Enigma code once (with randomised settings, saved)</a>
</div>

This is like the above only randomised:

``` <!---sh-->
    $ ./recode -r -oconfig|./prog - 2>/dev/null
    IOCCC
    UGEVP
```


Note that I typed in `IOCCC` and sent `EOF` (ctrl-d); the settings were written to
the config file (for deciphering later) and then all of it was piped to the
Enigma entry resulting in the line below IOCCC. But let's verify it worked out
okay:

``` <!---sh-->
    $ cat config
    2BM4GJ3HK1LNCBXWRMGKSYIAZUTPVJ
```

Without having to copy/paste intermediate results:

``` <!---sh-->
    $ echo IOCCC | ./recode -Rconfig | ./prog - 2>/dev/null | ./recode -Rconfig | ./prog - 2>/dev/null
    IOCCC
```

You can also use a string for the `-R` option. I'll use command substitution and
actual pasting to demonstrate:

``` <!---sh-->
    $ echo IOCCC | ./recode -R$(cat config) | ./prog - 2>/dev/null | ./recode -R2BM4GJ3HK1LNCBXWRMGKSYIAZUTPVJ | ./prog - 2>/dev/null
    IOCCC
```


<div id="conclusion">
# <a href="#toc">Usage conclusion</a>
</div>

That should give you an idea of how to use the `recode` program. I leave it as
an exercise to the reader to implement additional features but here are some
ideas of what could be done and how this entry might be used (including that
delicious challenge).


<div id="additions">
# <a href="#toc">Example additions</a>
</div>

*   Add code, to [prog.c](%%REPO_URL%%/2020/ferguson2/prog.c), that tries to determine possible decipherments based on
a given crib (or set of cribs).


<div id="exampleuses">
# <a href="#toc">Example uses</a>
</div>

*   Take an actual key sheet and message for that day and try and decipher the
message (might help if you know German!). I haven't actually done this for
reasons I explained in the remarks (including that I cannot easily verify one
particular as well as the fact that there were different procedures, different
machines etc. - plus my vision is not good enough for the quality of the
pictures).

*   Try making sense of a politician's speeches by putting them into the
simulator. It might not make much sense but can it honestly be that much worse ?
:) Actually yes it could be (and we don't need the Enigma helping them either)
and I can think of a whole host of other things more entertaining including
watching dry paint stay dry on a wall but why not poke fun at politicians
anyway?

* Best idea: try the below experiment!


<div id="fun">
# <a href="#toc">A fun way to explore my Enigma machine, with a surprise</a>
</div>

As I was making the above silly list something occurred to me. My [other
entry](https://www.ioccc.org/2020/ferguson1/index.html) this year includes a
[recipe for a wonderful double-layered chocolate fudge
cake](https://www.ioccc.org/2020/ferguson1/chocolate-cake.html) but then
shouldn't this entry include something that is fun too? But if that's the case
why on Earth should it be unscrambled? It would be more fun and a great way to
explore this entry if you have to use the Enigma machine to read the message!

So this is what I offer: if you take one of the settings below and run the
Enigma machine simulator on the file [enigma.html][enigma.html] you will
unlock a html file with something special in it. I recommend you decrypt it to
`decrypted.html` and open it in a web browser.

The correct settings is listed below but *you* must determine which one is the
right line. Before you do this here are some things to ask yourself:

0.  Are any invalid input?

1.  Is there some other kind of trickery involved here?

I can think of the best way to answer these and I think I need not even mention
it. Have fun and enjoy!


## Hints:

0.  It's not the middle one.

1.  Yes there are some things kind of spelt here. Some things spelt mean nothing
whatever and can be considered coincidences. Some were randomised.

2.  There is an obscure thing about my entry that can help locate the proper key
of the 16 given below! The questions are what is it and is is it worth going
this way? (I think the second answer is 'yes' but that's me.)


Of course, the above points might or might not be relevant. Didst you really
think that I would give too much away? :)

```
    142CHOCOLATESVCAKESTBJLKMUMVWX
    0EZ4PC1CC0PGTAQSOXWNMDRYKFUZEI
    3UY0XF4QG1GTJQLARPKHBEMCOFVUIN
    0WE1HK4PL0RVSGXFDKENZYTPCMAHUW
    2LV0KC1IE0HTFPCLWOJDBQIRVMEAGN
    1SS4QX2RY1SRAQGKUYHCBLPFJDVTNZ
    3IW1QR0TZ0GQEDWIYJUPMFZBRAONHS
    3OP1KN4MO0HPFZCEAKYQIRXGVMOTUW
    4OC2CC0AK1CODELUVRSNGKIZBJPTMY
    4MU0MS1CA1KELUVRSXTABJNOCDMQFG
    0MU4MC2HO1CLATEFBJMONPQRVWXYZD
    125CHOCOLATESEXCAKESJADFNOPQRS
    0CH3OC1OL1ATEMBJNOCDLSIFWHRVXY
    4MU1MS3CA0KECHOLATBJSNPXVUFGZY
    4VW0SL1YB0IYJSLBECKTNAXGPUVHRF
    0MC4OH2CO1LATEUMBJCDFGHINOPRQS
```

BTW: what's the middle of a list with even numbered items anyway?

To help you out, though, this is how you might do the decrypting. Assuming that
the key you wish to select is

```
    0EZ4PC1CC0PGTAQSOXWNMDRYKFUZEI
```

you can do:

``` <!---sh-->
    ./recode -R0EZ4PC1CC0PGTAQSOXWNMDRYKFUZEI -fenigma.html | ./prog - 2>/dev/null > decrypted.html
```

Then open `decrypted.html` in your browser.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
