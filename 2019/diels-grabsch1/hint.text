# Best small program

Volker Diels-Grabsch  
<https://njh.eu>  


## Judges' comments:
### To use:

    make

    ./prog < file > file.Z

### Try:

    dd bs=1024 count=2048 < /dev/zero | compress > ref.Z
    dd bs=1024 count=2048 < /dev/zero | ./prog > dg1.Z
    cmp ref.Z dg1.Z

    compress < ../mills/Shakespeare.txt > ref.Z
    ./prog < ../mills/Shakespeare.txt > dg1.Z
    cmp ref.Z dg1.Z # Oops, the files differ
    zcat < dg1.Z | cmp - ../mills/Shakespeare.txt # Decompresses correctly. What is going on?

### Selected Judges Remarks:

Finally, IOCCC now has its own text compression program, and it is short
enough to qualify for the Best Short Program award! That said, can you
compress it down to a one-liner, still producing files in the UNIX compress format,
albeit sacrificing the compression ratio?

Can you explain why the zero file compresses identically by the entry and the
standard compress tool, but the text file compresses differently? The judges know. :)

## Author's comments:
### A tiny "compress" tool

`Usage:`

    ./prog < guidelines.txt > guidelines.txt.Z

`Check for correctness:`

    zcat guidelines.txt.Z > guidelines2.txt
    diff -s guidelines.txt guidelines2.txt

`Of course you can`  
`also use 2015/mills2 instead of zcat to verify the output`  
`file. The achieved compression ratio roughly matches that`  
`of the classic Unix compress tool. And the source code is`  
`very compressed, too: It has exactly the same size as the`  
`paragraph you are reading right now. And exactly the same`  
`shape. Nevertheless, it is portable C99 code that runs on`  
`32-bit and 64-bit platforms. It compiles without warnings`  
`on both GCC and Clang even with -Wextra and -Weverything.`

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2019, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
