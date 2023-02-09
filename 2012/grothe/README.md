# Most conspiratorial

Aaron Grothe  
2205 South 51st Street  
Omaha, NE 68106  
US  
<ajgrothe@yahoo.com>  

David Madore  
<http://www.madore.org/~david/>  


## Judges' comments:
### To build:

    make grothe

### To run:

    # To create a shared secret shared among M people with N+1 needed to reconstruct
    ./grothe -secret 1-/dev/urandom 2-/dev/urandom ... N-/dev/urandom \
    1+shared1 2+shared2 ... M+sharedM

    # To reconstruct the original (an arbitrary combination of N+1 or
    # more shared files with their proper numbers)
    ./grothe I-sharedI J-sharedJ K-sharedK ... +reconstructed

### Try:

    ./grothe -grothe.c 1+grothe.c.1 2+grothe.c.2

    ./grothe -cookie_recipe.txt 1-/dev/urandom 2-/dev/urandom \
    1+cookie_piece1.dat 2+cookie_piece2.dat 3+cookie_piece3.dat 4+cookie_piece4.dat

    ./grothe 1-cookie_piece1.dat 2-cookie_piece2.dat 4-cookie_piece4.dat
    +cookie_recipe_restore.txt

### Selected Judges Remarks:

Also known as Best abuse of the judging process.

The IOCCC 2012 submission page didn't enforce the 2048 meaningful
character limit.  This entry, as submitted, weighed in at 2222 chars
but was, luckily for it, extremely easy to bring down below the
limit.  There were a number of strings that when concatenated allowed
the program to slide under the limit.

It was clear to the judges that the extra size was an entry
beautification step.  Had it not, this entry would have been
rejected in round 0.

The judges also took some liberty obfuscating this entry a litte more.

How does this entry work? The only place multiplication is used is
to perform the atoi conversion.


## Author's comments:
**Description**

This program implements a version of Shamir's Secret Sharing.  Shamir's Secret
Sharing allows you to encrypt a file into N parts where it will take M parts to
recreate the original file.  E.g. you can split the secret recipe for Crystal Pepsi
into 3 parts and require two of them be available to extract the original recipe.

Actually surprisingly useful for an IOCCC entry :-)

**Usage**

To share a secret

E.g.

file to be shared - cookie\_recipe.txt
number of pieces - 2 + file to be shared
total number of pieces created by program 4
pieces needed to reassemble recipe 3 or greater

**example usage**

\# to share secret into 4 pieces of which at least 3 will be needed to get back the recipe

    ./grothe \
        -cookie_recipe.txt 
        1-/dev/urandom 2-/dev/urandom 
        1+cookie_piece1.dat 2+cookie_piece2.dat 3+cookie_piece3.dat 4+cookie_piece4.dat

\# put recipe back together using 1, 2 and 4th piece

    ./grothe \
        1-cookie_piece1.dat 2-cookie_piece2.dat 4-cookie_piece4.dat
        +cookie_recipe_restore.txt

**Limitations**

* program is limited to 256 input and output files and will slow down dramatically when you get past 20-50 inputs and outputs

**Obfuscations**

* nothing is done consistently throughout the program E.g i+=1, i=i+1, i++ and ++i are all used in the program.  The mark of true code buggery. - "A foolish consistency is the hobgoblin of little minds" - Ralph Waldo Emerson
* uses the most powerful obfuscation of all "Math".  "Any sufficiently advanced cryptography is indistinguasble from magic" - Apologies to Arthur C. Clarke
* shadows variables by using brackets in main program to create local copies of variables that are the same as global scope variables.  -Wshadow should probably be a part of -Wall in gcc
* uses array\_index[array\_name] instead of array\_name[array\_index] in several places.  Still don't know why C continues to allow this
( error strings are encoded with offsets that are also used to select them in the case statement.  All strings are located in one function for easy localization
* liberal use of octal numbers, hexadecimal numbers and regular decimal numbers throughout program
* variables and function names are semi-random and upper and lower case characters are used
* use of #defines from stdio.h, stdlib.h for values \_STDIO\_H and EXIT\_SUCCESS used to represent 1 and 0 respectively in the program
* arrays only need to be 256x256 most are set to greater values than they need to be so trying to figure it out can be a bit tough

**References**

* Shamir's Secret Sharing - <a href="http://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing">http://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing</a>
* David Madore's implementation of Shamir's Secret Sharing - <a href="http://www.madore.org/~david/programs/programs-1.36.html">http://www.madore.org/~david/programs/programs-1.36.html</a>
* Steve's Recipe Database - source for the $25k Cookie Recipe - <a href="http://recipes.stevex.net/">http://recipes.stevex.net/</a>

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
