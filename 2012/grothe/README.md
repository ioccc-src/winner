## To build:

``` <!---sh-->
    make
```


## To use:

To create a shared secret shared among `M` people with `N+1` needed to reconstruct:

``` <!---sh-->
    ./grothe -secret 1-/dev/urandom 2-/dev/urandom ... \
        N-/dev/urandom 1+shared1 2+shared2 ... M+sharedM
```

To reconstruct the original (an arbitrary combination of `N+1` or
more shared files with their proper numbers):

``` <!---sh-->
    ./grothe I-sharedI J-sharedJ K-sharedK ... +reconstructed
```


## Try:

``` <!---sh-->
    ./try.sh
```


## Judges' remarks:

Also known as 'Best abuse of the judging process'.

The IOCCC 2012 submission page didn't enforce the 2048 meaningful character
limit.  This entry, as submitted, weighed in at 2222 chars but lucky for it, it
was extremely easy to bring down below the limit.  There were a number of
strings that when concatenated allowed the program to slide under the limit.

It was clear to the judges that the extra size was an entry beautification step.
Had it not been, this entry would have been rejected in round 0.

The judges also took some liberty obfuscating this entry a little more.

How does this entry work? The only place multiplication is used is
to perform the `atoi(3)` conversion.


## Author's remarks:

### Description

This program implements a version of [Shamir's Secret
Sharing](http://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing).  Shamir's Secret
Sharing allows you to encrypt a file into `N` parts where it will take `M` parts to
recreate the original file.  E.g. you can split the secret recipe for Crystal Pepsi
into 3 parts and require two of them be available to extract the original recipe.

Actually surprisingly useful for an IOCCC entry :-)


### Usage

To share a secret. For example:

- File to share: [cookie_recipe.txt](cookie_recipe.txt).
- Number of pieces: 2 + file to be shared
- Total number of pieces created by program: 4
- Pieces needed to reassemble recipe: 3 or greater


### Example usage

To split a secret into 4 pieces of which at least 3 will be needed to get it (in
this case the cookie recipe) back:

``` <!---sh-->
    ./grothe \
        -cookie_recipe.txt\
        1-/dev/urandom 2-/dev/urandom\
        1+cookie_piece1.dat 2+cookie_piece2.dat 3+cookie_piece3.dat 4+cookie_piece4.dat
```

To put the recipe back together using the first, second and fourth pieces:

``` <!---sh-->
    ./grothe \
        1-cookie_piece1.dat 2-cookie_piece2.dat 4-cookie_piece4.dat
        +cookie_recipe_restore.txt
```


### Limitations

The program is limited to 256 input and output files and will slow down
dramatically when you get past 20-50 inputs and outputs.

### Obfuscations

* Nothing is done consistently throughout the program E.g `i+=1`, `i=i+1`, `i++`
and `++i` are all used in the program.  The mark of true code buggery: "A
foolish consistency is the hobgoblin of little minds." - [Ralph Waldo
Emerson](https://en.wikipedia.org/wiki/Ralph_Waldo_Emerson)

* Uses the most powerful obfuscation of all "Math".  "Any sufficiently advanced
cryptography is indistinguishable from magic." - Apologies to [Arthur C.
Clarke](https://en.wikipedia.org/wiki/Arthur_C._Clarke)

* Shadows variables by using brackets in main program to create local copies of
variables that are the same as global scope variables.  `-Wshadow` should
probably be a part of `-Wall` in gcc.

* Uses `array_index[array_name]` instead of `array_name[array_index]` in several
places.  Still don't know why C continues to allow this (error strings are
encoded with offsets that are also used to select them in the case statement.
All strings are located in one function for easy localization).

* Liberal use of octal numbers, hexadecimal numbers and regular decimal numbers
throughout the program.

* Variables and function names are semi-random and upper and lower case
characters are used.

* Use of `#define`s from `stdio.h`, `stdlib.h` for values `_STDIO_H` and
`EXIT_SUCCESS` used to represent 1 and 0 respectively in the program.

* Arrays only need to be 256x256 but most are set to greater values than they
need to be so trying to figure it out can be a bit tough.


### References

* David Madore's implementation of Shamir's Secret Sharing - <http://www.madore.org/~david/programs/programs-1.36.html>
* Steve's Recipe Database - source for the $25k Cookie Recipe - <https://www.mealsteps.com>


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
