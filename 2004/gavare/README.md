## To build:

``` <!---sh-->
    make
```

There are three alternate versions; see [alternate code](#alternate-code) below
for more details.


## To use:

``` <!---sh-->
    ./gavare > ioccc_ray.ppm
```

Open `ioccc_ray.ppm` with a viewer capable of viewing PPM files. Alternatively,
if you have ImageMagick installed, you can convert it to a jpeg:

``` <!---sh-->
    convert ioccc_ray.ppm ioccc_ray.jpg
```

and then view `ioccc_ray.jpg` in a graphics viewer, editor or web browser.


## Try:

If you have `xv(1)` you can do:

``` <!---sh-->
    ./gavare | xv -
```

to not worry about writing it to a file and just viewing the image it creates.


## Alternate code:

The alternate code [gavare.alt.c](%%REPO_URL%%/2004/gavare/gavare.alt.c) allows you to change the size of the
image as well as the anti-alias setting, when compiling.

The author also provided [on their web page for the
entry](https://gavare.se/ioccc/ioccc_gavare.c.html) an unobfuscated version that
was used during development, which we have included in the file
[gavare.r3.c](%%REPO_URL%%/2004/gavare/gavare.r3.c).

Finally, the file [gavare.alt2.c](%%REPO_URL%%/2004/gavare/gavare.alt2.c) sets binary mode
on `stdout` which theoretically should work in Windows.


### Alternate build:

To build the configurable and unobfuscated versions:

``` <!---sh-->
    make alt
```

To change the default size from 1024x768 try:

``` <!---sh-->
    make clobber XX=640 YY=480 alt
```

You might also wish to change the anti-alias setting:

``` <!---sh-->
    make clobber AA=2 alt
```

You may of course combine the above two commands and give any combination you
wish.

This is not possible with the author's version but it is with the alt versions
(Windows - see below - and otherwise).

As the Windows version will not compile on most viewers' systems we do not build
it with `make alt`; instead try:

``` <!---sh-->
    make alt2
```


### Alternate use:

Use `gavare.alt`, `gavare.r3` or `gavare.alt2` as you would `gavare` above.


## Judges' remarks:

For users of systems that distinguish between text and binary mode
(you know who you are), add a library call that specifies binary mode
for `stdout` as the first statement of `main()`,
or use `freopen("ioccc_ray.ppm", "wb", stdout);` and do not use redirection.

A freely distributable command-line version of Microsoft Visual C
exhibits an optimizer bug when compiling this entry. Disable `/Og` for
best results.

The judges were able to figure out how to control position
(in all 3 coordinates), size, and color (to some extent) of the balls.


## Author's remarks:

It is possible to write some kinds of programs in C without using reserved
words.  For very short and trivial programs, it usually isn't very hard to
write a variant using no reserved words, but with this program I want to
show that also non-trivial programs can be written this way.  This IOCCC
entry contains no reserved words (I don't count `main` as a reserved word,
although the compiler gives it special meaning) and no preprocessor
directives.

This program is a small
[ray-tracer](https://en.wikipedia.org/wiki/Ray_tracing_&lpar;graphics&rpar;). The first
line of the source code may be modified if you want the resulting image to be of
some other resolution than the predefined. The `A` value is an anti-alias
factor. Setting it to `1` disables the anti-aliasing feature which makes the
output look bad, but setting it too high makes the trace take a lot more time
to complete.

The ppm image can then be viewed using an image viewer of your own choice.
(Running the ray-tracer may take several minutes, even on fast machines,
so be patient.)

I am very much aware about the fact that I'm breaking the guidelines. For
example, the word `int` is a reserved word and therefore all variable
declarations are implicit.  There will no doubt be _lots_ of warnings,
no matter which compiler is used.  Still, the source code should be word-
length-independent and endianness-independent.


### Humor

Another reason for writing code without using reserved words is that many
text editors will make all reserved words turn BOLD when printed on
paper.  Since I care for the global environment, we shouldn't waste any
more laser toner, or ink, than necessary. Everyone should write C code
with no reserved words, and our world will be a better place.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
