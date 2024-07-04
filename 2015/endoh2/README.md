## To build:

``` <!---sh-->
    make
```


## To use:

``` <!---sh-->
    ./prog
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

At this point you might be wondering, [WTF](http://acronyms.thefreedictionary.com/WTF)?\*

* What The Freak (polite form)

* What's This For? (you may be wondering)

* What the Fish (python form)

How is this code obfuscated?  Well look again:

``` <!---sh-->
    less prog.c

    more prog.c
```

Where did those underscores come from?  Well [RTFS](http://acronyms.thefreedictionary.com/RTFS)!\*\*

** Read the Freaking Source (polite form)
** Read The Freaking Screen (polite form)

If you are still puzzled, look at [prog.c](%%REPO_URL%%/2015/endoh2/prog.c) with your favorite text editor.


## Author's remarks:

**Follow these instructions literally!**

``` <!---sh-->
    cat prog.c
    gcc -w -o prog prog.c
    ./prog
```

You will do a double take.

Hint 1: Do `less prog.c`.  You will see an **emphasized** string if your
terminal supports bold.

Hint 2: Do `wc -c prog.c`.  This is very long one-liner.

Hint 3: Open the source with an editor like `vim` or `emacs`.

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
