# Best tool to reveal holes

Yusuke Endoh  
Twitter: @mametter  


## Judges' comments:
### To use:

    make
    ./prog < textfile > output.gif

### Try:

    ./prog < golem.txt > golem.gif
    ./prog < smily.txt > smily.gif

### Selected Judges Remarks:

To get the best experience, use a GIF viewer that can handle animated gifs.
On OS X you can use Safari using "open -a Safari smily.gif"

Some things to consider are that this 2.5KiB gem encodes a 96 character 8x8
font (naively this could already take 6144 bytes) and a GIF encoder.  But
how does it know which characters are closed?

You should only give this program printable ASCII characters.

Unfortunately this won't run on your PDP8, if you had one, as it needs at
least 2MiB of memory to run in.

## Author's comments:
This program generates an animated GIF from a plain text.  Run:

    gcc -o prog prog.c
    ./prog < invisible.txt > invisible.gif

Open invisible.gif and then wait a minute.  You will see a hidden message.
Can you tell the difference between letters that leaves the mark and ones that does not?

Other examples:

    ./prog < golem.txt > golem.gif
    ./prog < smily.txt > smily.gif

The program itself has a hidden message.

    ./prog < prog.c > prog.gif

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2018, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
