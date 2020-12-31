# Best data utility

Szabolcs Borsanyi  
Theoretische Physik  
Gaussstraﬂe 20  
42097 Wuppertal  
Germany  
<borsanyi@uni-wuppertal.de>  


## Judges' comments:
### To build:

    make borsanyi

### To run:

    ./borsanyi < some_data_file

### Try:

    ./borsanyi < data.1
    ./borsanyi < data.2
    ./borsanyi < data.3

### Selected Judges Remarks:

This is a nice quick histogram plotter.  A useful utility when you need to
look at the distribution of some data.

Here are some challenges:

You can modify the number of histogram bins and the scaling of the histogram
by editing the source.  Try to find them!

If you look at the source you will notice that the usual array of
histogram bins is missing. The source contains no arrays and it does not
use malloc or alloca. How does it build the histogram?

While the input does not need to be sorted, the histogram output is sorted.
How does it put the data into buckets?  Why does it fork 22 times?

## Author's comments:
This small piece of program is meant to be a useful tool, when
there are some data around and you need a quick glance at the
histogram. I am all too often logged in to a remote machine with
slow X connection, and a terminal-based program would be of
great help.

# Limitations:

* I optimized the output for the data I had around, you might want to adjust
  for your needs. For a great excess of data points the program will crash
  (depending on the available stack).
* Giving too few (distinct) points can also cause crash (or division by zero).
* The program expects plain numbers separated by white spaces.
* ASCII is assumed. 
* Some POSIX-like system is assumed (fork and wait(NULL) are used)
* Do not give any arguments to the program.
* Could rounding errors cause the omission of the highest bin? There might be
  empty bins at the edges.

# Obfuscation:

* The program follows a rather unconventional approach to the task
  of histogram building. The usual array of integers (for the histogram
  bins) is missing entirely. The data are read once, the range is determined,
  but the data points are not put in any array. Yet they are remembered,
  and each of them is put into its own bin afterwards. But where are the bins?
* I tried to use as few keywords as possible, hence there are no loops.
* Multi-process approach for optimal use of resources.
* Some bin size obfuscation.

--------------------------------------------------------------------------------
<!--
(c) Copyright 1984-2012, [Leo Broukhis, Simon Cooper, Landon Curt Noll][judges] - All rights reserved
This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License][cc].

[judges]: http://www.ioccc.org/judges.html
[cc]: http://creativecommons.org/licenses/by-sa/3.0/
-->
