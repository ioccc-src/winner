## To build:

``` <!---sh-->
    make alt
```

**NOTE**: the original code will not work on any system other than
[VAX-11](https://en.wikipedia.org/wiki/VAX-11) and
[PDP-11](https://en.wikipedia.org/wiki/PDP-11) and this is why we encourage you
to use the alt version instead. See [original code](#original-code) below for
the original version.


### Bugs and (Mis)features:

The current status of this entry is:

> **STATUS: INABIAF - please DO NOT fix**

For more detailed information see [1984/mullender in bugs.html](../../bugs.html#1984_mullender).


## To use:

``` <!---sh-->
    ./mullender.alt [microseconds]
```

Hit ctrl-c/intr to exit the program.

The default microseconds is 190000 as this is approximately how long it slept in
the original entry but it can be no lower than 5000 as any lower doesn't work
very well. This feature is so you can experiment with different speeds in
between writes. It can be useful if your CPU is too fast :-)

The author stated that the original version also had a delay but the difference
is it required one to hit enter for it to print another line; the alternate code will
start over once it times out or if one hits a key.

Note that the microseconds is argc and it uses `atoi()` which does NOT check for
overflow!

**BTW**: is there such a thing as too fast a CPU ? :-) Actually yes for certain code
which is probably not as uncommon as you think :-).


## Try:

``` <!---sh-->
    ./mullender.alt

    ./mullender.alt 5000        # wait for 5000 microseconds and see what happens

    ./mullender.alt 20000       # wait for 20000 microseconds and see what happens

    ./mullender.alt 100000      # wait for 100000 microseconds and see what happens
```

What happens if you hit enter after it reaches the end of the line? Why? What
happens after some time of waiting?


## Original code:

This original code will only execute correctly if your machine is a
[VAX-11](https://en.wikipedia.org/wiki/VAX-11) or
[PDP-11](https://en.wikipedia.org/wiki/PDP-11). In the following years, 1985 on,
machine dependent code was discouraged.


### Original build:

``` <!---sh-->
    make all
```


### Original use:

``` <!---sh-->
    ./mullender
```


## Judges' remarks:

Without question, this C program is the one of the most obfuscated C program
that has ever been received!  Like all great contest entries, it resulted in a
change of rules for the following year.  To prevent a flood of similar programs,
the rules were changed, requesting non-machine specific code.

This program was selected for the 1987 t-shirt collection.

The C startup routine, via [crt0.o](https://en.wikipedia.org/wiki/Crt0),
transfers control to a location named `main`.  In this case, `main` just happens
to be in the data area.  The array of `short`s, which has been further
obfuscated by use of different data types, just happens to form a meaningful set
of [PDP-11](https://en.wikipedia.org/wiki/PDP-11) and
[VAX](https://en.wikipedia.org/wiki/VAX) instructions.

The first word is a [PDP-11](https://en.wikipedia.org/wiki/PDP-11) branch
instruction that branches to the rest of the
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor) code.

On the VAX `main` is called with the [calls
instruction](https://jcsites.juniata.edu/faculty/rhodes/org/instr.htm#CALLS)
which uses the first word of the subroutine as a mask of registers to be saved.
So on the VAX the first word can be anything.  The real VAX code starts with the
second word.

This small program makes direct calls to the `write()` Unix system call to
produce a message on the screen.  Can you guess what is printed?  We knew you
couldn't!  :-)

What happens if you hit enter after it writes a line of output?

**BTW**: to this day, 2023, this remains one of my (Landon Curt Noll's) all time
favorite entries!


### gentab.c

In 2023 remarks were discovered from [Sjoerd
Mullender](../../authors.html#Sjoerd_Mullender), one of the authors, and so was the
program that was used by the authors to generate the array that he referred to.
Because [a.out.h](%%REPO_URL%%/1984/mullender/a.out.h), which [gentab.c](%%REPO_URL%%/1984/mullender/gentab.c) uses,
is not available in all systems (like macOS) and more importantly because we wanted it to be as
close to as the original as possible we used a copy of
<https://raw.githubusercontent.com/dspinellis/unix-history-repo/Research-Release/usr/include/a.out.h>
in the *fabulous* [Unix History
Repo](https://github.com/dspinellis/unix-history-repo/tree/Research-Release).

### gentab build:

`gentab.c` can be built like:


``` <!---sh-->
    make gentab
```

### gentab use:

``` <!---sh-->
    ./gentab file
```

### gentab try:

``` <!---sh-->
    ./gentab gentab > g.c
```

**NOTE**: it is highly unlikely that you will be able to run the output of `gentab`
but it should at least compile.


## Author's remarks:

### Notes from the judges:

These remarks, found at
[https://lainsystems.com/posts/exploring-mullender-dot-c/](https://lainsystems.com/posts/exploring-mullender-dot-c/),
were provided by Sjoerd Mullender years later. We thank the author of the
article for the quote! For a more detailed analysis, taken from the book Obfuscated C
and Other Mysteries, see below. We hope that this is okay with the author of the
book. Considering that the analysis is entirely the authors' comments we don't
think this will be a problem. Unfortunately the excerpt was PDF and it did not
copy paste well. We had to go back and forth to type so it's possible we made a
typo though we also fixed some typos found in the extract. As for the other
comments:

### Remarks from the author:

I have never known a lot about the [VAX](https://en.wikipedia.org/wiki/VAX)
[assembly](https://en.wikipedia.org/wiki/Assembly_language), so we used the C
compiler to create the VAX code. We didn't write it ourselves from scratch as we
did with the [PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor)
code. This is the reason why the [VAX](https://en.wikipedia.org/wiki/VAX) code
is more complex, including the extra data after the
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor) code.

Robbert and I were students at the [VU (Free University in
Amsterdam)](https://vu.nl/en) at the time (mathematics with CS as our major
since there was no CS curriculum when we started). We had an assignment to
create a pair of programs for the computer networks course. The programs were
supposed to send data reliably from one program to the other over an unreliable
channel. This channel was simulated with a pair of
[pipes](https://en.wikipedia.org/wiki/Pipeline_&lpar;software&rpar;).

We decided for fun to create an
[obfuscated](https://en.wikipedia.org/wiki/Obfuscation_&lpar;software&rpar;) set of
programs, only for the
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor), to do this, but
circumventing the channel (i.e. cheating, hence the needed obfuscation). Our
programs worked and we handed them in.

Of course, the teacher had a good laugh and then rejected our submission. (We
knew him well, so we could get away with this.)

Then the [IOCCC](https://www.ioccc.org) came along. I don’t remember how we
heard about it, but at the time there was a world-wide messaging network Usenet
where we read a bunch of newsgroups. I’m sure it was [announced
there](https://groups.google.com/g/net.lang.c/c/lx-TAuEyeRI/m/HdOOnNx6LC0J) and we saw
it.

Since we had just recently created these [obfuscated
programs](https://en.wikipedia.org/wiki/Obfuscation_&lpar;software&rpar;) we decided we could
use the same technique for an obfuscated C program. We upped the ante a bit by
making it "portable".

To add to the
[obfuscation](https://en.wikipedia.org/wiki/Obfuscation_&lpar;software&rpar;), we used
different formats for the integers in the array: some in decimal, some in octal,
some in hexadecimal, and when the value would fit, some as an ASCII character.

The rest is history.

Since this was the first contest, we hadn't seen any old entries, nor had any of
the other contestants. Of course we knew about `#define` and tricks you could do
with that, but we didn't need that for this program. In fact, we made it as
"standard" as possible. At the time there was this program called `cb` or C
beautifier which would re-indent your program to make the layout look better.
Our program is idempotent under `cb`.


### More detailed analysis

When this program is compiled, the compiler places the array somewhere in
memory, just like it places any compiled code somewhere in memory. Usually, the
C startup code, [crt0.o](https://en.wikipedia.org/wiki/Crt0), calls a routine
named `main()`. The loader fills in the address in the startup code, but at
least on the old systems where this program ran, it doesn't know that the
`main()` in this program isn't code but data!

When the program is run, the C startup code transfers control to the location
`main`. The contents of the array just happen to be machine instructions for
both a [PDP-11](https://en.wikipedia.org/wiki/PDP-11) and a
[VAX](https://en.wikipedia.org/wiki/VAX).

On the [VAX](https://en.wikipedia.org/wiki/VAX), the routine `main()` is called
with the `calls` instruction. This instruction uses the first (2-byte)
[word](https://en.wikipedia.org/wiki/Word_&lpar;computer_architecture&rpar;) of the called
routine as a mask of
[registers](https://en.wikipedia.org/wiki/Processor_register) that are to be
saved on the [stack](https://en.wikipedia.org/wiki/Call_stack).
In other words, on the VAX the first word can be anything. On the
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor), the first word
is a [branch](https://en.wikipedia.org/wiki/Branch_&lpar;computer_science&rpar;)
[instruction](https://en.wikipedia.org/wiki/Instruction_set_architecture#Instructions)
that branches over the VAX code. The PDP and VAX codes are thus completely
separate.

The [PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor) and
[VAX](https://en.wikipedia.org/wiki/VAX) codes implement the same algorithm:

``` <!---c-->
    for (;;) {
        write(1, "  :-)\b\b\b\b", 9);
        delay();
    }
```

The result is that the symbols `:-)` move across the screen. `delay` is
implemented differently on the
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor), where we used a
nonexistent system call (`sys 55`), and on the
[VAX](https://en.wikipedia.org/wiki/VAX) where we used a delay loop.

My co-author, Robbert, and I had earlier written a similar program for an
assignment on the [PDP-11](https://en.wikipedia.org/wiki/PDP-11). [Along
came](https://groups.google.com/g/net.lang.c/c/lx-TAuEyeRI/m/HdOOnNx6LC0J) the
first [Obfuscated C Code Contest](https://www.ioccc.org), and
we decided that we should write a program like this, but make it run on two
different [architectures](https://en.wikipedia.org/wiki/Computer_architecture).

We didn't think long about what the program should do, so it does something very
simple.

We started with writing the
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor) code in assembly.
We both knew [PDP-11](https://en.wikipedia.org/wiki/PDP-11) assembly so that was
no problem. The assembly code we came up with is as follows:

``` <!---asm-->
    pdp:
        mov pc,r4
        tst -(r4)
        sub $9, r4
        mov r4,0f
        mov $1, r0
        sys 4; 0:0; 9
        mov $1000, r2
    1:
        sys 55
        sob r2,1b
        br pdp
```

This is not the code we originally wrote, but it is the code that we ultimately
used in the program. The string to be printed is shared by the
[VAX](https://en.wikipedia.org/wiki/VAX) and the
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor)
code and is located between the two sections.

First, the program deals with figuring out the address of the string. Then the
[program counter](https://en.wikipedia.org/wiki/Program_counter) is saved in a
scratch [register](https://en.wikipedia.org/wiki/Processor_register). Since the
program counter points at the second
[instruction](https://en.wikipedia.org/wiki/Instruction_set_architecture#Instructions),
we subtract 2 from the scratch register in the second instruction. Then we
subtract the length of the string and store the result in the location with
label `0`. This has to do with the calling sequence of [system
calls](https://en.wikipedia.org/wiki/System_call) on the
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor). Following the
`sys` instruction is the system call number (4 for `write()`), the address of
the buffer (pointed to by label `0`), and the length of the buffer (9). The [file
descriptor](https://en.wikipedia.org/wiki/File_descriptor) is in register `r0`.
The rest of the code implements a delay loop. In each iteration, a non-existing
system call (55) slows things down.

We assembled this program and extracted the [machine
code](https://en.wikipedia.org/wiki/Machine_code) from the resulting [object
file](https://en.wikipedia.org/wiki/Object_file). We used this code in the
[VAX](https://en.wikipedia.org/wiki/VAX) part. Since neither of us were fluent in
VAX [assembly](https://en.wikipedia.org/wiki/Assembly_language), we wrote the
VAX code in C and massaged the
[compiler](https://en.wikipedia.org/wiki/Compiler) output.  The VAX assembly
program that we came up with is as follows:


``` <!---asm-->
    vax: .word 0400 + (pdp - vax) / 2 - 1
    1:
        pushl $9
        pushal str
        pushl $1
        calls $3, write
        cvtwl $32767, r2

    2:
        decl r2
        jneq 2b
        jbr 1b

    write: .word 0
        chmk $4
        ret

    str: .ascii " :-)\b\b\b\b"

    pdp: .word 4548, 3044, 58820, 9, 4407, 6, 5568, 1, 35076, 0, 9, 5570, 512, 35117, 32386, 496
```

The first word (after the label `vax`) is the
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor) [branch
instruction](https://en.wikipedia.org/wiki/Branch_&lpar;computer_science&rpar;).
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor) branch
instructions are octal `400` + the distance divided by `2`.  The string that both
the [PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor) and
[VAX](https://en.wikipedia.org/wiki/VAX)
programs use is after the `str` label, and the
[PDP](https://en.wikipedia.org/wiki/Programmed_Data_Processor) code is after the
`pdp` label.

On the [VAX](https://en.wikipedia.org/wiki/VAX), the program
[pushes](https://en.wikipedia.org/wiki/Stack_&lpar;abstract_data_type&rpar;) 9 (the length
of the string), the address of the string and 1, the [file
descriptor](https://en.wikipedia.org/wiki/File_descriptor) on the
[stack](https://en.wikipedia.org/wiki/Stack_&lpar;abstract_data_type&rpar;), and calls
`write(2)`. Since we didn't know the exact calling sequence for [system
calls](https://en.wikipedia.org/wiki/System_call), we just copied the source for
the `write(2)` system call stub into our program. After `write(2)` finishes, the
program executes a delay loop, after which it jumps back to the start of the
program.

We assembled this program, and extracted the [machine
code](https://en.wikipedia.org/wiki/Machine_code) from the [object
file](https://en.wikipedia.org/wiki/Object_file).  After this we only had to
convert the machine code to [ASCII](https://en.wikipedia.org/wiki/ASCII) and
write a little bit of C to glue everything together. We wanted to use different
formats for each constant in the resulting array, and we wanted to choose the
format randomly. So we wrote a program to choose an appropriate format at
random. The program we wrote for that follows.  This program actually also
extracted the machine code from the object file.

NOTE from judges: see [gentab.c](%%REPO_URL%%/1984/mullender/gentab.c) for a copy of this file that can be
compiled in modern systems.

``` <!---c-->
    #include <stdio.h>
    #include <a.out.h>

    main(argc, argv) char **argv;
    {
        register FILE *fp;
        register short pos = 0, c, n;
        register char *fmt;
        if (argc != 2) {
            fprintf (stderr, "Usage: %s file\n", argv[0]);
            exit (1);
        }

        if ((fp = fopen(argv[1], "r")) == NULL) {
            fprintf(stderr, "%s: can't open %s\n", argv[0], argv[1]);
            exit(2);
        }

        fseek (fp, (long) sizeof (struct exec), 0);
        printf("/* portable between VAX and PDP11 */\n\n");
        printf ("short main[] = {\n");
        for (;;) {
            if (pos == 0)
                printf("\t");

            c=getc(fp) & 0377;
            if (feof(fp)) break;
            n = getc(fp) << 8|c;

            switch (rand() % 5) {
                case 0:
                case 1:
                    fmt = "%d"; break;
                case 2:
                    fmt = "%u"; break;
                case 3:
                    fmt = "0%o"; break;
                case 4:
                    fmt = "0x%x"; break;
            }

            if (32 <= n && n < 127 && (rand() % 4)) fmt = "'%c'";
            printf(n < 8 ? "%d" : fmt, n);
            printf(",");
            if (pos++ == 8) {
                printf("\n");
                pos = 0;
            }
            else printf(" ");

            printf("};\n");
        }
    }
```

As can be seen, there is a slight preference for
[decimal](https://en.wikipedia.org/wiki/Decimal), and also a character
format is sometimes used, but only if the data is a printable ASCII character.

When we ran this program, we were almost completely satisfied with the result.
The only problem we had was that the program had chosen an
[octal](https://en.wikipedia.org/wiki/Octal) representation for the first word.
Since everybody knows what a [PDP-11](https://en.wikipedia.org/wiki/PDP-11)
branch instruction looks like (everyone knows that the traditional magic word
for an executable, `0407`, is a [PDP-11](https://en.wikipedia.org/wiki/PDP-11)
[branch](https://en.wikipedia.org/wiki/Branch_&lpar;computer_science&rpar;), we changed
that to [decimal](https://en.wikipedia.org/wiki/Decimal). After checking the
size of the resulting program we saw that it was one byte too long. The limit
was 512 bytes, and our program was 513 bytes.  So we changed the word `and` in
the comment to `&&`.


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
