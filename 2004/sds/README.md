## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2004/sds in bugs.html](../../bugs.html#2004_sds).


## To use:

``` <!---sh-->
    ./sds
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Why not use the program to hide another program in the program? It
must have seemed reasonable at the time.

The ability to hide a message in plain text is quite charming, really.
We must admit to a bit of uncertainty about where you'd find such
messages, or how useful they'd be.  Or, of course, whether all those
horribly badly formatted emails spammers send might contain secret
messages.  Annoyingly, it's a little too obvious that SOMETHING has
been done to a message for us to hide one in the remarks.  :)


## Author's remarks:

[Steganography](https://en.wikipedia.org/wiki/Steganography) is the term for the
family of techniques used for hiding information within other information.
Today, it has many real world uses, particularly for digital watermarking.

This program uses a steganographic technique to hide information in any text
file.  The specific technique used is aimed at writers of obfuscated programs
for the IOCCC, as the hidden information is encoded in the whitespace in the
source file.  As we know, there are up to an additional 2048 characters of
whitespace available to entrants to the IOCCC, so it turns out that this is an
ideal place to hide things.

The program as provided is the steganographic decoder.  Rather than
provide a separate encoding program, you should not be surprised to
learn that I opted to steganographically hide the encoder inside the
decoder.

Try it out.  Compile the program, then type

``` <!---sh-->
    ./sds < sds.c
```

You should see the encoder program displayed.  Now save it, like:

``` <!---sh-->
    ./sds < sds.c > encoder.c
```

Then compile `encoder.c`.  You now have the complete system ready.

The encoder expects to get a filename as an argument.  This filename
is the name of the file containing the information to be hidden.  It
expects the file in which to hide the information to be on the
standard input, and will output the results on the standard output.

You can use it like this (assuming you have a file called remarks):

``` <!---sh-->
    echo 'Hello, World!' > message
    ./encoder message < remarks > remarks_msg
```

Then to decode:

``` <!---sh-->
    ./sds < remarks_msg
    Hello, World!
```

C programs are mostly unaffected by adding steganographic content,
but it is possible in certain circumstances for whitespace to be
changed inside strings where it should be left alone.  Plain text
files are good candidates for hiding information in, but the added
spacing may render the text somewhat difficult to read.


### Obfuscation

This program is obfuscated in a number of ways:

* The code is all but impossible to read due to the spacing.
* The algorithm is well hidden in the code due to copious red-herrings.
* The long expressions cause indentation tools to give poor results.
* And good old fashioned ternary operators are the icing on the cake.

### Compiling the program

The program (and the encoder program) should compile on any
reasonable compiler.  In particular, they are known to compile under
GNU C.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
