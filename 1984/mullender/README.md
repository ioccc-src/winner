# Grand Prize

Sjoerd Mullender<br />
<https://github.com/sjoerdmullender>

Robbert van Renesse

## To build:

```sh
make all
```

## To run:

```sh
./mullender
```

> NOTE: If your machine is not a VAX-11 or PDP-11, this program will
> not execute correctly.  In later years, machine dependent
> code was discouraged.

### Alternate code:

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) added the alternative
code which lets you run this on other systems. He notes though that this was
only a slight fix and enhancement to the change in the [faq](/faq.md). Thank you
Cody for your assistance!

#### To build:


```sh
make alt
```

#### To run:

```sh
./mullender.alt [microseconds]
```

The default microseconds is 10000. This feature is so you can experiment with
different speeds in between writes. It can be useful if your CPU is too slow or
too fast.

BTW: is there such a thing as too fast a CPU ? :-) Actually yes for certain code
which is probably not as uncommon as you think :-).

Note that it is an int and it uses `atoi()` which does NOT check for
overflow! In fact it's argc itself.


#### Try:


```sh
./mullender.alt

./mullender.alt 5000

./mullender.alt 500

./mullender.alt 20000

./mullender.alt 100000
```

What happens if you hit enter after it writes a line of output?


## Judges' remarks:

Without question, this C program is the one of the most obfuscated
C program that has ever been received!  Like all great contest
entries, they result in a change of rules for the following year.
To prevent a flood of similar programs, we requested that programs
be non machine specific.

This program was selected for the 1987 t-shirt collection.

The C startup routine (via crt0.o) transfers control to a location
named main.  In this case, main just happens to be in the data area.
The array of shorts, which has been further obfuscated by use of
different data types, just happens to form a meaningful set of PDP-11
and Vax instructions.  The first word is a PDP-11 branch instruction
that branches to the rest of the PDP code.  On the Vax main is called with
the calls instruction which uses the first word of the subroutine as a
mask of registers to be saved.  So on the Vax the first word can be anything.
The real Vax code starts with the second word.  This small program
makes direct calls to the write() Unix system call to produce a
message on the screen.  Can you guess what is printed?  We knew you
couldn't!  :-)

BTW: this remains my (Landon Curt Noll's) all time favorite entries!

Cody found the remarks from [Sjoerd Mullender](/winners.html#Sjoerd_Mullender)
and added the program that was used by the authors to generate the array that he
referred to. Because [a.out.h](a.out.h) is not available in all systems (like macOS) and
more importantly because he wanted it to be as close to as the original as
possible he used a copy of
<https://raw.githubusercontent.com/dspinellis/unix-history-repo/Research-Release/usr/include/a.out.h>
in the *fabulous* [Unix History
Repo](https://github.com/dspinellis/unix-history-repo/tree/Research-Release).

This tool can be built by running:


```sh
make gentab
```

Cody notes that it does not appear to work in modern systems (unbalanced braces)
or something else is wrong but given that this was done a long time ago on a now
archaic system maybe that is why. He also noted that if the `short`s are not
changed to just `int` it prints out a lot of negative numbers but since
[mullender.c](mullender.c) has a negative number he kept it as is.

Thank you Cody!

## Author's remarks:

These remarks, found at
[https://lainsystems.com/posts/exploring-mullender-dot-c/](https://lainsystems.com/posts/exploring-mullender-dot-c/),
were provided by Sjoerd Mullender years later. We thank the author of the
article for the quote! For a more detailed analysis, taken from the Obfuscated C
and Other Mysteries, see below. We hope that this is okay with the author of the
book. Considering that the analysis is entirely the authors' comments we don't
think this will be a problem. Unfortunately the excerpt was PDF and it did not
copy paste well. [Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) had to
go back and forth to type so it's possible he made a typo though he also fixed
some typos found in the extract. As for the other comments:


I have never known a lot about the VAX assembly, so we used the C compiler to
create the VAX code. We didn't write it ourselves from scratch as we did with
the PDP code. This is the reason why the VAX code is more complex, including the
extra data after the PDP code.

Robbert and I were students at the VU (Free University in Amsterdam) at the time
(mathematics with CS as our major since there was no CS curriculum when we
started). We had an assignment to create a pair of programs for the computer
networks course. The programs were supposed to send data reliably from one
program to the other over an unreliable channel. This channel was simulated with
a pair of pipes.

We decided for fun to create an obfuscated set of programs, only for the PDP, to
do this, but circumventing the channel. (I.e. cheating, hence the needed
obfuscation.) Our programs worked and we handed them in.

Of course, the teacher had a good laugh and then rejected our submission. (We
knew him well, so we could get away with this.)

Then the IOCCC came along. I don’t remember how we heard about it, but at the
time there was a world-wide messaging network Usenet where we read a bunch of
newsgroups. I’m sure it was announced there and we saw it.

Since we had just recently created these obfuscated programs we decided we could
use the same technique for an obfuscated C program. We upped the ante a bit by
making it “portable”.

To add to the obfuscation, we used different formats for the integers in the
array, some in decimal, some in octal, some in hexadecimal, and when the value
would fit, some as an ASCII character.

The rest is history.

Since this was the first contest, we hadn't seen any old entries, nor had any of
the other contestants. Of course we knew about `#define` and tricks you could do
with that, but we didn't need that for this program. In fact, we made it as
“standard” as possible. At the time there was this program called `cb` for C
beautifier which would re-indent your program to make the layout look better. Our
program is idempotent under `cb`.

### More detailed analysis

When this program is compiled, the compiler places the array somewhere in
memory, just like it places any compiled code somewhere in memory. Usually, the
C startup code (`crt0.o`) calls a routine named `main`. The loader fills in the address in
the startup code, but, at least on the old systems where this program
ran, it doesn't know that the `main` in this program isn't code but data!

When the program is run, the C startup code transfers control to the location
`main`. The contents of the array just happen to be machine instructions for
both a PDP-11 and a VAX.

On the VAX, the routine main is called with the `calls` instruction. This
instruction uses the first (2-byte) word of the called routine as a mask of
registers that are to be saved on the stack. In other words, on the VAX the
first word can be anything. On the PDP, the first word is a branch instruction
that branches over the VAX code. The PDP and VAX codes are thus completely
separate.

The PDP and VAX codes implement the same algorithm:

```c
    for (;;) {
	write(1, "  :-)\b\b\b\b", 9);
	delay();
    }
```

The result is that the symbols `:-)` move over the screen. `delay` is
implemented differently on the PDP, where we used a nonexistent system call
(`sys 55`), and on the VAX where we used a delay loop.

My co-author, Robbert, and I had earlier written a similar program for an
assignment on the PDP-11. Along came the first Obfuscated C Code Contest, and
we decided that we should write a program like this, but make it run on two
different architectures.

We didn't think long about what the program should do, so it does something very simple.

We started with writing the PDP code in assembler. We both knew PDP-11
assembler, so that was no problem. The assembler code we came up with is as
follows:

```asm
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
used in the program. The string to be printed is shared by the VAX and the PDP
code and is located between the two sections.

First, the program deals with figuring out the address of the string. Then the
program counter is saved in a scratch register. Since the program counter points
at the second instruction, we subtract 2 from the scratch register in the second
instruction. Then we subtract the length of the string and store the result in
the location with label 0. This has to do with the calling sequence of system
calls on the PDP. Following the `sys` instruction is the system call number (4
for `write`), the address of the buffer (pointed to by label 0), and the length
of the buffer (9). The file descriptor is in register `r0`. The rest of the code
implements a delay loop. In each iteration, a non-existing system call (55)
slows things down.

We assembled this program and extracted the machine code from the resulting
object file. We used this code in the VAX part. Since neither of us was fluent
in VAX assembly, we wrote the VAX code in C and massaged the compiler output.
The VAX assembly program that we came up with is as follows:


```asm
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

The first word (after the label `vax`) is the PDP branch instruction. PDP branch
instructions are octal `400+` the distance divided by 2.  The string that both
the PDP and VAX programs use is after the `str` label, and the PDP code is after
the pap label.

On the VAX, the program pushes 9 (the length of the string), the address of the
string and 1 (the file descriptor) on the stack and calls `write`. Since we
didn't know the exact calling sequence for system calls, we just copied the
source for the `write` system call stub into our program. After `write`
finishes, the program executes a delay loop, after which it jumps back to the
start of the program.

We assembled this program, and extracted the machine code from the object file.
After this we only had to convert the machine code to ASCII and write a little
bit of C to glue everything together. We wanted to use different formats for
each constant in the resulting array, and we wanted to choose the format
randomly. So we wrote a program to choose an appropriate format at random. The
program we wrote for that follows.  This program actually also extracted the
machine code from the object file.

```c
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

As can be seen, there is a slight preference for decimal, and also a character
format is sometimes used, but only if the data is a printable ASCII character.

When we ran this program, we were almost completely satisfied with the result.
The only problem we had was that the program had chosen an octal representation
for the first word. Since everybody knows what a PDP-11 branch instruction looks
like (everyone knows that the traditional magic word for an executable, `0407`,
is a PDP-11 branch), we changed that to decimal. After checking the size of the
resulting program we saw that it was one byte too long. The limit was 512 bytes,
and our program was 513 bytes. So we changed the word `and` in the comment to
`&&`.

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
