## To build:

```sh
make
```

An alt version exists for those in the southern hemisphere (or those who want to
see what it would be in the southern hemisphere). See [alternate
version](#alternate-code) below.


## To use:

```sh
./natori
```


### Try:

Try modifying the code so that it will show another Moon phase based on input
or else just by the code itself. Bonus points if you can make it show all!


## Alternate code:

The author noted that those in the southern hemisphere might want to change
`acos(l/2)` into `acos(-l/2)` which we have done in the alternate version.


### Alternate build:

To run the alternate code that supports the southern hemisphere:

```sh
make alt
```


### Alternate use:

```sh
./natori.alt
```

What happens if you run it in the northern hemisphere? Are there any
differences?

Can you identify any Moon phases that result in the same output of both
versions? Or are there any?


## Judges' remarks:

Here is a nice compact program that changes with the phase of the Moon.
Can you figure out how it does it?

The ANSI-C committee, among their multiple misdeeds, broke perfectly
fun C programs by making it intractable for them to declare their
own non-traditional prototype for `main()`.  We have had to uglify this
program in order to try and prevent C compilers form failing to
compile due to the unusual arg types of the `main()` function.


## Author's remarks:

This program outputs a rough image of the moon in its current phase.
The main obfuscation of this entry is its complicated double recursion
(without any loop or conditional statement).

People living in the southern hemisphere may want to change `acos(l/2)`
into `acos(-l/2)`.


## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
