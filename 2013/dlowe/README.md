# Best sparkling utility

J. David Lowe  
US  
<j.david.lowe@gmail.com>  
<https://github.com/dlowe>

## To build:

```sh
make
```

## To run:

```sh
./dlowe [numbers...]
```

## Try:

```sh
./dlowe 0 1 2 3 4 5 6 7
./dlowe 16 32 64 128

echo sparkline of file sizes: `wc -c * | awk '{print $1}' | xargs ./dlowe`
./dlowe 0 
```

## Judges' remarks:

We liked how this entry used Unicode, specifically UTF-8, in a somewhat obfuscated way. 

Also, why doesn't it crash, and produces a correct output when called with one argument
or when all arguments are equal?

For extra fun, compile and run

```c
#include <stdio.h>
int main() {
    printf("%d %d %d\n", (int)(-1.0/0.0), (int)(0.0/0.0), (int)(1.0/0.0));
}
```

with gcc and clang. 

With GCC (4.7.2), we get 

    -2147483648 -2147483648 -2147483648

and with clang (3.3), we get

    -2147483648 0 2147483647

Which one is correct? :)

## Author's remarks:

### sparkl

A tiny implementation of command-line 'sparkline' data visualization.

### Synopsis

```sh
$ sparkl 0 1 2 3 4 5 6 7
▁▂▃▄▅▆▇▉

$ echo sparkline of file lengths: `wc -c * | awk '{print $1}' | xargs sparkl`
sparkline of file sizes: ▁▁▁▃▃▂▁▂▁▁▉
```

### Description

This is a handy little tool for visualizing numeric series from the
command-line, using 'sparklines'. Pass it a numeric series as arguments, and
sparkl will display a sparkline graph, which you can use to very quickly get a
sense of the shape of your data.

### Limitations

* Crashes with 0 arguments. It'd be trivial to fix, but adds a few bytes to the
  code.
* Produces bogus graphs when given > about 5000 arguments.
* Only works if your terminal is utf-8 and your font supports the 8 glyphs
  used.
* Produces a few harmless compiler warnings.

### Obfuscation

The code is very terse. I was torn between submitting this version, and a
one-line version compressed using a couple more -D flags.

Hand-rolled utf-8 sequence, magic numbers (what's that 7 for?), meaningless
variable names, reused variables, and so on.

### Acknowledgements

Edward Tufte invented sparklines (among other things.) Brilliant.

Zach Holman's ['spark' utility](https://github.com/holman/spark) was absolutely
an inspiration.

As I was writing up this description, I discovered I'm not the first person to
write an obfuscated C sparkline utility! Vicent Martí created
[this one](https://gist.github.com/vmg/1368661) years (!) ago. (My
implementation is completely independent.)

## Copyright and CC BY-SA 4.0 License:

This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
You are free to share and adapt this file under the terms of this license:

    Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

For more information, see: https://creativecommons.org/licenses/by-sa/4.0/
