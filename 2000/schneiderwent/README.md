Most Timely Output:

    Craig Schneiderwent
    WI, USA


Judges' Comments:

    To build:

	make schneiderwent

    To run:

	./schneiderwent schneiderwent.data

    Very nice play by the rules and portable text obfuscation.
    This far surpasses old tricks like adding or subtracting 1
    from every character in a C string.

    Translating the messages into your language of preference while
    keeping the program portable between different encodings
    (Chinese, Japanese, Russian - anyone?) may be an entertaining task.


Selected Author's Comments:

    This entry displays the current time to the console, for example:

	it's just after ten 'til 6 in the evening

    FWIW, none of the compilers with which this entry was tested issued
    any warnings or errors in compiling the source for this entry.  No
    doubt lint will complain about the goto statements.

    The schneiderwent.data file consists of the values used by multiple
    table lookups.  This is simply good program design, separating
    these values from the source code allows changing the behavior of
    the application without recompiling.

    Having learned COBOL at an early age, the pthreads of my thought
    processes tend to be translated into code in a verbose manner.  Some
    of the #defines in this entry's code are to mitigate this personal
    deficiency.

    Obfuscation in this entry consists of:

      > printfing console messages stored as EBCDIC character values - this
        is not an attempt at encryption, but rather at cross platform
        compatibility
      > ASCII character values are calculated from the EBCDIC in a
        particularly ugly abuse of the '?' operator
      > detection of whether to print the ASCII or EBCDIC values is done by
        taking the remainder of dividing the character 'J' by 2 - the ASCII
        value of the character is even, the EBCDIC value is odd
      > the messages to be printfed are determined via multiple table
        lookups and bitmasked values
      > for minutes, the bit position turned on is multiplied by two
        to determine the message to be printfed
      > for hours, the straight bit position is used
      > this entry mostly eschews function calls for the often overlooked
        setjmp/longjmp combination
      > the trigraphs are not there as obfuscation nor are they there to
        annoy the judges - it's just the easiest way to get around the
        absence of square brackets in a normal 3270 environment
