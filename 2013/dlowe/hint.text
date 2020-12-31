# Best sparkling utility

J. David Lowe  
434 Tenney Drive  
Rogue River, OR  
97537  
<j.david.lowe@gmail.com>  
<http://www.pootpoot.net/>  


## Judges' comments:
### To build:

    make dlowe

### To run:

    ./dlowe [numbers...]

### Try:

    ./dlowe 0 1 2 3 4 5 6 7
    ./dlowe 16 32 64 128

    echo sparkline of file sizes: `wc -c * | awk '{print $1}' | xargs ./dlowe`

    ./dlowe 0 


### Selected Judges Remarks:

We liked how this entry used Unicode, specifically UTF-8, in a somewhat obfuscated way. 

Also, why doesn't it crash, and produces a correct output when called with one argument
or when all arguments are equal?

For extra fun, compile and run

    #include <stdio.h>
    int main() {
        printf("%d %d %d\n", (int)(-1.0/0.0), (int)(0.0/0.0), (int)(1.0/0.0));
    }

with gcc and clang. 

With GCC (4.7.2), we get 

    -2147483648 -2147483648 -2147483648

and with clang (3.3), we get

    -2147483648 0 2147483647

Which one is correct? :)


## Author's comments:
# sparkl

A tiny implementation of command-line 'sparkline' data visualization.

## Synopsis

    $ sparkl 0 1 2 3 4 5 6 7
    ▁▂▃▄▅▆▇▉

    $ echo sparkline of file lengths: `wc -c * | awk '{print $1}' | xargs sparkl`
    sparkline of file sizes: ▁▁▁▃▃▂▁▂▁▁▉

## Description

This is a handy little tool for visualizing numeric series from the
command-line, using 'sparklines'. Pass it a numeric series as arguments, and
sparkl will display a sparkline graph, which you can use to very quickly get a
sense of the shape of your data.

## Limitations

* Crashes with 0 arguments. It'd be trivial to fix, but adds a few bytes to the
  code.
* Produces bogus graphs when given > about 5000 arguments.
* Only works if your terminal is utf-8 and your font supports the 8 glyphs
  used.
* Produces a few harmless compiler warnings.

## Obfuscation

The code is very terse. I was torn between submitting this version, and a
one-line version compressed using a couple more -D flags.

Hand-rolled utf-8 sequence, magic numbers (what's that 7 for?), meaningless
variable names, reused variables, and so on.

## Acknowledgements

Edward Tufte invented sparklines (among other things.) Brilliant.

Zach Holman's ['spark' utility](https://github.com/holman/spark) was absolutely
an inspiration.

As I was writing up this description, I discovered I'm not the first person to
write an obfuscated C sparkline utility! Vicent Martí created
[this one](https://gist.github.com/vmg/1368661) years (!) ago. (My
implementation is completely independent.)

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2015, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
