Best Abuse of CPP:

    Daniel Vik
    926 Genter Street
    La Jolla, Ca 92037
    USA

    http://www.vik.cc/


Judges' Comments:

    To build:

      make vik2

    To run:

	./vik2

    The fun thing about CPP abuses is that, in most cases, running the
    preprocessor on them doesn't help you decipher the obfuscated code.
    That's assuming your preprocessor can take it at all.


Selected Author's Comments:

    Introduction
    ============

    It's been  a while since the  last pre-processor  killer won  the ioccc.
    I thought it was  time to  relive  hour long compile  times so  I made a
    program  that does  (almost) all computation in the pre-processor.   The
    program  even  causes  gcc  (and  other  pre-processors)  to crash  when
    configured to do maximum number of  computations.
    The default  configuration  of the makefile  is set to make  the program
    compile in a not too long time.

    I've got cpp to crash in a couple of  diffenent ways.  Most common is to
    get a  segmentation fault,  but a couple  of times it just  got stuck in
    some infinite loop.

    I actually had to write my own  pre-processor to verify that the program
    was doing the right thing...

    Since  it takes  a very  long time  to compile  the program,  there is a
    symbol  that  can be  defined to  shorten  the  compile  time  and avoid
    compiler errors.


    Features
    ========

    The program  implements an 11-bit ALU in the pre-processor.  The ALU has
    two registers,  X and Y,  for calculations  and one status  register SR.
    Each bit in the registers  are represented by one symbol that are either
    defined or undefined.

        The ALU has six instructions:

        CLR_X - Clear register X

        CLR_Y - Clear register Y

        ADD   - Calculates X + Y and stores  the result in X.  If the result
                is larger than 11 bits, the CARRY bit in SR is set otherwise
                the CARRY bit is cleared.

        SUB   - Calculates X - Y and stores the result in X. If Y was larger
                than X,  the CARRY bit in SR is set otherwise the  CARRY bit
                is cleared.

        TST   - If X == Y the EQ bit in SR is set,  otherwise  the EQ bit is
                cleared. If X < Y the LT bit in SR is set,  othervise the LT
                bit is cleared.

        INC2  - Calculates X + 2 and stores  the result in X.  The CARRY bit
                is handled as in the ADD instruction.

    Internally  the ALU implements a one bit adder with a carry in and carry
    out. This adder is the core of the ALU. The ADD instruction uses the one
    bit adder to create the 11-bit adder. The SUB instruction is implemented
    by adding ~Y to X and then add 1. Finally the TST instruction calculates
    X-Y and checks  the result and the CARRY bit in  the SR register  to set
    the EQ and LT bits.

    All calculations are made using only the #ifdef, #infdef, #else, #endif,
    #define  and #undef.  I never  assign a value to a defined  symbol.  The
    logic is done  by assuming that  a defined symbol is 1 and  an undefined
    symbol is 0. (I guess this means that I have unlimited memory as long as
    I only store zeroes (!)).

    The application  that  uses  the  pre-processor  ALU  is a prime  number
    generator.   The application  uses  the same  pre-processor  directives.
    Needed  variables  are  stored  in memory  represended by one defined or
    undefined  symbol  per bit.  When doing  arithmetics,  the variables are
    loaded into  the X and Y registers  by defining / undefining the X and Y
    register bits. Then the calcualtion is made and the result is moved back
    to the memory.

    The choice of application  may be a bit  unfortunate since we've already
    seen a winning entry  calculating  prime  nubmers in the  pre-processor.
    There is a big difference  though.   The  1988 applin  entry  uses  pre-
    processor  arithmethic  (in a very nice way though).  This program  only
    defines  and undefines  symbols in a well defined ;)  way and doesn't do
    any pre-processor arithmetics.

    The reason why I  choosed to do a  prime number  application is that the
    algorithm can be written to do a  lot of  calculations  without a lot of
    nesting (gnu cpp allows only 200 nested includes).


    Build and Run
    =============

    First, do a first pre processing of the initial  definitions.  The FNAME
    symbol must  be defined to the name  of the output file.  If you want to
    speed up the compilation,  define the STOP symbol to anything from _3 to
    _10. (The default value is _10 which will make the compilation take some
    time.) Prime numbers up to 2^STOP will be calculated.

        $ cpp '-DSTOP=_5' '-DFNAME="tmp1.c"' prog.c tmp1.c

    Then use cpp or any other pre-processor to do the actual work. This will
    take some time....

        $ cpp tmp1.c > tmp2.c

    Finally compile the pre processed file

        $ cc -O tmp2.c -o prog

    Then run the program to reveil all  prime numbers up to 32  (if you used
    STOP=_5 as above):

        $ ./prog


    Verification
    ============

    I wasn't able to compile the full program which calculates prime numbers
    up to 1024 using gnu cpp (or any other pre-processor)  so I had to write
    my own.  Knowing how  the program works  it was quite easy to reduce the
    compilation time  from several  hours to about one second.  I also added
    some  statistics  to  my  home  made  pre-processor  and  I  found  that
    calculating prime numbers up  to 1024 makes  the  program include itself
    over 6.8 million times (see the statistics table below).


    Obfuscation
    ===========

    Well,  since 98.5% of the program  is preprocessor  directives, the main
    obfuscation is the use of preprocessor directives.

    Doing arithmetics without acutally using any arithmetic operations makes
    the program quite hard to follow.

    In order to actually do the calculations,  the program includes itself a
    lot.

    The symbol names are made as short as possible to meet the space limits.
    This of course  adds to the  obfuscation  (even  though  the  program is
    quite obfuscated with longer, readable macro names.

    Finally,  I  made the 1.5% c code a bit harder  to read by  breaking all
    lines after three characters.

    The program has 1029 lines which makes it the longest entry (so far).

    Even though the pre-processed and indented output is easier to read,  it
    is quite hard to find the code in it. The size of the pre-processed file
    is several Mb when using gnu cpp.


    Limitations
    ===========

    In order to fit the program within the space limits, I had to define the
    #define, #endif,  and some other directives as single character symbols.
    This does not compile on all pre-processors but using gnu cpp as a first
    compilation step solves this.


    Statistics
    ==========

    The   table  below   contains  some  interesting  statistics  about  the
    compilation of the program.   The intermediate  file size is the size of
    the output file of the cpp pre-processor. The time taken  to pre process
    the program  were measured  using gnu cpp on my 2.0MHz P4 with 512Mb ram
    and a lot of disk.

            Generated   Recursive  Max nest  Intermediate
    Level   prime nrs   includes   count     file size          Time

      _3     < 8           2 322       9         74 748            4"
      _4     < 16          4 672       9        182 652            9"
      _5     < 32         14 237       9        629 121           32"
      _6     < 64         43 748       9      1 998 134         1'41"
      _7     < 128       149 851      11      6 823 575         5'50"
      _8     < 256       526 874      17     24 028 933        20'37"
      _9     < 512     1 920 272      38     65 527 808(*)  1h 42'19"(*)
     _10     < 1024    6 826 389     114     63 782 912(*)  2h 47'58"(*)

             (*) Before cpp crashed.
