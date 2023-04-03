# Best small program

Volker Diels-Grabsch  
<https://njh.eu>  

## To build:

```sh
make
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) made the author's
statement that the entry compiles cleanly true by fixing `warning: a function
declaration without a prototype is deprecated in all versions of C ` (in
main()). Not strictly necessary but if he's making fixes he might as well. Thank
you Cody!

## To run:

```sh
./prog < file > file.Z
```

## Try:

```sh
dd bs=1024 count=2048 < /dev/zero | compress > ref.Z
dd bs=1024 count=2048 < /dev/zero | ./prog > dg1.Z
cmp ref.Z dg1.Z

cd ../mills ; make ; cd ../diels-grabsch1
compress < ../mills/Shakespeare.txt > ref.Z
./prog < ../mills/Shakespeare.txt > dg1.Z
cmp ref.Z dg1.Z # Oops, the files differ
zcat < dg1.Z | cmp - ../mills/Shakespeare.txt # Decompresses correctly. What is going on?
```

## Judges' comments:

Finally, IOCCC now has its own text compression program, and it is short enough
to qualify for the Best Short Program award! That said, can you compress it down
to a one-liner, still producing files in the UNIX compress format, albeit
sacrificing the compression ratio?

Can you explain why the zero file compresses identically by the entry and the
standard compress tool, but the text file compresses differently? The judges
know. :)

## Author's comments:

### A tiny "compress" tool:

#### Usage:

```sh
./prog < input.txt > input.txt.Z
```

#### Example:

```sh
./prog < guidelines.txt > guidelines.txt.Z
```

#### Check for correctness:

```sh
zcat guidelines.txt.Z > guidelines2.txt
diff -s guidelines.txt guidelines2.txt
```

Of course you can  also use [2015/mills2](/2015/mills2/mills2.c) instead of
`zcat` to verify the output file. The achieved compression ratio roughly matches
that  of the classic Unix compress tool. And the source code is  very
compressed, too: It has exactly the same size as the  paragraph you are reading
right now. And exactly the same shape. Nevertheless, it is portable C99 code
that runs on 32-bit and 64-bit platforms. It compiles without warnings on both
GCC and Clang even with `-Wextra and -Weverything`.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
