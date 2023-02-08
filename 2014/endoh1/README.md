# Most square (YODA award)

Yusuke Endoh  
<mame@ruby-lang.org>  
<https://github.com/mame/>  


## Judges' comments:
### To build:

    make

### To run:

    ./prog > foo.c

### Try:

    ./prog > main.c

    make main
    ./main Hello

### Selected Judges Remarks:

Big terminals with tiny fonts have their uses in certain cases.
One of them is:

    ./prog < prog.c > treacle.c
    make treacle
    # or instead of make: cc -Wno-empty-body -funsigned-char treacle.c -o treacle
    ./treacle

When using a smart phone to read the output, you may need to
step back to see the bigger picture because that picture is worth
more than 1000 words.

## Author's comments:
### Remarks

You may want to use a large display with a very small-font terminal.

### Spoiler

Decompress `src.zip` if you need explanation.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
