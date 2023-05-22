# Best one liner

Jack Applin [with help from Robert Heckendorn]
US  
<https://www.cs.colostate.edu/~applin/>

## To build:

```sh
make all
```

## Try:

```sh
./applin
```

[Yusuke Endoh](/winners.html#Yusuke_Endoh) provided a patch to get this to
not issue crash and [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson)
fixed this to work with macOS (it printed the string `H????` in a seemingly
infinite loop of printing more and more `?`s).

The problem with the crash is that it destructively rewrites string literals but
with `strdup()` it's safe.

For macOS it's because there was no prototype for `execlp()` and macOS has
problems with missing prototypes for some functions (this was also seen when
Cody fixed [1984/anonymous](/1984/anonymous/anonymous.c) for macOS as well
though that fix was more complicated). Ironically this fix was discovered
through linux!

NOTE: originally this entry did not print a newline prior to returning to the
shell, after the output (despite having `\n` in the string - why?) but to make
it more friendly to users Cody made it print a `\n` prior to returning to the
shell.

Thank you Yusuke and Cody for your help!

## Judges' remarks:

One liner programs are short but twisted.  This `Hello, world!` version
certainly takes its time saying hello.

## Author's remarks:

No remarks were provided by the author.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
