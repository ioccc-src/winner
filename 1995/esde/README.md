Interesting Algorithm:

    Sebastian Deorowicz
    ul. Radzionkowska 71a
    42-605 Tarnowskie Gory 
    Poland


Judges' comments:

    To use:
	make esde

    Try: 
	esde esde.data Johanson
	esde esde.data2 read
	esde esde.hint date

    In general:

	esde data-file word

    where data-file contains lines of < 255 chars in length.

    When reading the source be careful to distinguish between variable
    names and library functions.  
    
    If you still don't know what it does, try:

	http://avian.dars.muohio.edu/~kaelbesa/soundex.html
	http://avian.dars.muohio.edu/~kaelbesa/coder.html


Selected notes from the author:

    0) what this program does.
       This program searches in the file words which have the same Soundex code
       like the given word, and print out lines with these words.

       The Soundex code is using to find similar sounds words.

       Soundex code begins with the first letter of the word followed by a
       three-digit code. There is the algorithm:

       a) Every letter in the word change by a digit (excluding the first
          letter).
       b) Replace all pairs of the same code by single code
          (ex. R011235 -> R01235).
       c) Remove all 0-codes (ex. R01235 -> R1235).
       d) If lenght of code is > 4, get only first 4 codes (ex. R1235 -> R123).
       e) If lenght of code is < 4, add zeros (ex. T12 -> T120).

       There is the codes:
              0  =  A, E, H, I, O, U, W, Y
              1  =  B, P, F, V
              2  =  C, S, G, J, K, Q, X, Z
              3  =  D, T
              4  =  L
              5  =  M, N
              6  =  R

    1) information about an info file.
       An info file should be a text file consisting of lines (max. 256 bytes
       in each line).
