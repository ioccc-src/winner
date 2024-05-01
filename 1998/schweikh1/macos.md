This document describes how this was fixed to work with macOS as well as some of
the magic in the entry. Even if you don't have a Mac it might be worth your time
reading especially as some of it details some important fixes and changes in the
original entry as well.

# macOS changes

As an aside: if you have a Mac with the Apple chip, some of the header files
will report an unsupported architecture and unsupported compiler (error,
warning). This will not make the program abort, however, but even with an Intel
CPU though, the original entry will not work in macOS as it stands because
`/usr/include` is hard-coded in the code and macOS does not have it.

Nevertheless, although some of it would not work in other systems where
`/usr/include` exists, the `#define`s would still be found okay, at least until
a file was not found (this limitation was removed in both versions in 2023). see

However, as noted, macOS does **not** have `/usr/include` so this would never
work for macOS without some changes, described next. For macOS you will need the
command line tools installed which can be done like:

``` <!---sh-->
    sudo xcode-select --install
```

An important point is that the original version hard-coded `gcc` but just like
the entry, the alternate version has also removed this limitation despite `gcc`
existing (though it's `clang`) in macOS.

Now as far as how this works if you look at the code of
[schweikh1.c](%%REPO_URL%%/1998/schweikh1/schweikh1.c), on line 55 you'll see a funny command (this goes for
the alternate version as well but a bit different).

Now the key is two magic numbers, one (two times) on a different line shortly below the
string and the other a couple lines further below.

In the original the numbers are, respectively, `44` and `46`, but with the gcc
limitation removed the numbers now are `43` and `45`. But how does this work? Well
the command is:

```
    "0gcc -ansi -E -dM -undef %s /usr/include/%s>r\0 ("
```

which has been changed to be:

```
    "0cc -ansi -E -dM -undef %s /usr/include/%s>r\0 ("
```

Shortly below that you will see, as noted above, the numbers:

``` <!---c-->
    if ((H = fopen (__FILE__+43, 43+__FILE__)))
    while ((fgets (L, (int)sizeof L, H)) != 0) {
	    I[strcspn (I, 45+__FILE__)] = O = 0;
```

The first number in the above C means the length starting from 0 up through the
`>`. The second number is the same starting point but up through the `\0` which
is why it's `+2`. But what happens if only the first number is updated (from the
original)? Most of the output will be just `#define` by itself; in the cases
where there was text after that it was macros that certainly were not defined.
There might have been other errors as well.

Changing this for macOS allows for opening the right files; the problem with
macOS is `/usr/include` does not exist: instead it's
`/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include` which is why
the different command line and the different numbers. The change of the numbers
can be found in the alternate code and the explanation is the same.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

	https://creativecommons.org/licenses/by-sa/4.0/

-->
