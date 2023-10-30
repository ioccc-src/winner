# 1998

## [1998/schnitzi](1998/schnitzi/schnitzi.c) ([README.md](1998/schnitzi/README.md))
### STATUS: INABIAF - please **DO NOT** fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed this to work for
modern systems but he notes a couple compile warnings to ignore.

First if you get the warning:

	warning: incompatible implicit declaration of built-in function 'printf' [-Wbuiltin-declaration-mismatch]
	   11 | void  g(){ O=j; printf(_); }
	      |                 ^~~~~~


please do NOT change it! Doing so will break the generated output.

Another warning that was introduced but should be ignored (it's required) is:


	warning: assignment to 'char *' from incompatible pointer type 'char **' [-Wincompatible-pointer-types]
	   55 | main(int v,char **c){ O=r_; _d=c;
	      |                               ^

Please DO NOT change this either.

If there are any other warnings triggered by your compiler please DO NOT fix
those either!

Another important note is that as the number passed into the program gets bigger
the number of lines of output gets substantially larger. For instance:

```sh
$ ./schnitzi 9|wc -l
  771999
```


# 1999

There was no IOCCC in 1999.

# 2000

[2000/primenum](2000/primenum/primenum.c) ([README.md](2000/primenum/README.md))
### STATUS: INABIAF - please **DO NOT** fix

This program does not do what you might think it does! Running it like:

```sh
./primenum 13
```

will seemingly wait for input exactly because it is waiting for input. See the
README.md file or look at the source.

It also has main() return void even though this is non-standard. Please do not
fix this (in fact it was originally done but rolled back).


# 2001


## [2001/bellard](2001/bellard/bellard.c) ([README.md](2001/bellard/README.md))
### STATUS: probable bug (possibly depending on system) - please help test and if necessary fix

[Cody Boone Ferguson](/winners.html#Cody_Boone_Ferguson) fixed an initial
segfault and he also fixed the [supplementary
program bellard.otccex.c](2001/bellard/bellard.otccex.c) to test the entry on to not segfault and
seemingly work but he has no 32-bit system to test any further fixes; we
would greatly appreciate anyone's help! It appears that this entry will require
major debugging and to make it work one might need to have a deep understanding
of the ELF format.

The author said that they compiled it with [gcc version
2.95.2](https://ftp.gnu.org/gnu/gcc/gcc-2.95.2/gcc-everything-2.95.2.tar.gz). We don't know if
a certain gcc version is necessary but it might be helpful to download and
compile that version to test it.

## [2001/westley](2001/westley/westley.c) ([README.md](2001/westley/README.md))
### STATUS: missing files - please provide them

The author referred to the file `card.gif` but this appears to be missing. Do
you have it? If you do please provide it and thank you!

### STATUS: uses gets() - change to fgets() if possible (in some cases getline() works)

The code also uses `gets()` which, without redirecting stderr to `/dev/null`,
can show an obnoxious warning every time it's run. In the script
[2001/westley/westley.sh](2001/westley/westley.sh) that [Cody Boone
Ferguson](/winners.html#Cody_Boone_Ferguson) added stderr is in fact redirected
to `/dev/null` to prevent this warning but it would probably be better if it was
changed to use `fgets()` (which he might end up doing).


# 2002

There was no IOCCC in 2002.

# 2003

There was no IOCCC in 2003.
