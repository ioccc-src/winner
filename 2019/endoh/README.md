# Most in need of debugging

Yusuke Endoh  
Twitter: @mametter  


## Judges' comments:
### To use:

    make

### Try:

    ./prog

    gdb ./prog || llvm ./prog

### Selected Judges Remarks:

The purpose of this program is to crash. You'll want to have memorized "man
ascii" when debugging it to reveal its purpose.

## Author's comments:
### backtrace quine

Compile prog.c with no optimization.

    $ gcc -g -O0 -o prog prog.c

Then, run it.  You will see a segmentation fault.

    $ ./prog
    Segmentation fault (core dumped)

Let's debug.  As usual, run it under gdb.

    $ gdb ./prog
    (gdb) run
    Starting program: /home/.../prog

    Program received signal SIGSEGV, Segmentation fault.
    0x0000000000000000 in ?? ()

Okay, check the backtrace.

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

See the line numbers and lookup the ASCII table.

     35 = '#'
    100 = 'd'
    101 = 'e'
    102 = 'f'
    105 = 'i'
    110 = 'n'
    101 = 'e'
    ...


#### One more thing

The original program can be used as a GDB command file.

    $ gdb -q -x prog.c ./prog | cat
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

By using this, you can confirm that it is actually a quine.

    $ gdb -q -x prog.c ./prog | sed -n -r 's/#.*:([0-9]+)/\1/p' | awk '{printf "%c",$1}' > prog2.c
    $ diff prog.c prog2.c

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
