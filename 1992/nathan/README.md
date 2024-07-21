## To build:

``` <!---sh-->
    make all
```


## To use:

``` <!---sh-->
    ./nathan
    # enter some text
```


## Try:

To see some other fun uses:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

### WARNING:

The judges make no claim as to the strength or security
of this program.  It is likely to be nil, or the next
best thing to it.  Still, you might consider installing
it in `/usr/games/nathan`.  :-)


### Note from the judges about the winning category:

The 'winning' category is also open to question.  One could say
that it is a 'file obfuscator'.  One could also say that it
unintentionally abused the intent of rule #7 (that programs
should be freely re-distributable).  We suspect that the author
may not have intended to do this, but that is the way things go
sometimes.

BTW, 'abuse of the rules' entries do not violate the rules.
Entries that violate the rules are disqualified.  Abuse of the
rules entries are ones that tend to 'stretch' the limits and
take the contest into unexpected territory.


### Historical notes from the judges about this entry:

The US International Traffic in Arms Regulations controls certain exportations
going out of the United States.  The U.S.  Munitions List gives the specific
categories of restricted exports.  Because this entry at one time appeared to
fall under this restricted category, the judges originally were not able to
distribute some winning entries outside of the US.

Nathan Sidwell stated that he was willing to distribute the winning source.  To
read HIS instructions of how to obtain his winning program one was able to run:

``` <!---sh-->
    make nathan
    ./nathan
```

to learn how to get a copy of the code.

When someone compiled and ran the code as originally distributed (see:
[nathan.orig.c](%%REPO_URL%%/1992/nathan/nathan.orig.c) the code printed
the following message (sic):

> Export of this program from the USA is governed by the US<br>
> Munitions List from the ITAR (International Traffic in Arms<br>
> Regulations). This list gives the specific categories of<br>
> restricted exports and includes cryptographic exports. Traffic<br>
> entirely external to, entirely internal to, or into the USA is<br>
> not restricted.<br>
> To obtain a copy of the program, email to __EMAIL_ADDRESS_OMITTED__<br>
> with a subject "IOCCC request". If you know that your 'From'<br>
> line is incorrect, add a single line<br>
> "replyto you@your.correct.address" to the body of the message.<br>
> A deamon will autoreply.<br>
> WARNING: You must not re-export this out of the USA, or else<br>
> the men in black might get you.

Today, the [nathan.c](%%REPO_URL%%/1992/nathan/nathan.c) source code
is the source code is what you would have received had you
successfully completed the above instructions.

Today, the above instructions are **no longer necessary**.
There have been reproduced above to provide historical context.


### Personal note from chongo:

I think the situation showed just how ridiculous US crypto regulations really
were/are.  Certain US federal officials can get away with shipping arms to
certain nations in apparent violation of US laws, but I personally can't
re-distribute a program contest entry to the network!


### Updated personal note from chongo:

We removed the Email address from the above quote (although you can
still see it in the [nathan.orig.c](%%REPO_URL%%/1992/nathan/nathan.orig.c)
code) because sending Email to that address is not requirement today.
The [nathan.c](%%REPO_URL%%/1992/nathan/nathan.c) file now contains
the source you would have received in reply.

Thankfully much of the ridiculous US crypto regulations has been
amended to the extent where the above historical "_workaround_" is
**no longer required**.


## Author's remarks:

### Program use

This program is a hello world text encryptor/decryptor. It uses an
enigma (I think) style encryption algorithm, where the encryption
key character is modified by a value, determined from the previous
character.  Non-printable characters (those with ASCII values < `' '`
or > `0x7e`) are passed unaltered, thus any kind of file may be
successfully processed, but if the original is printable, the
processed file will be too. The input is read from `stdin`, and the
output presented to `stdout`. The key, a text string, is presented as
a command argument. This is optional, and if omitted, the file is
self-{de,en}crypted. To specify decryption, a `-` should be given
before the key. (Actually encryption and decryption proper inverse
operations, so you can use decrypt to scramble and encrypt to
descramble, if you're perverse.)

### Portability (A little knowledge is a dangerous thing)

It's written in ANSI C, and doesn't even assume an ASCII character
set, (it has an array of the characters to convert), so should be
portable across many platforms. It passes `gcc -ansi -pedantic -O
-Wall` with no warnings (You may get assignment in conditional
warnings on other platforms though).  Because I've heard that
conditional jumps slow down fast processors, I've eliminated all
the `if`s from the code; indeed, as its only one statement, it should
compile to one instruction and a suitably designed CISC machine. To
speed compilation, there is only one statement in the loop, so that
another scoping level does not need to be opened.

Being an encryptor/decryptor, you probably want the source code to
be obfuscated, to hide the algorithm.

### Obfuscation

In spite of the fact that it looks like a nice friendly hello world
program, it isn't (as documented above). (Short lines have been padded,
as you'll find if you look at an encrypted copy of the source.)

I've also named some of the macros from commonly used functions, just to keep
things muddy. Of course, all the variables are misnamed. The program is kept
simply (one for statement), by serious overuse of `,` and `?:`. These are really
confusing when used together, nested or put in argument lists (is that a comma
operator, or argument separator?).


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
