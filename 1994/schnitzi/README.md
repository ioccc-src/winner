# Best Layout:

Mark Schnitzius
ISX Corporation
1165 Northchase Pkwy, Suite 120
Marietta, GA 30067
USA

## To build:

```sh
make all
```

## To run:

```sh
./schnitzi < textfile
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) increased the buffer
size from 100 to 10000. Changing it to use `fgets()` instead of `gets()` is more
problematic because when feeding the source code to the program the output
results in compiler errors and not only that but the gets() is still there in
the generated output. Even changing the buffer size can result in compilation
errors if not done correctly. The generated output also does not have a changed
buffer size. Changing it to use fgets() can happen later, maybe, but bigger
files can now be parsed by the original code. An example is the Makefile. Cody
gave some tips on how this entry works, in order to make the entry use fgets()
and compile successfully too, in the [bugs.md](/bugs.md) file. Thank you Cody!

For the original source file [schnitzi.alt.c](schnitzi.alt.c) see below.


## Try:

```sh
./schnitzi < /etc/motd
./schnitzi < /etc/passwd
```


### Alternate code:

For the original version with a smaller buffer try:

```sh
make alt
```

Use `schnitzi.alt` as you would `schnitzi`.

## Judges' comments:


Try:

	./schnitzi < schnitzi.c

Compare the output of the program with its source.  Sure the output
is different, but there is more than meets the `diff`'s eye.  Can you
find out why?

## Author's comments:

### SPOILER:

This is a program which takes any text file as input and 'flips'
the input file along a diagonal running from the top left corner
down to the bottom right.  In other words, the first row in the
file ends up written down the first column of the result, the
second row is written down the second column, etc. The program
is run by redirecting a file into the executable on the command
line; for instance, for the included 'info' file, the program
would be run as follows:

    	schnitzi < info
    
The program generates interesting results when its source file is
used as input:
    
    	schnitzi < schnitzi.c
    
The result of this command is a program which does the exact same
thing -- in other words, both the program and the "flipped"
version of itself work identically (you'll need to redirect the
output of the above command into a separate file and compile it).
You might notice some differences in the flipped version, though.
First off, a secret message becomes visible that was not visible
in the original program.  Also, much of the code shows up in 
different places in the flipped program than it appeared in the
first program.  My first version of this program was perfectly 
symmetrical along the diagonal, but later found out there were
interesting ways to break the symmetry.  The best way to see this 
is to load both the original and flipped versions of the program
into an editor and switch back and forth between them rapidly.

C tokens longer than a character (such as "main") proved difficult
to use in both the original and flipped versions (after flipping,
they show up as a string of single letters on successive lines).
However, I found that it was possible to get around this through
a few well-placed comments.  An earlier version of this program
used nearly every single-character token in the "shared" area;
however, it proved to be too large for contest guidelines (although
the code itself is only about 300 characters, the extra whitespace
needed to pad it put it over the limit -- it nearly filled a 79 by
79 area, adding up to over 4000 total characters).  I will provide
this other version to anyone interested -- contact me by email
at schnitzi@east.isx.com.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
