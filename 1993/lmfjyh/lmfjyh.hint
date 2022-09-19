Most Versatile Source:

	Jyrki Holopainen
	Oy LM Ericsson Ab
	SF-02420 Jorvas
	Finland


Judges' comments:

    To use:
	make lmfjyh
	./lmfjyh
    
    See the makefile for details.

    There's more than one way to get around disk quotas. :-)

    Some people have reported problems compiling this entry
    with gcc 2.3.3.

    The make command:

	make tidy
    
    will remove the "special" file that is created during the 
    make of lmfjyh.


Selected notes from the author:

    "Practical and efficient method of compressing source code"

    1. Introduction

    I will shortly present a totally new compression method.
    It may be used to compress any types of files, but it works
    best with C-source code.

    As an example, I have taken a simple "Hello world!" program
    that should be familiar to all C-programmers.

    Listing 1. A simple "Hello World" program:

    main()
    {
      puts("Hello World!");
    }


    2. Packing method

    Normally a file name is used only to identify the file, 
    but this new revolutionary method introduces a totally new concept: 
    THE FILE NAME IS THE PROGRAM. There is no need to waste
    valuable disk space to store source code. The program is
    embedded in the file name, only a minor portion of it
    is inside the file.

    Listing 2. Compressed "Hello world":

    char*_=__FILE__;


    Listing 3. Code embedded in the file name:

    ";main(){puts("Hello World!");}char*C=".c


    The sample program in listing 1 is 36 bytes long. By using the new
    compression method, the example program may be squeezed to sixteen
    bytes. In the example the compression ratio is 2:1. It is evident
    that the longer the program is, the better the compression ratio
    is. The maximum compression ratio in a UNIX environment is 254:16
    which equals approximately to 16:1.  By using the method a one
    megabyte of source code can be compressed to 64 kilobytes.

    One might easily think that the program could be compressed to a
    single byte by writing a one character long preprocessor directive
    in the source file and defining the actual source code in the
    command line, eg. 'cc hello.c -DX=main(){puts...'.  With this
    method nothing is gained, since the compiling commands must be
    stored in a file, and that takes even more space than writing the
    code in a source file as presented in listing 1.


    3. Packing files in a UNIX environment

    In a UNIX environment it is possible to write almost any program by
    including the code in file names. Since '/' is used to separate
    path components and cannot therefore exist in a file name, all
    features of C-language cannot be used.

    In C, the '/' is used as a division operator and it may also be a
    part of a comment start and end identifier. This is, however, not a
    dangerous limitation, since practice has shown that comments are
    almost totally unnecessary. A real programmer can more easily
    understand pure source code, and misleading comments are
    disastrous. The division operation may be replaced with pow(x, -1)
    and multiplication when using real numbers or with div() function
    when using integers.

    Large programs must be separated into small modules. This enforces
    people to write better programs, since monolithic programming style
    cannot be used. Program development will also be faster, no extra
    code need not be recompiled after changes have been made.


    4. Usage with currently available tools

    I have tested how well this new method works with currently
    available programming tools.

    Any ANSI conforming C-compiler that runs under a REAL operating
    system should be able to compile the code.  (there may be problems
    with some older UNIX variants)

    4.1. Compilers:

    These worked:
    gcc versions 2.0, 2.1, 2.3.2 (ld failed at AIX with gcc 2.1)
    cc (HP-UX)
    cc (VAX)

    These failed miserably:
    cc (SunOs/Solaris)      - could not start cpp properly
    cc/xlc (AIX)            - could not open source

    4.2. Other tools:

    4.2.1 Debuggers: (tested at SunOs 4.1.2)

    dbx     - Quit with a very 'informative' error message:
	    "dbx: fatal error: Is a directory"

    gdb     - Printed almost the same error message ":Is a directory".
	    It was, however, possible to step through the code but 
	    not list it.

    4.2.2 Lints:

	    - None of the lints at tested environments were able
	      to open the file.


    5. Conclusions

    The method can be used to compress any types of files, actually the
    compression ratios are even better when compressing other files
    than C-source.  For example plain text files may be compressed with
    INFINITE compression ratio. It is trivial task to compress a 100
    kilobytes long text file in about 400 files whose lengths are zero
    bytes.  The drawback is that the files must be unpacked before they
    can be used, so a large amount of temporary disk space is needed,
    while C-source is totally usable in the compressed form.

    Evidently, there is a long way to go before this new programming
    technique may be widely used, since currently there are only few
    tools supporting it. The advantages over the traditional methods
    are, however, so great that there is no doubt that this method will
    be new standard.

Copyright (c) 1993, Landon Curt Noll & Larry Bassel.
All Rights Reserved.  Permission for personal, educational or non-profit use is
granted provided this this copyright and notice are included in its entirety
and remains unaltered.  All other uses must receive prior permission in writing
from both Landon Curt Noll and Larry Bassel.
