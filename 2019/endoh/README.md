## To build:

``` <!---sh-->
    make
```

NOTE: the use of the C compiler optimiser was disabled and `-g` was enabled for
this entry because it is SUPPOSED to crash and it needs debugging symbols.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [2019/endoh in bugs.html](../../bugs.html#2019_endoh).


## To use:

``` <!---sh-->
    ./prog
```


## Try:

If you have `gdb(1)` installed:

``` <!---sh-->
    ./try.sh
```

Note that in macOS installing `gdb(1)` takes multiple steps - it's not just a
matter of installing `gdb(1)` and that's that. The [try.sh](%%REPO_URL%%/2019/endoh/try.sh) script has
only been tested with linux.

You might also wish to try:

``` <!---sh-->
    gdb ./prog || lldb ./prog
```

and then type in `r` (to run program) and then `bt` (for backtrace).


## Judges' remarks:

The purpose of this program is to crash. You'll want to have memorized `man 7
ascii` when debugging it to reveal its purpose.


## Author's remarks:

### backtrace quine:

Compile prog.c with no optimization.

``` <!---sh-->
    cc -g -O0 -o prog prog.c
```

Then, run it.  You will see a segmentation fault.

``` <!---sh-->
    $ ./prog
    Segmentation fault (core dumped)
```

Let's debug.  As usual, run it under gdb.

``` <!---sh-->
    $ gdb ./prog
    (gdb) run
    Starting program: /home/.../prog

    Program received signal SIGSEGV, Segmentation fault.
    0x0000000000000000 in ?? ()
```

Okay, check the backtrace.

```
    (gdb) backtrace
    #0  0x0000000000000000 in ?? ()
    #1  0x0000555555555201 in x23 () at prog.c:35
    #2  0x000055555555571a in x64 () at prog.c:100
    #3  0x0000555555555747 in x65 () at prog.c:101
    #4  0x0000555555555774 in x66 () at prog.c:102
    #5  0x00005555555557ce in x69 () at prog.c:105
    #6  0x0000555555555828 in x6e () at prog.c:110
    #7  0x0000555555555747 in x65 () at prog.c:101
        ...
```

See the line numbers and lookup the ASCII table.

```
     35 = '#'
    100 = 'd'
    101 = 'e'
    102 = 'f'
    105 = 'i'
    110 = 'n'
    101 = 'e'
    ...
```

### One more thing:

The original program can be used as a GDB command file.

```
    gdb -q -x prog.c ./prog | cat
    Reading symbols from ./prog...done.

    Program received signal SIGSEGV, Segmentation fault.
    0x0000000000000000 in ?? ()
    #0  0x0000000000000000 in ?? ()
    #1  0x0000555555555201 in x23 () at prog.c:35
    #2  0x000055555555571a in x64 () at prog.c:100
    #3  0x0000555555555747 in x65 () at prog.c:101
    #4  0x0000555555555774 in x66 () at prog.c:102
    #5  0x00005555555557ce in x69 () at prog.c:105
    #6  0x0000555555555828 in x6e () at prog.c:110
    #7  0x0000555555555747 in x65 () at prog.c:101
    ...
```

By using this, you can confirm that it is actually a quine.

``` <!---sh-->
    gdb -q -x prog.c ./prog | sed -n -r 's/#.*:([0-9]+)/\1/p' | awk '{printf "%c",$1}' > prog2.c
    diff prog.c prog2.c
```

<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
