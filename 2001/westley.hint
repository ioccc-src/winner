Best position-independent code:

    Brian Westley
    Firesign Theatre webmaster
    1906 James Ave
    St. Paul, MN  55105
    USA

    http://www.firesigntheatre.com


Judges' Comments:

    To build:

    	make westley

    Try:

    	./westley < westley.c > westley2.c
	cc westley2.c -ansi -o westley2
	echo 'Bozos, please deflate shoes before entering the bus!'| ./westley2
	sort -b < westley2.c > westley3.c
	cc westley3.c -ansi -o westley3
	./westley3 < westley.c | diff - westley.c
	./westley3 < westley.c | diff - westley2.c
	./westley3 < westley.c | diff - westley3.c

    Try copying the source to a new file and changing around the
    order of the lines.  Does it produce the exact same output?

    By changing the order of the source, figure out in how many different
    ways this program can transform input to output.

    NOTE: The entry has been modified for portability reasons.  The
          original source may be found in the westley.orig.c file.

    This assortment obfuscated lines takes position-independant code
    to a new level!  :-)


Selected Author's Comments:

    Punch cards, or Hollerith cards, were becoming obsolete just
    as C was becoming more popular*; this is rather unfortunate,
    because C has an advantage over many other languages when it
    comes to punch cards - C programs can be written to be "drop
    proof".

    Consider the following C program:

    main(){a();b();c();}
    a(){printf("A");}
    b(){printf("B");}
    c(){printf("C");}

    This program will compile and run no matter what order the
    lines are in.  If you punch it on cards (one line of code per
    card, naturally) and drop them, you don't need to put them in
    any particular order**; it will always produce "ABC" as output.

    You can also use global variables:

    char *greet = "Hello, world!";
    char *greet; main(){puts(greet);}

    It would be trivial to write an entire C program that is
    "drop proof" using the above techniques; surprisingly, it's
    possible to write a program that will always compile but
    behave differently depending on the line order:

    test(a,b){return a;}
    #define test(a,b) test(b,a)
    main(){if (test(0,1)) printf("T"); else printf("F");}

    This program will print out "T" if the #define statement
    falls between the declaration of test() and its use in
    main(), otherwise it will print out "F".  Furthermore,
    you can use the same call to test() repeatedly in
    different lines to return different values:

    #define test(x,y) test(y,x)
    main(){int i=0;a(&i);b(&i);c(&i);d(&i);printf("%d\n",i);}
    a(i)int*i;{if (test(0,1)) *i += 1;}
    b(i)int*i;{if (test(0,1)) *i += 2;}
    c(i)int*i;{if (test(0,1)) *i += 4;}
    d(i)int*i;{if (test(0,1)) *i += 8;}
    test(x,y){return x;}

    If you enter the above program on punch cards, throw them
    up in the air, gather them up, and run it, you will get
    a number from 0 to 15 printed out.  Now *that's* a random
    number generator...

    Of course, there are drawbacks to C programming on punch
    cards; an 80-character line limit can be restricting, and
    (to be maximally portable) you need to use trigraphs for
    the characters "^[]{}\" (these aren't found on every
    keypunch, and have various encodings).

    My C program entry does the following:

    1) reads in lines
    2) rearranges the lines, or not
    2a)  if it rearranges the lines, they are sorted or scrambled
    3) reverses the order of the lines, or not
    4) prints out the lines as either text or EBCDIC punch cards.

    The code, as written, scrambles the input and prints it out
    as normal text, so you can simulate 'dropping' the cards.
    You can repeatedly scramble the code to get all 12 variants
    (but the scrambling isn't very random; it's just a bubble
    sort with a random number, so some variants are more common
    than others).  You can also just swap the arguments in the
    calls to t() in all combinations to get all the variations.

    If you sort the lines, you will get the version that just
    prints out the input as punch cards (you will need to display
    at least 82 columns of text, or clip the last few chars by
    piping it through "sed s/...$//").  If you use this on the
    original code, you will see that it spells out "HOLLERITH"
    when punched on cards (you can see the tall, thin letters
    spelling out "HOLLERITH" if you turn the C code sideways).
    You will also see why "/KC 0000 K" is a "Hollerith emoticon".
    Unrecognized characters are punched as a lace column.
    (You can see an ASCII simulation of the code as punch cards
    by looking at card.gif)

    For a nice test pattern, try
    &-0123456789ABCDEFGHIJKLMNOPQR/STUVWXYZ:#@'=".<(+|!$*);,%_>?abcmnoxyz^[]{}\

    If you want to analyze the program, sorting the lines while
    ignoring leading blanks works best (sort -b).  This will
    produce the version that just reverses the line order, and
    the routines in the code are in a sensible order.

    This program should work on EBCDIC computers.  It assumes
    that the time_t ptr param to time() will work with an int
    ptr, and that "passing through" a char[][] array as a simple
    char* is ok.  Your compiler MUST understand trigraphs, or it
    will miss the trigraph backslash before the double quote in
    the K string and complain about a malformed string; for GNU
    C, use -ansi or -trigraphs.  Entering a line of more than 80
    characters, or more than 81 lines, will jam the card reader.

    I've used the a[b] ==> *(a+b) trick, because this is
    actually shorter than the trigraph version of a??(b??).

    With 28 lines of code (not counting the blank lines or the
    comment), there are technically 28! different programs, or
    304,888,344,611,713,860,501,504,000,000 different versions,
    all legal C.

    *except in Florida voting machines
    **all cards must be face down, nine-edge first, of course.
