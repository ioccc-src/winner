Best Self-Documenting:

    Tom Torfs
    De Nayer Instituut
    Cuperuslei 12          (home address)
    2220 Heist-op-den-Berg
    Belgium

    http://members.xoom.com/tomtorfs


Judges' comments:

    To build:

	make tomtorfs

    To use:

	./tomtorfs tomtorfs.c 32 04C11DB7 1 FFFFFFFF FFFFFFFF

    Also try:

	echo "abscond conferrable" > file.A
	echo "adorn condolence" > file.B
	echo "adorn condolence too" > file.C
	./tomtorfs file.A 32 04C11DB7 1 FFFFFFFF FFFFFFFF
	./tomtorfs file.B 32 04C11DB7 1 FFFFFFFF FFFFFFFF
	./tomtorfs file.C 32 04C11DB7 1 FFFFFFFF FFFFFFFF

    If you don't believe the program is correct, try and compare the output
    of the program with the value of CRC computed by PKZIP or any other
    archiver that uses the CRC-32 algorithm.


Selected author's comments:

    Usage:
       crc filename bitwidth polynom reflected init xor

       filename  : file to calculate the CRC of
       bitwidth  : width of the CRC in bits (decimal)
       polynom   : polynomial used for the CRC (hexadecimal)
       reflected : 0 if the CRC is not reflected, 1 if it is
       init      : initial value for the CRC (hexadecimal)
       xor       : value to xor the final CRC with (hexadecimal)

    Examples:

       CRC-16: crc filename 16 1021 0 FFFF 0000
       CRC-32: crc filename 32 04C11DB7 1 FFFFFFFF FFFFFFFF
       XMODEM: crc filename 16 8408 1 0000 0000
       ARC:    crc filename 16 8005 1 0000 0000

    Portability notes:

       The program assumes CHAR_BIT==8. Results are undefined if
       bitwidth > sizeof(unsigned long) * 8. It is also assumed
       that EOF is -1 and 1 is a valid exit value to indicate
       failure (replace them with EOF resp. EXIT_FAILURE if the
       assumptions are false). Otherwise ANSI/ISO C.
       No special build options required.

    Special notes:

       Count the number of non-whitespace characters in the source
       file to find out what dark force drove me to write this ;-).

    Spoiler:

       First of all, if you run a C beautifier on the program
       (thereby of course losing the nice code shape I worked
        so hard on ;-) the code will become a bit more readable.

       The variable names are not very descriptive. They have the
       following meanings:
          a = argc
          A = argv
          b = array of unsigned long variables
              b[0] = bit-width of the CRC (argv[2])
              b[1] = CRC polynomial (argv[3])
              b[2] = nonzero if CRC is reflected (argv[4])
              b[3] = initial value of CRC (argv[5])
              b[4] = value final CRC is XORed with (argv[6])
              b[5] = CRC value
              b[6] = byte from file
              b[7] = counter
          B = FILE * through which the file argv[1] is opened
          C = typedef for unsigned long

       The first for loop simply reads the command-line arguments
       in the b[] array. The third parameter to strtoul() causes
       all arguments to be in base-16 (hex) except the first one,
       which will be in base-10 (decimal).

       The rest of the program "simply" calculates the crc in b[5]
       and then prints it to stdout. The bit reflection loops may
       appear a bit tricky at first, but if you have a good look
       at them they should become obvious also.

    Acknowledgments:

       Ross N. Williams, whose CRC guide was very useful to me
       for writing this. You can find it as CRC.TXT in Snippets.
