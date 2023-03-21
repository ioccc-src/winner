# Best Small Program:

NATORI Shin
Univ. of Tokyo
Rigakubu 7-goukan 311
Hongou 7-3-1, Bunkyou-ku, Tokyo
Japan

# To build:

```sh
make
```

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this so that it
works with modern compilers. Depending on the compiler it would either segfault
when run or not compile at all (gcc and clang respectively). Thank you Cody for
your assistance!


### To run:

```sh
./natori
```

### Try:

```sh
echo "Do or do not. There is no try."
```

## Judges' comments:

Here is a nice compact program that changes with the phase of the moon.
Can you figure out how it does it?

The ANSI-C committee, among their multiple misdeeds, broke perfectly
fun C programs by making it intractable for them to declare their
own non-traditional prototype for main().  We have had uglify this
program in order to try and prevent C compilers form failing to
compile due to the unusual arg types of the main() function.

## Author's comments:

This program outputs a rough image of the moon in its current phase.
The main obfuscation of this entry is its complicated double recursion
(without any loop or conditional statement).

People living in the southern hemisphere may want to change acos(l/2)
into acos(-l/2).
