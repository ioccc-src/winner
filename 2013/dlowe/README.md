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
./dlowe 16 32 64 128 256
./dlowe 16 32 64 128 256 512

echo "sparkline of file sizes: $(wc -c * | awk '{print $1}' | xargs ./dlowe)" # or ./slen.sh

./dlowe 0 

echo "sparkline of file sizes: $(wc -c * | awk '{print $1}' | xargs ./dlowe)" # or ./slen.sh
```

Alternatively, for the lazy or those short on time, try:

```sh
./demo.sh
```

What is different about the above if you do something like:

```sh
echo 'IOCCC 2013' > ioccc.txt
./demo.sh
rm -f ioccc.txt
```


To make it simpler to see try showing just the last two lines:

```sh
./demo.sh | tail -n 2 > 1.txt
echo 'IOCCC 2013' > ioccc.txt
./demo.sh | tail -n 2 > 2.txt
rm -f ioccc.txt
diff 1.txt 2.txt
rm 1.txt 2.txt
```

## INABIAF - it's not a bug it's a feature! :-)

This program will very likely crash or draw something funny with 0 args. Then
again it might not. :-) This is not a bug and should NOT be fixed.

Ask yourself the following questions: when will it crash, when will it draw
something funny (or will it ? :-) ) and when will it do nothing?


## Judges' remarks:

We liked how this entry used Unicode, specifically UTF-8, in a somewhat obfuscated way. 

Also, why doesn't it crash, and produces a correct output when called with one argument
or when all arguments are equal?

For extra fun, compile and run [fun.c](fun.c):

```c
#include <stdio.h>
int main() {
    printf("%d %d %d\n", (int)(-1.0/0.0), (int)(0.0/0.0), (int)(1.0/0.0));
}
```

with gcc and clang. 


With GCC (4.7.2), we get 

```
-2147483648 -2147483648 -2147483648
```

and with clang (3.3), we get

```
-2147483648 0 2147483647
```

and with Apple clang version 15.0.0 (clang-1500.0.40.1) we get:

```
1840985120 -2033041452 35979112
```

Which one is correct? :)

NOTE: `make all` will compile [fun.c](fun.c) but to provide a different compiler
you can do something like:


```sh
make CC=clang fun
```


## Author's remarks:

### sparkl

A tiny implementation of command-line
[sparkline](https://en.wikipedia.org/wiki/Sparkline) data visualization.

### Synopsis

```sh
$ ./sparkl 0 1 2 3 4 5 6 7
▁▂▃▄▅▆▇▉

$ echo "sparkline of file lengths: $(wc -c * | awk '{print $1}' | xargs ./sparkl)"
sparkline of file sizes: ▁▁▁▃▃▂▁▂▁▁▉
```

NOTE: this has been provided in [slen.sh](slen.sh) so you can try:

```sh
./slen.sh
```

instead.

### Description

This is a handy little tool for visualizing numeric series from the
command line, using sparklines. Pass it a numeric series as arguments, and
`sparkl` will display a sparkline graph, which you can use to very quickly get a
sense of the shape of your data.

### Limitations

* Crashes with 0 arguments. It'd be trivial to fix, but adds a few bytes to the
  code.
* Produces bogus graphs when given > about 5000 arguments.
* Only works if your terminal is UTF-8 and your font supports the 8 glyphs
  used.
* Produces a few harmless compiler warnings.

### Obfuscation

The code is very terse. I was torn between submitting this version, and a
one-line version compressed using a couple more -D flags.

Hand-rolled UTF-8 sequence, magic numbers (what's that 7 for?), meaningless
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
