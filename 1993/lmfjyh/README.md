## To build:

If you have gcc < 2.3.3 you can build this entry like:

```sh
make all
```

This will create a file called `";main(){puts("Hello World!");}char*C=".c` which
would print `Hello World!` when compiled.

For an explanation of why and how this works see the author's remarks. The gist
of the entry itself, however, is the file name _itself **is** the code_.

NOTE: we delete the temporary file whether or not the compilation succeeds
because it is an unsafe filename and not doing so would cause problems for
anyone running `make`.

This entry will not compile with gcc < 2.3.3 as it relies on a bug which was
fixed in gcc 2.3.3 which was fixed a very long time ago now. There is an
alternate version for [those of
us](https://www.collinsdictionary.com/dictionary/english/everyone) with gcc >=
2.3.3. See [Alternate code](#alternate-code) section below for more details.

However, there is an another version that will be compiled in the extremely
likely case this fails.  This should happen automatically. See [Alternate
code](#alternate-code) below for more details on it.


### Bugs and (Mis)features:

The current status of this entry is:

```
STATUS: INABIAF - please **DO NOT** fix
```

For more detailed information see [1993 lmfjyh bugs](../../bugs.html#1993_lmfjyh).


## To use:

If you have gcc < 2.3.3 (i.e. the entry can compile):

```sh
./lmfjyh
```


## Alternate code:

This version does what the code did but in a way that will work with modern
compilers. We'd like to say there's something special about it but there isn't.
Nonetheless it will be compiled in case the original entry fails to compile
(which will happen unless you have gcc < 2.3.3.


### Alternate build:

Should you wish to build this version manually:

```sh
make alt
```


### Alternate use:

Use `lmfjyh.alt` as you would `lmfjyh` above. Note that other code could also be
done with the bug that the entry abuses but that would have to be manually
programmed for this version; see the author's remarks for more details.


## Judges' remarks:

There's more than one way to get around disk quotas. :-)


## Author's remarks:

"Practical and efficient method of compressing source code".


### Introduction

I will shortly present a totally new compression method.
It may be used to compress any types of files, but it works
best with C-source code.

As an example, I have taken a simple "Hello world!" program
that should be familiar to all C-programmers.


#### Listing 1: A simple "Hello World" program


```c
main()
{
  puts("Hello World!");
}
```


### Packing method

Normally a file name is used only to identify the file, but this new
revolutionary method introduces a totally new concept: **THE FILE NAME _IS_ THE
PROGRAM**. There is no need to waste valuable disk space to store source code.
The program is embedded in the file name, only a minor portion of it is inside
the file.


#### Listing 2: Compressed "Hello world"

```c
char*_=__FILE__;
```


#### Listing 3: Code embedded in the file name

```c
";main(){puts("Hello World!");}char*C=".c
```


The sample program in listing 1 is 36 bytes long. By using the new
compression method, the example program may be squeezed to sixteen
bytes. In the example the compression ratio is 2:1. It is evident
that the longer the program is, the better the compression ratio
is. The maximum compression ratio in a UNIX environment is 254:16
which equals approximately to 16:1.  By using the method a one
megabyte of source code file can be compressed to 64 kilobytes.

One might easily think that the program could be compressed to a
single byte by writing a one character long preprocessor directive
in the source file and defining the actual source code in the
command line, e.g. `cc hello.c -DX='main(){puts ...'`.  With this
method nothing is gained, since the compiling commands must be
stored in a file, and that takes even more space than writing the
code in a source file as presented in listing 1.


### Packing files in a UNIX environment

In a UNIX environment it is possible to write almost any program by
including the code in file names. Since `/` is used to separate
path components and cannot therefore exist in a file name, all
features of the C language cannot be used.

In C, the `/` is used as a division operator and it may also be a
part of a comment start and end identifier. This, however, is not a
dangerous limitation, since practice has shown that comments are
almost totally unnecessary. A real programmer can more easily
understand pure source code, and misleading comments are
disastrous. The division operation may be replaced with `pow(x, -1)`
and multiplication when using real numbers or with `div()` function
when using integers.

Large programs must be separated into small modules. This enforces
people to write better programs, since monolithic programming style
cannot be used. Program development will also be faster, no extra
code needs be recompiled after changes have been made.


### Usage with currently available tools

I have tested how well this new method works with currently
available programming tools.

Any ANSI conforming C-compiler that runs under a REAL operating
system should be able to compile the code (there might be problems
with some older UNIX variants).


### Compilers

These worked:

- gcc versions 2.0, 2.1, 2.3.2 (ld failed at AIX with gcc 2.1)
- cc (HP-UX)
- cc (VAX)

These failed miserably:

- cc (SunOS/Solaris)      - could not start cpp properly
- cc/xlc (AIX)            - could not open source


### Other tools


#### Debuggers: (tested at SunOS 4.1.2)

- `dbx`   - Quit with a very 'informative' error message:
	    `"dbx: fatal error: Is a directory"`

- gdb   - Printed almost the same error message `": Is a directory"`.
	It was, however, possible to step through the code but
	not list it.


#### Lints

None of the lints tested environments were able to parse the file.


### Conclusions

The method can be used to compress any type of file and the compression ratios
are even better when compressing files other than C source.  For example plain
text files may be compressed with INFINITE compression ratio. It is trivial task
to compress a 100 kilobytes long text file in about 400 files whose lengths are
zero bytes.  The drawback is that the files must be unpacked before they can be
used, so a large amount of temporary disk space is needed, while C source is
totally usable in the compressed form.

Evidently, there is a long way to go before this new programming
technique may be widely used, since currently there are only few
tools supporting it. The advantages over the traditional methods
are, however, so great that there is no doubt that this method will
be new standard.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
