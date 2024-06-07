## To build:

``` <!---sh-->
    make
```


### Bugs and (Mis)features:

The current status of this entry is:

```
    STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [2006/borsanyi in bugs.html](../../bugs.html#2006_borsanyi).


## To use:

``` <!---sh-->
    ./borsanyi string > file.gif
```


## Try:

``` <!---sh-->
    ./try.sh
```

We recommend you input for the filename `example.gif` and for the string
`ioccc@example.com`. The script will not overwrite files. It runs the program in
a loop until you answer that you do not wish to make another.


## Judges' remarks:

This entry uses a very user-friendly representation of the font
it uses (with a few exceptions).   Check out the source and see
yourself!  :-)

The resulting GIF file is likely to puzzle optical character
recognition tools.  The amount of imagination necessary to
recognise the `@` character will certainly challenge a few
anti-CAPTCHA tools.


## Author's remarks:

### Email address to gif converter

### Introduction:

Most spam robots collect email addresses from the websites of
innocent people, like you. Conference organizers cannot disclose
the participant's address to prevent malicious users from
grabbing them. One solution is to write as `my_email _at_ address
_dot_ com`. But robots are clever enough to sort that out.  A
more sophisticated approach is to create an image file with the
email address and put that on the web page.

This program creates a GIF image file from the address given in the command
line. To avoid complications with patent issues the [LZW
compression](https://en.wikipedia.org/wiki/Lempel-Ziv-Welch) feature is not
used. A typical email address is stored in less than 1-2 kilobytes.


### Usage:

``` <!---sh-->
    make all
    ./borsanyi my@example.com > email.gif
    my_favourite_gif_viewer email.gif
```

The address cannot be longer than 42 characters, and may consist of
the characters: `a-z_A-Z0-9@.-`.

The program is (like email addresses are) case insensitive.


### Obfuscation:


Multicore support is a must in present-day applications. This
entry supports up to 25 cores.  The odd names in the bottom
part of the program do have a meaning, they are not there just
for obfuscation. The preprocessor is used to keep the program
small, in fact, everything is a macro. Are you familiar with
the GIF format? Studying this program will give you a (very)
little insight.


### Questions:

After analyzing the source code, try to answer these questions:

1. How can you add a further supported symbol?
2. Can you alter the look of the output characters?
3. What limits the number of input characters to 42?


### Portability:

The program uses POSIX threads (using the linker flag `-lpthread`).
The program accepts email addresses not longer than 42 bytes
composed from letters, digits, and the `@._-` symbols. An address
not obeying these rules will cause undefined behaviour.  The
program is not expected to depend on endianness.  The standard
output is used for a binary output, which might cause problems.
To avoid most caveats, the program does not output the octet
`0x0a`.  The program assumes the use of ASCII.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
