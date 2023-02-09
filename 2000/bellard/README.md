Most Specific Output:

    Fabrice Bellard
    451 chemin du mas de Matour
    34790 Grabels
    France

    http://www.enst.fr/~bellard


Judges' Comments:

    To build:

	make bellard

    To run:

	./bellard

    This code is an nice compact example of a Modular Fast Fourier Transform.
    While its output is very specific, the internal FFT has a wide variety
    of uses.

    Can you modify this code to produce primes such as 23523*2^70000-1,
    48594^65536+1 or 6917!-1?


Selected Author's Comments:

    This program prints the biggest known prime number (2^6972593-1)
    in base 10. It requires a few minutes. It uses a Modular Fast
    Fourier Transform to compute this number in a reasonable amount
    of time (the usual method would take ages !).

    The program uses >= 64 bit 'long long' type. It should run on any
    system with a gcc compiler.

